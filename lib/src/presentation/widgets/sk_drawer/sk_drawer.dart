import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/constants.dart';
import 'package:skull_king_score_app/src/presentation/utils/supported_locales.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/help_modal/help_modal.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SKDrawer extends StatelessWidget {
  const SKDrawer({super.key});

  void goToHome(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(context, baseUrl, (_) => false);
  }

  void changeLanguage(BuildContext context, String? value) async {
    if (value == null) return;
    await context.read<LanguageCubit>().toggleNewLanguage(value);
  }

  void openRules(BuildContext context) async =>
      await context.read<LanguageCubit>().openRules();

  @override
  Widget build(BuildContext context) {
    bool isAtRoot = ModalRoute.of(context)?.settings.name == baseUrl;

    return SKBackdropFilter(
      sigmaX: 10,
      sigmaY: 10,
      child: Drawer(
        backgroundColor: secondaryColor.withAlpha(150),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
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
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        title: SKText(
                            text: AppLocalizations.of(context)!.help,
                            fontSize: 18),
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
                      borderRadius: BorderRadius.circular(10),
                      child: ListTile(
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SKText(
                                text: AppLocalizations.of(context)!.rules,
                                fontSize: 18),
                            const SizedBox(width: 10),
                            const Icon(Icons.open_in_browser,
                                color: lightColor, size: 20),
                          ],
                        ),
                      ),
                      onTap: () => openRules(context),
                    ),
                    // ListTile(
                    //   title: SKText(
                    //       text: AppLocalizations.of(context)!.stats,
                    //       fontSize: 18),
                    //   onTap: null,
                    // ),
                    if (!isAtRoot)
                      InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          title: SKText(
                              text: AppLocalizations.of(context)!.goHome,
                              fontSize: 18),
                        ),
                        onTap: () => goToHome(context),
                      ),
                  ],
                ),
              ),
              Container(
                height: 48,
                width: 48,
                color: Colors.transparent,
                child: BlocBuilder<LanguageCubit, LanguageState>(
                  builder: (context, state) {
                    const iconSize = 24.0;

                    return DropdownButtonFormField(
                      dropdownColor: secondaryColor,
                      elevation: 0,
                      iconSize: 0.0,
                      decoration: const InputDecoration(
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none),
                      selectedItemBuilder: (context) {
                        return supportedLocales.map(
                          (LanguageState language) {
                            return Image(
                              width: iconSize,
                              height: iconSize,
                              image: AssetImage(language.flagPath ?? ''),
                            );
                          },
                        ).toList();
                      },
                      items: supportedLocales.map(
                        (LanguageState language) {
                          return DropdownMenuItem<String>(
                            value: language.locale.languageCode,
                            alignment: Alignment.center,
                            child: IconButton(
                              icon: Image(
                                width: iconSize,
                                height: iconSize,
                                image: AssetImage(language.flagPath ?? ''),
                              ),
                              onPressed: null,
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (String? value) =>
                          changeLanguage(context, value),
                      value: state.locale.languageCode,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
