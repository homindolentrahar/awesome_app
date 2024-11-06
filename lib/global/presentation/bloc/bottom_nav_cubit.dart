import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_app/core/route/routes.dart';

class BottomNavMenuItem {
  final int index;
  final String title;
  final String route;
  final Widget icon;
  final Widget? activeIcon;

  BottomNavMenuItem({
    required this.index,
    required this.title,
    required this.route,
    required this.icon,
    this.activeIcon,
  });
}

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(0);

  final navMenus = [
    BottomNavMenuItem(
        index: 0,
        title: "Home",
        route: Routes.home,
        icon: const Icon(Icons.home_outlined),
        activeIcon: const Icon(Icons.home)),
    BottomNavMenuItem(
        index: 1,
        title: "Users",
        route: Routes.users,
        icon: const Icon(Icons.person_outline),
        activeIcon: const Icon(Icons.person)),
  ];

  void changeIndex(int index) {
    emit(index);
  }
}
