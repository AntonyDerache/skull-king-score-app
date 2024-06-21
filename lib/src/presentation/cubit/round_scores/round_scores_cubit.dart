import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/domain/entities/bonus.dart';
import 'package:skull_king_score_app/src/domain/entities/player_round_score.dart';

class RoundScoreCubit extends Cubit<List<PlayerRoundScore>> {
  RoundScoreCubit() : super(List.empty());

  void setFrom(List<PlayerRoundScore> other) {
    emit([...other]);
  }

  void onBonusPressed(UniqueKey playerId, BonusKey bonusKey, int amount) {
    state
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerBonusAmount(playerId, bonusKey, amount);
    emit([...state]);
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    state
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerBidsValue(playerId, int.parse(value));
    emit([...state]);
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    state
        .singleWhere((player) => player.playerId == playerId)
        .updatePlayerWonTricksValue(playerId, int.parse(value));
    emit([...state]);
  }
}
