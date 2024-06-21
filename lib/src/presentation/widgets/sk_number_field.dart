import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class SKNumberField extends StatelessWidget{
   const SKNumberField({
    super.key,
    required this.maxValue,
    required this.value,
    this.onChange,
  });

  final Function(String)? onChange;
  final int maxValue;
  final int value;

  void onValueChange(int newValue) {
    if (newValue > maxValue) return;
    onChange?.call(newValue.toString());
  }

  @override
  Widget build(BuildContext context) {
    return CartStepperInt(
      axis: Axis.vertical,
      alwaysExpanded: true,
      style: const CartStepperStyle(
          backgroundColor: Colors.transparent,
          activeForegroundColor: lightColor,
          foregroundColor: lightColor,
          iconPlus: Icons.add,
          iconMinus: Icons.remove,
          activeBackgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          textStyle: TextStyle(color: lightColor)),
      value: value,
      didChangeCount: (count) => onValueChange(count),
    );
  }
}
