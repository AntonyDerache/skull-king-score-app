import 'package:flutter/foundation.dart';

class ListUtils {
  static areListsNotEquals<T>(List<T> list1, List<T> list2) {
    return !listEquals(
      list1,
      list2,
    );
  }
}
