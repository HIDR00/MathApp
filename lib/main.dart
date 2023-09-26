
import 'package:flutter/material.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/screen/bangtinh.dart';
import 'package:provider/provider.dart';
import 'home/homepage.dart';
import 'home/homepageScreen.dart';

void main() {
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
