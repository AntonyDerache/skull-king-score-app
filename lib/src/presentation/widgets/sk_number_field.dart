import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';

class SKNumberField extends StatefulWidget {
  const SKNumberField({
    super.key,
    required this.maxValue,
    this.onChange,
  });

  final Function(String)? onChange;
  final int maxValue;

  @override
  State<SKNumberField> createState() => _SKNumberField();
}

class _SKNumberField extends State<SKNumberField> {
  int counter = 0;

  void onValueChange(int newValue) {
    if (newValue > widget.maxValue) return;
    setState(() {
      counter = newValue;
    });
    widget.onChange?.call(newValue.toString());
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
      value: counter,
      didChangeCount: (count) => onValueChange(count),
    );
  }
}
