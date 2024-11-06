import 'package:awesome_app/core/constant/auth_constant.dart';
import 'package:awesome_app/core/route/routes.dart';
import 'package:awesome_app/global/presentation/bloc/auth_cubit.dart';
import 'package:awesome_app/global/presentation/bloc/auth_state.dart';
import 'package:awesome_app/core/localization/localization.dart';
import 'package:awesome_app/global/presentation/bloc/bottom_nav_cubit.dart';
import 'package:awesome_app/global/presentation/bloc/localization_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MainPage extends StatelessWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => BottomNavCubit()),
      ],
      child: _MainLayout(child: child),
    );
  }
}

class _MainLayout extends StatelessWidget {
  final Widget child;

  const _MainLayout({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthCubit, AuthState>(
          listener: (_, state) {
            if (state.status == AuthStatus.unauthenticated) {
              context.goNamed(Routes.login);
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)?.name ?? "",
          ),
          actions: [
            PopupMenuButton<Locale>(
              initialValue:
                  context.select((LocalizationCubit cubit) => cubit.state),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.language),
                    const SizedBox(width: 8),
                    Text(
                      context
                          .select((LocalizationCubit cubit) => cubit.state)
                          .languageCode
                          .toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              itemBuilder: (ctx) => Localization.supportedLocales
                  .map(
                    (e) => PopupMenuItem<Locale>(
                      value: e,
                      child: Text(e.languageCode.toUpperCase()),
                    ),
                  )
                  .toList(),
              onSelected: (locale) {
                context.read<LocalizationCubit>().changeLanguage(locale);
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {
                context.read<AuthCubit>().logout();
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.select((BottomNavCubit cubit) => cubit.state),
          items: context
              .read<BottomNavCubit>()
              .navMenus
              .map((e) => BottomNavigationBarItem(
                    icon: e.icon,
                    activeIcon: e.activeIcon,
                    label: e.title,
                  ))
              .toList(),
          onTap: (index) {
            context.read<BottomNavCubit>().changeIndex(index);

            context.goNamed(
              context.read<BottomNavCubit>().navMenus[index].route,
            );
          },
        ),
        body: child,
      ),
    );
  }
}
