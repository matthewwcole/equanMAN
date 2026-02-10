import 'package:flutter/material.dart';

enum PlayerState { playing, stopped, timer }

class AudioControlButtons extends StatefulWidget {
  // Define two final VoidCallback variables here (one for play, one for stop, timer)
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback startTimer;

  // Constructor that requires those two callbacks
  const AudioControlButtons({
    super.key,
    required this.onPlay,
    required this.onStop,
    required this.startTimer,
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
          ElevatedButton(
            onPressed: _handlePlay,
            style: ElevatedButton.styleFrom(
              backgroundColor: _playerState == PlayerState.playing
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              foregroundColor: Colors.white,
              fixedSize: const Size(100, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Play',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _handleStop,
            style: ElevatedButton.styleFrom(
              backgroundColor: _playerState == PlayerState.stopped
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              foregroundColor: Colors.white,
              fixedSize: const Size(100, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Stop',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: _handleTimer,
            style: ElevatedButton.styleFrom(
              backgroundColor: _playerState == PlayerState.timer
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              foregroundColor: Colors.white,
              fixedSize: const Size(100, 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text(
              'Timer',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
