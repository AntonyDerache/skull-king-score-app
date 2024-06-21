import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/domain/entities/player.dart';

class PlayerState extends Player {
  const PlayerState(super.id, {super.name = "", super.score = 0});

  @override
  PlayerState copyWith({
    UniqueKey? id,
    String? name,
    int? score,
  }) {
    return PlayerState(
      id ?? super.id,
      name: name ?? super.name,
      score: score ?? super.score,
    );
  }
}
