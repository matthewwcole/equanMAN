import 'package:equanimity/services/audio_player_service.dart';
import 'package:equanimity/widgets/gradient_star_button_view.dart';
import 'package:equanimity/widgets/styled_audio_button.dart';
import 'package:flutter/material.dart';

class AudioControlButtons extends StatefulWidget {
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback startTimer;

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
    setState(() => _playerState = PlayerState.playing);
    widget.onPlay();
  }

  void _handleStop() {
    setState(() => _playerState = PlayerState.stopped);
    widget.onStop();
  }

  void _handleTimer() {
    setState(() => _playerState = PlayerState.timer);
    widget.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AudioControlButton(
            label: 'Play',
            onPressed: _handlePlay,
            isActive: _playerState == PlayerState.playing,
          ),
          const SizedBox(width: 20),
          GradientStarButton(
            label: 'Stop',
            onPressed: _handleStop,
            isActive: _playerState == PlayerState.stopped,
          ),
          const SizedBox(width: 20),
          AudioControlButton(
            label: 'Timer',
            onPressed: _handleTimer,
            isActive: _playerState == PlayerState.timer,
          ),
        ],
      ),
    );
  }
}