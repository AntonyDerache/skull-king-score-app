import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Player extends Equatable {
  final UniqueKey id;
  final String name;
  final int score;

  const Player(this.id, {this.name = "", this.score = 0});

  Player copyWith({
    UniqueKey? id,
    String? name,
    int? score,
  }) {
    return Player(
      id ?? this.id,
      name: name ?? this.name,
      score: score ?? this.score,
    );
  }

  @override
  List<Object?> get props => [id, name, score];
}
