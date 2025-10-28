import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

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

  void initState() {
    super.initState();

  }

  void runInhale() async {

    await player.setAudioSource(AudioSource.asset('lib/assets/i6.wav')); 
        await player.play();
        // The sound finished.
        print('playing i6.wav');

      runInhaleHold();
    
    }

  void runInhaleHold() async {  

  Timer.periodic(const Duration(seconds: 2), (timer) {
  print(timer.tick);
  timer.cancel();

      runExhale();

  });

    }



  void runExhale() async {
      
     await player.setAudioSource(AudioSource.asset('lib/assets/e9.wav'));
      await player.play();
        print('playing e9.wav');

      runExhaleHold();

    }

  void runExhaleHold() async {

    await Future.delayed(Duration(seconds: 6)); 
        print('future.delayed');

        playBreathingLoop();
    }

  void playBreathingLoop() {
    //player.setAudioSource(AudioSource.asset('lib/assets/i6.wav')); player.play();
    //we need to change this so it calls runInhale()
    runInhale();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {
            playBreathingLoop();
          }, 
          
          
          
          
          
          
          child: Text('Play'))
        ],
        

              
        )),
    );
  }
  }
  
