
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/services/setup.dart';
import 'package:provider/provider.dart';
import 'screen/home/homepage.dart';

void main() async {
  await Hive.initFlutter();
  await setUp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => PhepTinh(),)
    ],
    builder: ((context,child){
     return const MyApp();
    }),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomePage.id,
      routes: {
        HomePage.id : (context) => const HomePage(),
      },
    );
  }
}
