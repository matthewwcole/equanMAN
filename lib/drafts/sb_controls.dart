/* 

// lib/view/player_controls_view.dart
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../model/audio_player_service.dart';
import '../viewmodel/player_viewmodel.dart';

class PlayerControlsView extends StatefulWidget {
  const PlayerControlsView({super.key});

  @override
  State<PlayerControlsView> createState() => _PlayerControlsViewState();
}

class _PlayerControlsViewState extends State<PlayerControlsView> {
  // In a real app, you'd get this via a provider/service locator
  final _viewModel = PlayerViewModel(AudioPlayerService());

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 1. Track Information
        _buildTrackInfo(),

        // 2. Progress Bar and Time Labels
        _buildProgressBar(),

        // 3. Play/Pause/Replay/Next/Previous Buttons
        _buildControlButtons(),
      ],
    );
  }

  /// Builds the track title display
  Widget _buildTrackInfo() {
    return StreamBuilder<SequenceState?>(
      stream: _viewModel.sequenceStateStream,
      builder: (context, snapshot) {
        final state = snapshot.data;
        if (state?.sequence.isEmpty ?? true) {
          return const SizedBox();
        }
        final metadata = state!.currentSource!.tag as String?;
        return Text(
          metadata ?? 'Unknown Track',
          style: Theme.of(context).textTheme.headlineSmall,
        );
      },
    );
  }


  /// Builds the control buttons (Play/Pause/Replay)
  Widget _buildControlButtons() {
    return StreamBuilder<SequenceState?>(
      stream: _viewModel.sequenceStateStream,
      builder: (context, snapshot) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              iconSize: 48.0,
              onPressed: _viewModel.hasPrevious ? _viewModel.seekToPrevious : null,
            ),
            StreamBuilder<PlayerState>(
              stream: _viewModel.playerStateStream,
              builder: (context, snapshot) {
                final playerState = snapshot.data;
                final processingState = playerState?.processingState;
                final isPlaying = playerState?.playing ?? false;

                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return const CircularProgressIndicator();
                }

                if (!isPlaying) {
                  return IconButton(
                    icon: Icon(
                      processingState == ProcessingState.completed
                          ? Icons.replay
                          : Icons.play_arrow,
                    ),
                    iconSize: 64.0,
                    onPressed: _viewModel.play,
                  );
                } else {
                  return IconButton(
                    icon: const Icon(Icons.pause),
                    iconSize: 64.0,
                    onPressed: _viewModel.pause,
                  );
                }
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              iconSize: 48.0,
              onPressed: _viewModel.hasNext ? _viewModel.seekToNext : null,
            ),
          ],
        );
      },
    );
  }

  /// Builds the progress bar, slider, and time labels
  Widget _buildProgressBar() {
    return StreamBuilder<PositionData>(
      stream: _viewModel.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data ??
            (
              position: Duration.zero,
              bufferedPosition: Duration.zero,
              duration: Duration.zero
            );

        // Helper to format duration to mm:ss
        String formatDuration(Duration d) {
          final parts = d.toString().split('.').first.split(':');
          return '${parts[1]}:${parts[2]}';
        }

        return Column(
          children: [
            // A simple custom progress bar showing buffer level
            // Or you can use a package like `audio_video_progress_bar`
            Slider(
              min: 0.0,
              max: positionData.duration.inMilliseconds.toDouble(),
              value: positionData.position.inMilliseconds.toDouble().clamp(
                    0.0,
                    positionData.duration.inMilliseconds.toDouble(),
                  ),
              onChanged: (value) {
                _viewModel.seek(Duration(milliseconds: value.round()));
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatDuration(positionData.position)),
                  Text(formatDuration(positionData.duration)),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}


 */