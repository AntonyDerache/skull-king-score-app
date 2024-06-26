import 'package:flutter_test/flutter_test.dart';
import 'package:skull_king_score_app/src/domain/entities/round.dart';
import 'package:skull_king_score_app/src/domain/usecases/is_end_round_data_correct.dart';

void main() {
  group(IsEndRoundDataIncorrect, () {
    test('tricksWon is inferior', () {
      // GIVEN
      Round round = const Round(9);
      int registeredTotalTricksWon = 8;
      IncorrectDataResult expectedResult = IncorrectDataResult.inferior;
      // WHEN
      IncorrectDataResult isDataIncorrect =
          IsEndRoundDataIncorrect.execute(registeredTotalTricksWon, round);
      // THEN
      expect(isDataIncorrect, expectedResult);
    });

    test('tricksWon is equal', () {
      // GIVEN
      Round round = const Round(5);
      int registeredTotalTricksWon = 5;
      IncorrectDataResult expectedResult = IncorrectDataResult.none;
      // WHEN
      IncorrectDataResult isDataIncorrect =
          IsEndRoundDataIncorrect.execute(registeredTotalTricksWon, round);
      // THEN
      expect(isDataIncorrect, expectedResult);
    });

    test('tricksWon is superior', () {
      // GIVEN
      Round round = const Round(5);
      int registeredTotalTricksWon = 8;
      IncorrectDataResult expectedResult = IncorrectDataResult.superior;
      // WHEN
      IncorrectDataResult isDataIncorrect =
          IsEndRoundDataIncorrect.execute(registeredTotalTricksWon, round);
      // THEN
      expect(isDataIncorrect, expectedResult);
    });
  });
}
