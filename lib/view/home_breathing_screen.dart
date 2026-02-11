import 'package:equanimity/view/audio_control_buttons.dart';
import 'package:equanimity/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:equanimity/viewmodel/home_breathing_viewmodel.dart';
import 'package:equanimity/model/playlist.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoAlertDialog and CupertinoTimerPicker

class HomeBreathingScreen extends StatelessWidget {
  const HomeBreathingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeBreathingViewModel>(
      builder: (context, viewModel, child) {
        // Local function to handle timer dialogs and call ViewModel
        void handleStartTimer() async {
          final currentContext = context; // Capture context

          final timerChoices = await showDialog<dynamic>(
            context: currentContext,
            builder: (context) {
              return SimpleDialog(
                title: const Text('Set Auto-Stop Timer'),
                titleTextStyle: GoogleFonts.openSans(
                  color: Pallete.primaryText,
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                ),
                backgroundColor: Pallete.softPeriwinkle,
                children: [
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 5); // 5 minutes
                    },
                    child: const Text('5 Minutes'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 15); // 15 minutes
                    },
                    child: const Text('15 Minutes'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 30); // 30 minutes
                    },
                    child: const Text('30 Minutes'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 60); // 60 minutes
                    },
                    child: const Text('60 Minutes'),
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(context, 'custom'); // This will be custom
                    },
                    child: const Text('Custom'),
                  ),
                ],
              );
            },
          );

          if (!currentContext.mounted) return; // Guard after first async gap

          if (timerChoices != null) {
            if (timerChoices == 'custom') {
              Duration selectedDuration = const Duration(minutes: 15);
              final customTime = await showCupertinoDialog<Duration>(
                context: currentContext, // Use captured context
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: const Text('Select Auto-Stop Duration'),
                    content: GestureDetector(
                      child: SizedBox(
                        height: 250,
                        child: CupertinoTimerPicker(
                          mode: CupertinoTimerPickerMode.hms,
                          onTimerDurationChanged: (Duration newDuration) {
                            selectedDuration = newDuration;
                          },
                        ),
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: const Text('Namaste'),
                        onPressed: () {
                          Navigator.pop(context, selectedDuration);
                        },
                      ),
                    ],
                  );
                },
              );

              if (!currentContext.mounted) return; // Guard after second async gap

              if (customTime != null) {
                viewModel.onTimerPressed(
                  customTime.inHours,
                  customTime.inMinutes % 60,
                  customTime.inSeconds % 60,
                );
              }
            } else {
              viewModel.onTimerPressed(0, timerChoices, 0);
            }
          }
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Pallete.surfaceColor, Pallete.backgroundColor],
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: Text(
                'Equanimity',
                style: TextStyle(
                  fontFamily: 'Sansita Swashed',
                  color: Pallete.cloudDancer,
                  fontSize: 40,
                  letterSpacing: 1.5,
                ),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
              elevation: 0,
              toolbarHeight: 80.0,
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Inhale - Inhale Hold - Exhale - Exhale Hold',
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<int>(
                    dropdownColor: const Color(0xFF023e8a),
                    style: const TextStyle(
                      color: Pallete.primaryText,
                      fontSize: 16,
                    ),
                    value: viewModel.selectedPlaylistIndex,
                    items: Playlist.allPlaylists
                        .asMap()
                        .entries
                        .map(
                          (e) => DropdownMenuItem<int>(
                            value: e.key,
                            child: Text(e.value.title),
                          ),
                        )
                        .toList(),
                    onChanged: (index) {
                      if (index != null) {
                        viewModel.setSelectedPlaylistIndex(index);
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  AudioControlButtons(
                    onPlay: viewModel.onPlayPressed,
                    onStop: viewModel.onStopPressed,
                    startTimer: handleStartTimer,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
