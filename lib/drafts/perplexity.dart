/* 

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class BreathingLoopPagePerp extends StatefulWidget {
  const BreathingLoopPagePerp({super.key});
  @override
  State<BreathingLoopPagePerp> createState() => _BreathingState();
}

class _BreathingState extends State<BreathingLoopPagePerp> {
  final player = AudioPlayer();

  final bool _inhaleHoldEnabled = true;
  final bool _exhaleHoldEnabled = true;
  bool _isPlaying = false;

  Future<void> runInhale() async {
    await player.setAudioSource(AudioSource.asset('lib/assets/i6.wav'));
    await player.play();
    print('playing i6.wav');
    
    await Future.delayed(const Duration(seconds: 3));
    if (_inhaleHoldEnabled) await runInhaleHold();
    else await runExhale();
  }

  Future<void> runInhaleHold() async {
    print('inhale hold start');
    await Future.delayed(const Duration(seconds: 3));
    print('inhale hold end');
    await runExhale();
  }

  Future<void> runExhale() async {
    await player.setAudioSource(AudioSource.asset('lib/assets/e9.wav'));
    await player.play();
    print('playing e9.wav');
    await Future.delayed(const Duration(seconds: 3));
    if (_exhaleHoldEnabled) await runExhaleHold();
    else await playBreathingLoop();
  }

  Future<void> runExhaleHold() async {
    print('exhale hold start');
    await Future.delayed(const Duration(seconds: 3));
    print('exhale hold end');
    await playBreathingLoop();
  }

  Future<void> playBreathingLoop() async {
    if (!_isPlaying) return; // Exit if stopped
    await runInhale();
  }

  void _onPlayPressed() {
    if (!_isPlaying) {
      _isPlaying = true;
      playBreathingLoop();
    }
  }

  void _onStopPressed() {
    _isPlaying = false;
    player.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _onPlayPressed,
              child: const Text('Play')
            ),
            const SizedBox(width: 20),
            ElevatedButton(
              onPressed: _onStopPressed,
              child: const Text('Stop')
            ),
          ],
        ),
      ),
    );
  }
} 

 */
