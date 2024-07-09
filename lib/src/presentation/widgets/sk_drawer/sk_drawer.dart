import 'package:flutter/material.dart';
import 'package:skull_king_score_app/src/presentation/utils/color.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_backdrop_filter.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/drawer_bottom_content.dart';
import 'package:skull_king_score_app/src/presentation/widgets/sk_drawer/drawer_items_list.dart';

class SKDrawer extends StatelessWidget {
  const SKDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SKBackdropFilter(
      sigmaX: 10,
      sigmaY: 10,
      child: Drawer(
        key: const ValueKey("drawer"),
        backgroundColor: secondaryColor.withAlpha(150),
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerItemsList(),
              DrawerBottomContent(),
            ],
          ),
        ),
      ),
    );
  }
}
