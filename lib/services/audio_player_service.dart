
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart'; // Import rxdart for CombineLatestStream
import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/model/playback_state.dart';


class AudioPlayerService {
  final _player = just_audio.AudioPlayer();
  final _isTimerActive = BehaviorSubject<bool>.seeded(false);

  just_audio.AudioPlayer get player => _player;

  // - Playback state stream

  Stream<PlaybackState> get playbackStateStream =>
      Rx.combineLatest2<bool, bool, PlaybackState>(
        _player.playerStateStream.map((s) => 
          s.playing &&
          s.processingState != just_audio.ProcessingState.loading &&
          s.processingState != just_audio.ProcessingState.buffering),
        _isTimerActive.stream,
        (isPlaying, isTimerActive) => PlaybackState(
          isPlaying: isPlaying,
          isTimerActive: isTimerActive,
        ),
      );

// - Position data (unchanged)

  Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
          (position, bufferedPosition, duration) => 
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
        );

// - Timer control 

  Stream<just_audio.SequenceState?> get sequenceStateStream =>
    _player.sequenceStateStream;

  bool get hasNext => _player.hasNext;
  bool get hasPrevious => _player.hasPrevious;

  void setTimerActive(bool active) => _isTimerActive.add(active);

// - Playback Control

  Future<void> play() async {
    await _init();
    await _player.play();
  }

  Future<void> pause() async => _player.pause();

  Future<void> stop() async {
    _isTimerActive.add(false); // Ensure timer is deactivated when stopping
    await _player.stop();
    await _player.seek(Duration.zero); // Reset to the beginning
    final session = await AudioSession.instance;
    await session.setActive(false);
  }

  Future<void> seek(Duration position) async => _player.seek(position);
  Future<void> seekToNext() async => _player.seekToNext();
  Future<void> seekToPrevious() async => _player.seekToPrevious();

  Future<void> loadPlaylist(Playlist playlist, {int innitialIndex = 0}) async {
    await _player.stop();
    final sources = playlist.audioAssets
        .map((path) => just_audio.AudioSource.asset(path))
        .toList();
    await _player.setAudioSources(sources, initialIndex: innitialIndex);
    await _player.setLoopMode(just_audio.LoopMode.all); // Gapless Repeat
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.music());
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        _player.pause();
      } else {
        _player.play();
      }
    });
    session.becomingNoisyEventStream.listen((_) => _player.pause());
  }

  // --- A method to clean up when we're done ---
  void dispose() {
    _isTimerActive.close();
    _player.dispose();
    AudioSession.instance.then((s) => s.setActive(false));
  }
}

// - Postion data

class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

}