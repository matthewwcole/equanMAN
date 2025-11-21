import 'package:flutter/material.dart';

class AudioControlButtons extends StatelessWidget{
  
  // Define two final VoidCallback variables here (one for play, one for stop, timer)
  final VoidCallback onPlay;
  final VoidCallback onStop;
  final VoidCallback startTimer;
  
  // Constructor that requires those two callbacks
  const AudioControlButtons(
    {super.key, 
    required this.onPlay, 
    required this.onStop,
    required this.startTimer});


// build method with your two ElevatedButtons
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onPlay,
              child: const Text('Play')
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: onStop,
              child: const Text('Stop')
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: startTimer,
              child: const Text('Auto-Stop')
            ),
          ],
        ),
      ),
    );
  }
}