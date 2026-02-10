import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';
import 'package:rxdart/rxdart.dart'; // Import rxdart for CombineLatestStream

/// A class to hold the current position, buffered position, and total duration of the audio.
class PositionData {
  const PositionData(this.position, this.bufferedPosition, this.duration);
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class Playlist {
  final String title;
  final List<String> audioAssets;

  Playlist({required this.title, required this.audioAssets});

  static final List<Playlist> allPlaylists = [
    Playlist(
      title: 'Resonant Breath 6-0-9-0',
      audioAssets: ['assets/audio/i6.wav', 'assets/audio/e9.wav'],
    ),
    Playlist(
      title: 'Resonant Breath 6-2-9-2',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold2.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold2.wav',
      ],
    ),
    Playlist(
      title: 'Resonant Breath 6-5-9-5',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold5.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold5.wav',
      ],
    ),
    Playlist(
      title: 'Resonant Breath 6-8-9-8',
      audioAssets: [
        'assets/audio/i6.wav',
        'assets/audio/hold8.wav',
        'assets/audio/e9.wav',
        'assets/audio/hold8.wav',
      ],
    ),
    // You can add more playlists here
  ];
}

class AudioPlayerService {
  final _player = AudioPlayer();

  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  Stream<SequenceState?> get sequenceStateStream => _player.sequenceStateStream;
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
        .map((path) => AudioSource.asset(path))
        .toList();

    await _player.setAudioSources(sources, initialIndex: initialIndex);
    await _player.setLoopMode(LoopMode.all); // Gapless Repeat
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
