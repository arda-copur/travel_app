import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:travel_app/utils/connectivity/connectivity_provider.dart';
import 'package:travel_app/utils/init/dotenv_init.dart';
import 'package:travel_app/utils/init/firebase_init.dart';
import 'package:travel_app/utils/init/localization_init.dart';
import 'package:travel_app/utils/init/system_init.dart';
import 'package:travel_app/utils/localization/localization_provider.dart';
import 'package:travel_app/utils/route/app_routes.dart';
import 'package:travel_app/utils/theme/theme.dart';
import 'package:travel_app/viewmodels/auth_viewmodel.dart';
import 'package:travel_app/viewmodels/gemini_chat_viewmodel.dart';
import 'package:travel_app/viewmodels/home_viewmodel.dart';
import 'package:travel_app/viewmodels/profile_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDotenv();
  configureSystemChrome();
  await initializeFirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => ProfileViewModel()),
        ChangeNotifierProvider(create: (_) => LocalizationProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => GeminiChatViewModel()),
      ],
      child: Consumer<AuthViewModel>(
        builder: (context, authViewModel, child) {
          return MaterialApp(
              title: AppLocalizations.of(context)?.appName ?? 'Travel Planner',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: ThemeMode.system,
              localizationsDelegates: LocalizationInit.localizationsDelegates,
              locale: Provider.of<LocalizationProvider>(context).locale,
              supportedLocales: LocalizationInit.supportedLocales,
              localeResolutionCallback:
                  LocalizationInit.localeResolutionCallback,
              initialRoute: AppRoutes.splash,
              routes: AppRoutes.routes);
        },
      ),
    );
  }
}
