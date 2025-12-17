import 'package:breathingcompanion/view/gaplessplaylist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equanimity',
      home: const Banner(
        message: "BETA",
        location: BannerLocation.topEnd,
        color: Colors.green,
        child: GaplessPlaylist(),
      ),
    );
  }
}
