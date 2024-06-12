import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/help_modal/help_modal.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SKDrawer extends StatelessWidget {
  const SKDrawer({super.key});

  void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, baseUrl, (_) => false);
  }

  void changeLanguage(BuildContext context, LanguageState state) async {
    await context.read<LanguageCubit>().toggleNewLanguage(state);
  }

  void openRules(BuildContext context) async {
    if (context.read<LanguageCubit>().state is FrenchLanguageState) {
      final Uri url = Uri.parse('https://cdn.shopify.com/s/files/1/0565/3230/4053/files/SK_FR_Rulebook_Optimized.pdf?v=1663014102');
      if (!await launchUrl(url)) {
       throw Exception('Could not launch $url');
      }
    } else {
      final Uri url = Uri.parse('https://cdn.shopify.com/s/files/1/0565/3230/4053/files/sk_rulebook_optimized.pdf?v=1652992950');
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }
    }
   }

  @override
  Widget build(BuildContext context) {
    bool isAtRoot = ModalRoute.of(context)?.settings.name == baseUrl;

    return SKBackdropFilter(
        sigmaX: 10,
        sigmaY: 10,
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
                          text: AppLocalizations.of(context)!.help,
                          fontSize: 18),
                      onTap: () {
                        showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            backgroundColor: darkColor,
                            context: context,
                            builder: (BuildContext context) {
                              return const HelpModalView();
                            });
                      },
                    ),
                    ListTile(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SKText(
                              text: AppLocalizations.of(context)!.rules,
                              fontSize: 18),
                          const SizedBox(width: 10),
                          const Icon(Icons.open_in_browser, color: lightColor, size: 20),
                        ],
                      ),
                      onTap: () => openRules(context),
                    ),
                    ListTile(
                      title: SKText(
                          text: AppLocalizations.of(context)!.stats,
                          fontSize: 18),
                      onTap: null,
                    ),
                    if (!isAtRoot)
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
