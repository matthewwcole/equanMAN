import 'package:breathingcompanion/view/audio_control_buttons.dart';
import 'package:breathingcompanion/viewmodel/sleep_timer_viewmodel.dart';
import 'package:breathingcompanion/viewmodel/theme/app_pallete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../model/audio_player_service.dart';
import 'package:flutter/cupertino.dart';

class HomeBreathingScreen extends StatefulWidget {
  const HomeBreathingScreen({super.key});

  @override
  State<HomeBreathingScreen> createState() => _HomeBreathingScreenState();
}

class _HomeBreathingScreenState extends State<HomeBreathingScreen> {
  final _audioService = AudioPlayerService();
  late final SleepTimerLogic _timerLogic; //declared without initalization
  int _selectedPlaylistIndex = 0; // Default to first playlist

  @override
  void initState() {
    super.initState();
    _timerLogic = SleepTimerLogic(_audioService); //initialized here
    _audioService.loadPlaylist(
      Playlist.allPlaylists[_selectedPlaylistIndex],
    );
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
          titleTextStyle: GoogleFonts.openSans(
            color: Pallete.primaryText,
            fontSize: 25,
            fontStyle: FontStyle.italic,
          ),
          backgroundColor: Pallete.softPeriwinkle,
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
              content: GestureDetector(
                child: SizedBox(
                  height: 250,
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
            Text('Inhale - Inhale Hold - Exhale - Exhale Hold',
              style: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox(height: 20),
            DropdownButton<int>(
              dropdownColor: const Color(0xFF023e8a),
              style: const TextStyle(
                color: Pallete.primaryText,
                fontSize: 16,
                
              ),
              value: _selectedPlaylistIndex,
              items: Playlist.allPlaylists.asMap().entries.map((e) => 
                DropdownMenuItem<int>(
                  value: e.key,
                  child: Text(e.value.title),
                ),
              ).toList(),
              onChanged: (index) {
                if (index != null) {
                  setState(() {
                    _selectedPlaylistIndex = index;
                  });
                  _audioService.loadPlaylist(
                    Playlist.allPlaylists[index],
                  );
                }
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
