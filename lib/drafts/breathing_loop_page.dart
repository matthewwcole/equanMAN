/* 

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:async';


/* 
this is going to be a stateful widget

our sequences playBreathingLoop() <- our manager 
  runInhale()
  runExhale()
  runInhaleHold()
  runExhaleHold()
  
play button

 */

class BreathingLoopPage extends StatefulWidget {
  const BreathingLoopPage({super.key});
  @override
  State<BreathingLoopPage> createState() => _BreathingState();
}

class _BreathingState extends State<BreathingLoopPage> {
  final player = AudioPlayer();

  final bool _inhaleHoldEnabled = true;
  final bool _exhaleHoldEnabled = true;
  bool _isPlaying = false;

  void initState() {
    super.initState();

  }

  Future<void> runInhale() async {

    await player.setAudioSource(AudioSource.asset('lib/assets/i6.wav')); 
    await player.play();
    // The sound finished.
    print('playing i6.wav');
    
    }

  Future<void> runInhaleHold() async {  

    await Future.delayed(const Duration(seconds: 6));
    print('playing inhalehold');

  }



  Future<void> runExhale() async {
      
     await player.setAudioSource(AudioSource.asset('lib/assets/e9.wav'));
      await player.play();
        print('playing e9.wav');

    }

  Future<void> runExhaleHold() async {

    await Future.delayed(const Duration(seconds: 6));
    print('playiing exhalehold');
            
      }


  Future<void> playBreathingLoop() async {

    // Use a loop that can be stopped
  while (_isPlaying is true):
    await runInhale();
    
    if (_inhaleHoldEnabled is true AND _isPlaying is true):
      await runInhaleHold();
    
    if (_isPlaying is true):
      await runExhale();
    
    if (_exhaleHoldEnabled is true AND _isPlaying is true):
      await runExhaleHold();

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
            child: Text('Play')
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