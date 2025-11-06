import 'package:breathingcompanion/gaplessplaylist.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Equanimity',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Banner(
        message: "BETA", 
        location: BannerLocation.topEnd,
        color: Colors.green,
        child: const GaplessPlaylist(),)
    );
  }
}

