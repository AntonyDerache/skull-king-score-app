import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/cubit/cubit_observer.dart';

import 'src/app.dart';

void main() {
  Bloc.observer = const CubitObserver();
  runApp(const MainApp());
}
