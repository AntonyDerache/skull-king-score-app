import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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

  @override
  bool operator ==(Object other) {
    return other is Player &&
        id == other.id &&
        score == other.score &&
        name == other.name;
  }

  @override
  int get hashCode => Object.hash(id, name, score);
}
