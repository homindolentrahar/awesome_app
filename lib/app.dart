import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:awesome_app/global/presentation/bloc/auth_cubit.dart';
import 'package:awesome_app/core/localization/localization.dart';
import 'package:awesome_app/global/presentation/bloc/localization_cubit.dart';
import 'package:awesome_app/core/ui/app_theme.dart';
import 'package:awesome_app/core/route/route_config.dart';

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LocalizationCubit()),
        BlocProvider(create: (_) => AuthCubit()),
      ],
      child: const _ApplicationLayout(),
    );
  }
}

class _ApplicationLayout extends StatelessWidget {
  const _ApplicationLayout();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (_, locale) => MaterialApp.router(
        routerConfig: RouteConfig.router,
        title: 'awesome_app',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        locale: locale,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: Localization.supportedLocales,
      ),
    );
  }
}
