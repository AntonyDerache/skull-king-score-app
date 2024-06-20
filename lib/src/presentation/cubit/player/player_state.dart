import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PlayerState extends Equatable {
  final UniqueKey id;
  final String name;
  final int score;

  const PlayerState(this.id, {this.name = "", this.score = 0});

  PlayerState copyWith({
    UniqueKey? id,
    String? name,
    int? score,
  }) {
    return PlayerState(
      id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [id, name, score];
}
