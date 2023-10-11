import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:math/configs/style_configs.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/services/setup.dart';
import 'package:provider/provider.dart';
import 'screen/home/homepage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:math/l10n/l10n.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Hive.initFlutter();
  await setUp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => PhepTinh(),
      )
    ],
    builder: ((context, child) {
      return const MyApp();
    }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<PhepTinh, int>(
        selector: (ctx, state) => state.indexLanguage,
        builder: (context, value, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            supportedLocales: L10n.all,
            locale: Locale(
                supportedLanguage[value]),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            initialRoute: HomePage.id,
            routes: {
              HomePage.id: (context) => const HomePage(),
            },
          );
        });
  }
}
