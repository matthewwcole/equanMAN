import 'package:flutter/material.dart';
import 'package:breathingcompanion/view/neumorphic_button.dart';

enum PlayerState {
  playing,
  stopped,
  timer,
}

class AudioControlButtons extends StatefulWidget{
  
  // Define two final VoidCallback variables here (one for play, one for stop, timer)
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback startTimer;
  
  // Constructor that requires those two callbacks
  const AudioControlButtons({
    super.key, 
    required this.onPlay, 
    required this.onStop,
    required this.startTimer
    });

  @override
  State<AudioControlButtons> createState() => _AudioControlButtonsState();
}

class _AudioControlButtonsState extends State<AudioControlButtons> {
  PlayerState _playerState = PlayerState.stopped;

  void _handlePlay() {
    setState(() {
      _playerState = PlayerState.playing;
    });
    widget.onPlay();
  }

  void _handleStop() {
    setState(() {
      _playerState = PlayerState.stopped;
    });
    widget.onStop();
  }

  void _handleTimer() {
    setState(() {
      _playerState = PlayerState.timer;
    });
    widget.startTimer();
  }
  
// build method with your two ElevatedButtons
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          NeumorphicButton(
            onPressed: _handlePlay,
            text: 'Play',
            isPlaying: _playerState == PlayerState.playing,
          ),
          const SizedBox(width: 20),
          NeumorphicButton(
            onPressed: _handleStop,
            text: 'Stop',
            isPlaying: _playerState == PlayerState.stopped,
          ),
          const SizedBox(width: 20),
          NeumorphicButton(
            onPressed: _handleTimer,
            text: 'Timer',
          ),
        ],
      ),
    );
  }
}