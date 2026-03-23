import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart' as just_audio;
import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/services/audio_player_service.dart';
import 'package:equanimity/viewmodel/sleep_timer_viewmodel.dart';
import 'package:flutter/cupertino.dart'; // For CupertinoAlertDialog and CupertinoTimerPicker
import 'package:equanimity/model/playback_state.dart';

class HomeBreathingViewModel extends ChangeNotifier {
  // Injected from outside not created here.
  // home_breathing_screen_view.dart owns this single instance
  final AudioPlayerService _audioService;
  late final SleepTimerLogic _timerLogic;
  int _selectedPlaylistIndex = 0; // Default to first playlist

  HomeBreathingViewModel(this._audioService) {
    _timerLogic = SleepTimerLogic(_audioService);
  
  _audioService.loadPlaylist(Playlist.allPlaylists[_selectedPlaylistIndex]);
  }


  // Getters for UI to observe
  int get selectedPlaylistIndex => _selectedPlaylistIndex;
  Stream<PlaybackState> get playerStateStream => 
  _audioService.playbackStateStream;
  Stream<just_audio.SequenceState?> get sequenceStateStream => 
  _audioService.sequenceStateStream;
  bool get hasNext => _audioService.hasNext;
  bool get hasPrevious => _audioService.hasPrevious;
  Stream<PositionData> get positionDataStream => 
  _audioService.positionDataStream;

  void setSelectedPlaylistIndex(int index) {
    _selectedPlaylistIndex = index;
    _audioService.loadPlaylist(Playlist.allPlaylists[_selectedPlaylistIndex]);
    notifyListeners();
  }

  void onPlayPressed() async {
    await _audioService.play();
    notifyListeners();
  }

  void onStopPressed() async {
    await _audioService.stop();
    notifyListeners();
  }

  void onTimerPressed(int selectedHours, int selectedMinutes, 
  int selectedSeconds) {
    _timerLogic.startTimer(selectedHours, selectedMinutes, 
    selectedSeconds);
  }

  @override
  void dispose() {
    //_audioService.dispose();
    // Do NOT dispose _audioService here — the owner (the screen) disposes it.
    super.dispose();
  }
}
