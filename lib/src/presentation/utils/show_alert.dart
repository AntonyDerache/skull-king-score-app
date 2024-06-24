import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/alert_enums.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_alert_dialog.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';

Future<DialogAcceptEnum?> showAlert(
  BuildContext context,
  String title,
  String content,
) async {
  return await showDialog(
    context: context,
    builder: (_) => SKAlertDialog(
      title: title,
      content: SKText(
        text: content,
      ),
    ),
    barrierDismissible: true,
  );
}
