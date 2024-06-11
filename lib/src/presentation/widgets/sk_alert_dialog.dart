import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/dialog_accept_term.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SKAlertDialog extends StatelessWidget {
  const SKAlertDialog({
    super.key,
    required this.title,
    this.content,
  });

  final String title;
  final Widget? content;

  void dismissDialog(BuildContext context, DialogAcceptTerm key) {
    Navigator.of(context).pop(key);
  }

  @override
  Widget build(BuildContext context) {
    return SKBackdropFilter(
      sigmaX: 5,
      sigmaY: 5,
      child: AlertDialog(
        backgroundColor: primaryColor.withAlpha(100),
        title: SKText(text: title, fontWeight: FontWeight.bold, fontSize: 16),
        content: content,
        actions: [
          TextButton(
              onPressed: () => dismissDialog(context, DialogAcceptTerm.reject),
              child: SKText(text: AppLocalizations.of(context)!.no)),
          TextButton(
              onPressed: () => dismissDialog(context, DialogAcceptTerm.approve),
              child: SKText(text: AppLocalizations.of(context)!.yes, color: Colors.blue.shade400)),
        ],
      ),
    );
  }
}
