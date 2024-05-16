import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/bloc/player/player_observer.dart';

import 'src/app.dart';

void main() {
  Bloc.observer = const PlayerObserver();
  runApp(const MainApp());
}
