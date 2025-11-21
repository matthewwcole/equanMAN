import 'dart:async';
import 'package:breathingcompanion/model/audio_player_service.dart';

class SleepTimerLogic {

  Timer? _timer; //null because if a user cancels it would crash without it
  int _seconds = 0; //this is for a display later
  bool _isRunning = false;
  final AudioPlayerService _audioPlayerService;

  // Constructor that requires AudioPlayerService
  SleepTimerLogic(this._audioPlayerService);

  // Assign it to _audioPlayerService here
  void startTimer(int hours, int minutes, int seconds) {
    if (_isRunning) return; // Prevent multiple timers
    _isRunning = true;
    _timer?.cancel();
    _seconds = 0;

    _timer = Timer(Duration(hours: hours, minutes: minutes, seconds: seconds), () {
    _audioPlayerService.stop();
    _isRunning = false;
    });

  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
  }
 
}



