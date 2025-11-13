import 'package:just_audio/just_audio.dart';


class AudioPlayerService {

final _player = AudioPlayer();


//we can track what phase we are in
final _playlistResonantBreath = <AudioSource>[
  AudioSource.asset('assets/audio/i6.wav'),
  AudioSource.asset('assets/audio/hold2.wav'),
  AudioSource.asset('assets/audio/e9.wav'),
  AudioSource.asset('assets/audio/hold2.wav'),
];


Future<void> myService() async {
  await _player.setAudioSources(
    _playlistResonantBreath, 
    initialIndex: 0, 
    initialPosition: Duration.zero,
  shuffleOrder: DefaultShuffleOrder(),
  );
  await _player.setLoopMode(LoopMode.all);
}

// --- PUBLIC method that the UI can call ---
Future<void> play() async {
  await _player.play();

}

  // --- ANOTHER PUBLIC method for the UI ---
Future<void> stop() async {
  await _player.stop();
    // After stopping, we should reset the player to the beginning
    // so it's ready for the next time play is pressed.
  await _player.seek(Duration.zero);

}

  // --- A method to clean up when we're done ---
void dispose() {
  _player.dispose();
}
}