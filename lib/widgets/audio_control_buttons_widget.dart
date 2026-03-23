import 'package:equanimity/services/audio_player_service.dart';
import 'package:equanimity/widgets/gradient_star_button_view.dart';
import 'package:equanimity/widgets/styled_audio_button.dart';
import 'package:flutter/material.dart';
import 'package:equanimity/model/playback_state.dart';

class AudioControlButtons extends StatelessWidget {
  final AudioPlayerService audioService;
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback startTimer;

  const AudioControlButtons({
    super.key,
    required this.audioService,
    required this.onPlay,
    required this.onStop,
    required this.startTimer,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PlaybackState>(
      stream: audioService.playbackStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? const PlaybackState(
          isPlaying: false,
          isTimerActive: false,
        );
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AudioControlButton(
            label: 'Play',
            onPressed: onPlay,
            isActive: state.isPlaying,
          ),
          const SizedBox(width: 20),
          GradientStarButton(
            label: 'Stop',
            onPressed: onStop,
            isActive: state.isStopped,
          ),
          const SizedBox(width: 20),
          AudioControlButton(
            label: 'Timer',
            onPressed: startTimer,
            isActive: state.isTimerActive,
          ),
        ],
      ),
    );
  },
);  
}}