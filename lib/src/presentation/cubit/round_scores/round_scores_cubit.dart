import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/round_score_player.dart';

class RoundScoreCubit extends Cubit<List<PlayerRoundScore>> {
  RoundScoreCubit() : super(List.empty());

  void init(List<PlayerRoundScore> other) {
    emit(List.from(other));
  }

  void onBonusPressed(UniqueKey playerId, BonusKey bonusKey, int amount) {
    List<PlayerRoundScore> scores = List.from(state);

    scores
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerBonusAmount(playerId, bonusKey, amount);
    emit(scores);
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    List<PlayerRoundScore> scores = List.from(state);

    scores
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerBidsValue(playerId, int.parse(value));
    emit(scores);
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    List<PlayerRoundScore> scores = List.from(state);

    scores
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerWonTricksValue(playerId, int.parse(value));
    emit(scores);
  }
}
