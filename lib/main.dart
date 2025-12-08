import 'package:breathingcompanion/view/gaplessplaylist.dart';
import 'package:breathingcompanion/viewmodel/theme_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeViewModel, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Equanimity',
          theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.blue,
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all<Color>(Colors.blue.shade100),
            //   ),
            // ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.blue,
            // elevatedButtonTheme: ElevatedButtonThemeData(
            //   style: ButtonStyle(
            //     backgroundColor:
            //         MaterialStateProperty.all<Color>(Colors.blue.shade900),
            //   ),
            // ),
          ),
          themeMode: themeViewModel.themeMode,
          home: const Banner(
            message: "BETA",
            location: BannerLocation.topStart,
            color: Colors.green,
            child: GaplessPlaylist(),
          ),
        );
      },
    );
  }
}
