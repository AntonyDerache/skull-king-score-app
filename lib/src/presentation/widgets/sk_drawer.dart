import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/views/rules_modal_view.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SKDrawer extends StatelessWidget {
  const SKDrawer({super.key});

  void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, baseUrl, (_) => false);
  }

  void changeLanguage(BuildContext context, LanguageState state) async {
    await context.read<LanguageCubit>().toggleNewLanguage(state);
  }

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Drawer(
          backgroundColor: secondaryColor.withAlpha(150),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(padding: EdgeInsets.zero, children: [
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
                    ListTile(
                      title: SKText(
                          text: AppLocalizations.of(context)!.rules,
                          fontSize: 18),
                      onTap: () {
                        showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            backgroundColor: darkColor,
                            context: context,
                            builder: (BuildContext context) {
                              return const RulesModalView();
                            });
                      },
                    ),
                    ListTile(
                      title: SKText(
                          text: AppLocalizations.of(context)!.stats,
                          fontSize: 18),
                      onTap: null,
                    ),
                    ListTile(
                      title: SKText(
                          text: AppLocalizations.of(context)!.goHome,
                          fontSize: 18),
                      onTap: () => goToHome(context),
                    ),
                  ]),
                ),
                Container(
                  height: 42,
                  alignment: Alignment.centerLeft,
                  child: BlocBuilder<LanguageCubit, LanguageState>(
                      builder: (context, state) {
                    String flagPath = state is FrenchLanguageState
                        ? 'assets/icons/french_flag.png'
                        : 'assets/icons/english_flag.png';
                    LanguageState newState = state is FrenchLanguageState
                        ? EnglishLanguageState()
                        : FrenchLanguageState();
                    return IconButton(
                      icon: Image(image: AssetImage(flagPath)),
                      onPressed: () => changeLanguage(context, newState),
                    );
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}
