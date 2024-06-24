import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

void showSnackbar(BuildContext context, String content) {
  SnackBar snackbar = SnackBar(
    showCloseIcon: true,
    content: SKText(text: content),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}
