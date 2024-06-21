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
    int index = state.indexWhere((score) => score.playerId == playerId);
    Map<BonusKey, Bonus> updatedBonus = {...state[index].bonusPoints};
    updatedBonus.update(
      bonusKey,
      (bonus) => Bonus(bonus.value, amount),
    );
    state[index] = state[index].copyWith(
      bonusPoints: updatedBonus,
    );
    emit([...state]);
  }

  void onBidsChanged(UniqueKey playerId, String value) {
    int index = state.indexWhere((score) => score.playerId == playerId);
    state[index] = state[index].copyWith(bids: int.parse(value));
    emit([...state]);
  }

  void onWonTricksChanged(UniqueKey playerId, String value) {
    int index = state.indexWhere((score) => score.playerId == playerId);
    state[index] = state[index].copyWith(tricksWon: int.parse(value));
    emit([...state]);
  }
}
