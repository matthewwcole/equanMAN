class PlaybackState {
  const PlaybackState({
    required this.isPlaying,
    required this.isTimerActive,
  });

  final bool isPlaying;
  final bool isTimerActive;

  //Derived - never set independently
  bool get isStopped => !isPlaying && !isTimerActive;
}