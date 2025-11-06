import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class GaplessPlaylist extends StatefulWidget {
  const GaplessPlaylist({super.key});

  @override
  State<GaplessPlaylist> createState() => _GaplessPlaylistState();
}

class _GaplessPlaylistState extends State<GaplessPlaylist> {

final player = AudioPlayer();
bool _isPlaying = false;

//we can track what phase we are in

final playlistBreathing = <AudioSource>[
  AudioSource.asset('assets/audio/e9.wav'),
  AudioSource.asset('assets/audio/hold2.wav'),
  AudioSource.asset('assets/audio/i6.wav'),
  AudioSource.asset('assets/audio/hold2.wav'),
];

Future<void> playBreathing() async {
  await player.setAudioSources(
    playlistBreathing, 
    initialIndex: 0, 
    initialPosition: Duration.zero,
  shuffleOrder: DefaultShuffleOrder(),
  );

  await player.setLoopMode(LoopMode.all); // Loop the entire playlist
  await player.play();
}



  void _onPlayPressed() {
    if (!_isPlaying) {
      _isPlaying = true;
      playBreathing();
    }
  }

  void _onStopPressed() {
    _isPlaying = false;
    player.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onPlayPressed,
              child: const Text('Play')
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _onStopPressed,
              child: const Text('Stop')
            ),
          ],
        ),
      ),
    );
  }


}