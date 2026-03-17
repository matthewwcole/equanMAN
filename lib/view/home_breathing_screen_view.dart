
import 'package:equanimity/model/playlist.dart';
import 'package:equanimity/model/theme/app_pallete.dart';
import 'package:equanimity/services/audio_player_service.dart';
import 'package:equanimity/widgets/audio_control_buttons_widget.dart';
import 'package:equanimity/viewmodel/sleep_timer_viewmodel.dart';
import 'package:equanimity/widgets/playlist_dropdown.dart';
import 'package:equanimity/widgets/timer_dialog.dart';
import 'package:flutter/material.dart';

class HomeBreathingScreen extends StatefulWidget {
  const HomeBreathingScreen({super.key});

  @override
  State<HomeBreathingScreen> createState() => _HomeBreathingScreenState();
}

class _HomeBreathingScreenState extends State<HomeBreathingScreen> {
  final _audioService = AudioPlayerService();
  late final SleepTimerLogic _timerLogic; //declared without initalization

@override
void initState() {
  super.initState();
  _timerLogic = SleepTimerLogic(_audioService);
  _audioService.loadPlaylist(Playlist.allPlaylists[0]);
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
    final duration = await showTimerDialog(context);
    if (!mounted || duration == null) return;
    _timerLogic.startTimer(
      duration.inHours,
      duration.inMinutes % 60,
      duration.inSeconds % 60,
    );
  }

  @override
  void dispose() {
    _audioService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              //fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 80.0,
        ),
        body: Center(
          //Add DropdownButton<int>
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
              if (Playlist.allPlaylists.isNotEmpty)
                PlaylistDropdown(
                  onChanged: (playlist) {
                    _audioService.loadPlaylist(playlist);
                  },
                ),
              const SizedBox(height: 20),
              AudioControlButtons(
                onPlay: _onPlayPressed,
                onStop: _onStopPressed,
                startTimer: _onTimerPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
