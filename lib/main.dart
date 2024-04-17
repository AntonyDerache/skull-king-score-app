import 'dart:math';

import 'package:flutter/material.dart';
import 'package:skull_king_score_app/components/button.dart';
import 'package:skull_king_score_app/layout/background.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            const Background(),
            Center(
              child: Button(
                label: 'Player',
                onPressed: () => debugPrint('toto'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
