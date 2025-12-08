import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart';

class AudioPlayerService {
  final _player = AudioPlayer();

  //we can track what phase we are in
  final _playlistResonantBreath = <AudioSource>[
    AudioSource.asset('assets/audio/i6.wav'),
    AudioSource.asset('assets/audio/hold2.wav'),
    AudioSource.asset('assets/audio/e9.wav'),
    AudioSource.asset('assets/audio/hold2.wav'),
  ];

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

    await _player.setAudioSources(
      _playlistResonantBreath,
      initialIndex: 0,
      initialPosition: Duration.zero,
    );
    await _player.setLoopMode(LoopMode.all);
  }

  Future<void> play() async {
    await _init();
    await _player.play();
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
