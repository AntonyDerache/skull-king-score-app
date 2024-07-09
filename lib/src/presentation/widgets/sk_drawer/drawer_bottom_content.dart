import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_cubit.dart';
import 'package:skull_king_score_app/src/presentation/cubit/language/language_state.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/utils/supported_locales.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerBottomContent extends StatelessWidget {
  const DrawerBottomContent({super.key});

  final double iconHeight = 48.0;
  final double iconWidth = 48.0;

  void changeLanguage(BuildContext context, String? value) async {
    if (value == null) return;
    await context.read<LanguageCubit>().toggleNewLanguage(value);
  }

  void openSpotify() async {
    const String link = 'https://open.spotify.com/intl-fr/artist/5zbAdSKQiTetVoHnbHvsDg?si=k24SIfmDQZu-_DxAiVWjdA';
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: iconHeight,
          width: iconWidth,
          color: Colors.transparent,
          child: BlocBuilder<LanguageCubit, LanguageState>(
            builder: (context, state) {
              const iconSize = 24.0;

              return DropdownButtonFormField(
                key: const ValueKey("language_dropdown"),
                dropdownColor: secondaryColor,
                elevation: 0,
                iconSize: 0.0,
                decoration: const InputDecoration(
                    enabledBorder: InputBorder.none, border: InputBorder.none),
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
                      key: ValueKey(
                          "language_dropdown_item_${language.locale.languageCode}"),
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
                onChanged: (String? value) => changeLanguage(context, value),
                value: state.locale.languageCode,
              );
            },
          ),
        ),
        SizedBox(
            height: iconHeight,
            width: iconWidth,
            child: IconButton(
              icon: const Image(
                image: AssetImage('assets/icons/spotify.png'),
              ),
              onPressed: openSpotify,
            ))
      ],
    );
  }
}
