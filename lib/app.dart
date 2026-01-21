import 'package:chat_app/core/configs/app_configs.dart';
import 'package:chat_app/core/global/app_cubit/app_cubit.dart';
import 'package:chat_app/core/network/api_utils.dart';
import 'package:chat_app/core/theme/app_themes.dart';
import 'package:chat_app/data/repositories/auth_repository.dart';
import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/network/api_client.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ApiClient _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtils.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) {
            return AuthRepositoryImpl(apiClient: _apiClient);
          },
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) {
              return AppCubit();
            },
          ),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentLanguage != current.currentLanguage,
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: MaterialApp.router(
                title: AppConfigs.appName,
                routerConfig: AppRouter.router,
                theme: AppThemes().theme,
                supportedLocales: S.delegate.supportedLocales,
                locale: state.currentLanguage.local,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
