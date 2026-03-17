import 'package:equanimity/model/theme/app_pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<Duration?> showTimerDialog(BuildContext context) async {
  final timerChoices = await showDialog(
    context: context,
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
            onPressed: () => Navigator.pop(context, 5),
            child: const Text('5 Minutes'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 15),
            child: const Text('15 Minutes'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 30),
            child: const Text('30 Minutes'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 60),
            child: const Text('60 Minutes'),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(context, 'custom'),
            child: const Text('Custom'),
          ),
        ],
      );
    },
  );

  if (timerChoices == null || !context.mounted) return null;

  if (timerChoices == 'custom') {
    Duration selectedDuration = const Duration(minutes: 15);
    final customTime = await showCupertinoDialog<Duration>(
      context: context,
      builder: (ctx) {
        return CupertinoAlertDialog(
          title: const Text('Select Auto-Stop Duration'),
          content: SizedBox(
            height: 250,
            child: CupertinoTimerPicker(
              mode: CupertinoTimerPickerMode.hms,
              onTimerDurationChanged: (Duration newDuration) {
                selectedDuration = newDuration;
              },
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(ctx),
            ),
            CupertinoDialogAction(
              child: const Text('Namaste'),
              onPressed: () => Navigator.pop(ctx, selectedDuration),
            ),
          ],
        );
      },
    );
    return customTime; // null if cancelled
  } else {
    return Duration(minutes: timerChoices);
  }
}