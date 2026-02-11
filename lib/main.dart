import 'package:equanimity/view/home_breathing_screen.dart';
import 'package:flutter/material.dart';
import 'package:equanimity/theme/app_pallete.dart';
import 'package:provider/provider.dart';
import 'package:equanimity/viewmodel/home_breathing_viewmodel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //    final HSLColor hslColor = HSLColor.fromColor(Pallete.scarletSmile);
    //    final HSLColor desaturatedColor = hslColor.withSaturation(0.2);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            color: Pallete.primaryText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme:
            const TextTheme(
              bodySmall: TextStyle(color: Pallete.primaryText),
              bodyMedium: TextStyle(color: Pallete.primaryText),
              bodyLarge: TextStyle(color: Pallete.primaryText),
            ).apply(
              bodyColor: Pallete.primaryText,
              displayColor: Pallete.primaryText,
            ),
      ),
      title: '😠 Equanimity 😮‍💨',
      home: Banner(
        message: "BETA",
        location: BannerLocation.topEnd,
        color: Pallete.scarletSmile,
        child: ChangeNotifierProvider(
          create: (context) => HomeBreathingViewModel(),
          child: HomeBreathingScreen(),
        ),
      ),
    );
  }
}

