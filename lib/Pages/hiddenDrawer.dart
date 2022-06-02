// ignore_for_file: file_names
import 'package:automata/Pages/chartHome.dart';
import 'package:automata/Pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'Home.dart';

class HiddenMenu extends StatefulWidget {
  const HiddenMenu({Key? key}) : super(key: key);

  @override
  State<HiddenMenu> createState() => _HiddenMenuState();
}

class _HiddenMenuState extends State<HiddenMenu> {
  List<ScreenHiddenDrawer> _pages = [];

  final myTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "H O M E",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
        ),
        const HomePage(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "S E T T I N G S",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
        ),
        const settings(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "C H A R T",
          baseStyle: myTextStyle,
          selectedStyle: myTextStyle,
        ),
        const CartHome(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      backgroundColorAppBar: Colors.deepPurple,
      screens: _pages,
      initPositionSelected: 0,
      backgroundColorMenu: const Color.fromRGBO(145, 143, 222, 1),
      slidePercent: 60,
      disableAppBarDefault: true,
      isDraggable: true,
      curveAnimation: Curves.linear,
    );
  }
}
