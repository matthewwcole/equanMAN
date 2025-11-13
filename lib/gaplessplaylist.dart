import 'package:breathingcompanion/UI/audio_control_buttons.dart';
import 'package:flutter/material.dart';
import 'services/audio_player_service.dart';


class GaplessPlaylist extends StatefulWidget {
  const GaplessPlaylist({super.key});

  @override
  State<GaplessPlaylist> createState() => _GaplessPlaylistState();
}

class _GaplessPlaylistState extends State<GaplessPlaylist> {

final _audioService = AudioPlayerService();

@override
void initState() {
  super.initState();
  _audioService.myService();
}

  void _onPlayPressed() async {
    await _audioService.play();
  }

  void _onStopPressed() async {
    await _audioService.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AudioControlButtons(
          onPlay: _onPlayPressed, 
          onStop: _onStopPressed) 
      ),
    );
  }
}