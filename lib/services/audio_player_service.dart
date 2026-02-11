import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart'; // Import rxdart for CombineLatestStream
import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/model/position_data.dart';
import 'package:equanimity/model/player_state.dart';

class AudioPlayerService {
  final _player = just_audio.AudioPlayer();

  just_audio.AudioPlayer get player => _player;

  Stream<PlayerState> get playerStateStream => _player.playerStateStream.map((s) {
    if (s.processingState == just_audio.ProcessingState.loading || s.processingState == just_audio.ProcessingState.buffering) {
      return PlayerState.stopped; // Or a loading state if you introduce one
    } else if (s.playing) {
      return PlayerState.playing;
    } else {
      return PlayerState.stopped;
    }
  });
  Stream<just_audio.SequenceState?> get sequenceStateStream => _player.sequenceStateStream;
  bool get hasNext => _player.hasNext;
  bool get hasPrevious => _player.hasPrevious;

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  Future<void> loadPlaylist(Playlist playlist, {int initialIndex = 0}) async {
    await _player.stop(); // Stop current playback

    final sources = playlist.audioAssets
        .map((path) => just_audio.AudioSource.asset(path))
        .toList();

    await _player.setAudioSources(sources, initialIndex: initialIndex);
    await _player.setLoopMode(just_audio.LoopMode.all); // Gapless Repeat
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    // Listen to interruptions and audio becoming noisy
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            _player.pause();
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            _player.play();
            break;
        }
      }
    });
    session.becomingNoisyEventStream.listen((_) {
      _player.pause();
    });
  }

  Future<void> play() async {
    await _init();
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  Future<void> seekToNext() async {
    await _player.seekToNext();
  }

  Future<void> seekToPrevious() async {
    await _player.seekToPrevious();
  }

  // --- ANOTHER PUBLIC method for the UI ---
  Future<void> stop() async {
    await _player.stop();
    // After stopping, we should reset the player to the beginning
    // so it's ready for the next time play is pressed.
    await _player.seek(Duration.zero);
    final session = await AudioSession.instance;
    await session.setActive(false);
  }

  // --- A method to clean up when we're done ---
  void dispose() {
    _player.dispose();
    AudioSession.instance.then((session) => session.setActive(false));
  }
}
