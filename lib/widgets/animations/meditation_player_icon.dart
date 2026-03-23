
import 'package:flutter/material.dart';

// ── Icon display state ─────────────────────────────────────────────────────
// Owned here — this is a UI concern, not a model concern.
// Each button reads its own relevant state directly from PlaybackState.
// This enum is used internally by MeditationPlayerIcon to select
// which animation to show for a given button.

enum IconDisplayState {
  playing,
  stopped,
  timer,
}

// ── Meditation player icon ─────────────────────────────────────────────────
// Phase 1 stub — renders a plain icon based on PlaybackState.
// Phase 2: swap the body for a Rive animation without changing the API.
//
// Usage:
//   MeditationPlayerIcon(
//     displayState: IconDisplayState.playing,
//     isActive: state.isPlaying,
//   )

class MeditationPlayerIcon extends StatelessWidget {
  const MeditationPlayerIcon({
    super.key,
    required this.displayState,
    required this.isActive,
    this.size = 48.0,
    this.activeColor,
    this.inactiveColor,
  });

  final IconDisplayState displayState;
  final bool isActive;
  final double size;
  final Color? activeColor;
  final Color? inactiveColor;

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? (activeColor ?? Theme.of(context).primaryColor)
        : (inactiveColor ?? Colors.grey);
    // throw UnimplementedError();

    return Icon(
      _iconFor(displayState),
      size: size,
      color: color,
    );
  }

  // Phase 2: replace this method body with Rive asset selection.
  // The signature stays the same.
  IconData _iconFor(IconDisplayState state) => switch (state) {
        IconDisplayState.playing => Icons.play_circle_outline,
        IconDisplayState.stopped => Icons.stop_circle_outlined,
        IconDisplayState.timer => Icons.timer_outlined,
      };

}

