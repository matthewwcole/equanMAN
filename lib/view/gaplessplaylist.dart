import 'package:breathingcompanion/view/audio_control_buttons.dart';
import 'package:breathingcompanion/viewmodel/sleep_timer_viewmodel.dart';
import 'package:flutter/material.dart';
import '../model/audio_player_service.dart';
import 'package:flutter/cupertino.dart';

class GaplessPlaylist extends StatefulWidget {
  const GaplessPlaylist({super.key});

  @override
  State<GaplessPlaylist> createState() => _GaplessPlaylistState();
}

class _GaplessPlaylistState extends State<GaplessPlaylist> {
  final _audioService = AudioPlayerService();
  late final SleepTimerLogic _timerLogic; //declared without initalization

  @override
  void initState() {
    super.initState();
    _timerLogic = SleepTimerLogic(_audioService); //initialized here
  }

  void _onPlayPressed() async {
    await _audioService.play();
    //final timerLogic = SleepTimerLogic(_audioService);
    //timerLogic.startTimer(0, 0, 10);  // 10 seconds - faster to test!
  }

  void _onStopPressed() async {
    await _audioService.stop();
  }

  void _onTimerPressed() async {
    final timerChoices = await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Set Auto-Stop Timer'),
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
    if (!mounted) return;
    if (timerChoices != null) {
      if (timerChoices == 'custom') {
        Duration selectedDuration = const Duration(
          minutes: 15,
        ); // Default value and this is what VSCode gave us after a tab.
        final customTime = await showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: const Text('Select Auto-Stop Duration'),
              content: SizedBox(
                height: 200,
                child: GestureDetector(
                  child: CupertinoTimerPicker(
                    mode: CupertinoTimerPickerMode.hms,
                    onTimerDurationChanged: (Duration newDuration) {
                      selectedDuration =
                          newDuration; //Store the picked duration here
                    },
                  ),
                ),
              ),
              actions: [
                CupertinoDialogAction(
                  child: const Text('Cancel'),
                  onPressed: () {
                    //What does go here?
                    Navigator.pop(context);
                  },
                ),
                CupertinoDialogAction(
                  child: const Text('Namaste'),
                  onPressed: () {
                    //What does go here?
                    Navigator.pop(context, selectedDuration);
                  },
                ),
              ],
            );
          },
        );
        //Promblem Fixing
        //This is for is a user navigates away without selecting a time
        if (!mounted) return;
        //this is for what?
        if (customTime != null) {
          _timerLogic.startTimer(
            customTime.inHours,
            customTime.inMinutes % 60,
            customTime.inSeconds % 60,
          );
        }
      } else {
        //Start timer with the number
        _timerLogic.startTimer(
          0,
          timerChoices,
          0,
        ); // start timer with timerChoices minutes
      }
    }
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equanimity'),
      ),
      body: Center(
        child: AudioControlButtons(
          onPlay: _onPlayPressed,
          onStop: _onStopPressed,
          startTimer: _onTimerPressed,
        ),
      ),
    );
  }
}
