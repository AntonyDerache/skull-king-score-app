import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/help_modal/help_modal.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerItemsList extends StatelessWidget {
  const DrawerItemsList({super.key});

  void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, baseUrl, (_) => false);
  }

  void openRules(BuildContext context) async =>
      await context.read<LanguageCubit>().openRules();

  @override
  Widget build(BuildContext context) {
    bool isAtRoot = ModalRoute.of(context)?.settings.name == baseUrl;

    return Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        clipBehavior: Clip.hardEdge,
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(30),
            child: FittedBox(
              fit: BoxFit.contain,
              child: SKText(
                text: AppLocalizations.of(context)!.appTitle,
                fontFamily: 'Allura',
              ),
            ),
          ),
          InkWell(
            key: const ValueKey("drawer_help_btn"),
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              title: SKText(
                text: AppLocalizations.of(context)!.help,
                fontSize: 18,
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                backgroundColor: darkColor,
                context: context,
                builder: (BuildContext context) {
                  return const HelpModalView();
                },
              );
            },
          ),
          InkWell(
            key: const ValueKey("drawer_rules_btn"),
            borderRadius: BorderRadius.circular(10),
            child: ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SKText(
                      text: AppLocalizations.of(context)!.rules, fontSize: 18),
                  const SizedBox(width: 10),
                  const Icon(Icons.open_in_browser,
                      color: lightColor, size: 20),
                ],
              ),
            ),
            onTap: () => openRules(context),
          ),
          if (!isAtRoot)
            InkWell(
              key: const ValueKey("drawer_home_btn"),
              borderRadius: BorderRadius.circular(10),
              child: ListTile(
                title: SKText(
                    text: AppLocalizations.of(context)!.goHome, fontSize: 18),
              ),
              onTap: () => goToHome(context),
            ),
        ],
      ),
    );
  }
}
