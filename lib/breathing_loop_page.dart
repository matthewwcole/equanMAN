import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

/* 
this is going to be a stateful widget

we need a variable that holds what part of the loop that we are in

our sequences playBreathingLoop() <- our manager 
  runInhale()
  runExhale()
  runInhaleHold()
  runExhaleHold()
  
Enum this is a data type we can use to hold our four states: inhale, inhale hold, exhale, exhale hold
  We can call this _BreathingState

play button

 */

enum _BreathingCycle { inhale, inhaleHold, exhale, exhaleHold }

class BreathingLoopPage extends StatefulWidget {
  const BreathingLoopPage({super.key});
  @override
  State<BreathingLoopPage> createState() => _BreathingState();
}

class _BreathingState extends State<BreathingLoopPage> {
  final player = AudioPlayer();
  _BreathingCycle _currentBreath = _BreathingCycle.inhale;

  void initState() {
    super.initState();
    player.playerStateStream.listen((state) {
  if (state.processingState == ProcessingState.completed) {
    // The sound finished. Now what?

    if (_currentBreath == _BreathingCycle.inhale) {
      // The INHALE sound just finished.
      // 1. Change the state to the hold.
      // 2. Start the 6-second hold timer.
      _currentBreath = _BreathingCycle.inhaleHold;
      Future.delayed(Duration(seconds: 6), () {

        print('future.delayed');
      
      player.setAudioSource(AudioSource.asset('lib/assets/e9.wav'));
      
      });
      print('playing e9.wav');
      
    } else if (_currentBreath == _BreathingCycle.inhaleHold) {
      // The EXHALE sound just finished.
      // 1. Change the state to the hold.
      // 2. Start the 6-second hold timer.
      _currentBreath = _BreathingCycle.exhaleHold;
      Future.delayed(Duration(seconds: 6), () {

        print('future.delayed');

      player.setAudioSource(AudioSource.asset('lib/assets/i6.wav'));
      print('playing i6.wav');

      });
    } else if (_currentBreath == _BreathingCycle.exhaleHold) {
      // Move to inhale

      _currentBreath = _BreathingCycle.inhale;
      player.setAudioSource(AudioSource.asset('lib/assets/i6.wav'));
      print('playing i6.wav'); 
    }}});}

  void playBreathingLoop(bool inhaleHoldEnabled) {
    player.setAudioSource(AudioSource.asset('lib/assets/i6.wav')
    );
    player.play();
    //print('playing i6.wav');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            playBreathingLoop(true);
          }, 
          
          
          
          
          
          
          child: Text('Play'))
        ],
        

              
        )),
    );
  }
  }
  
