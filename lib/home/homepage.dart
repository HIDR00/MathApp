import 'package:flutter/material.dart';
import 'package:math/home/homepageScreen.dart';
import 'package:provider/provider.dart';

import '../provider/phepTinh_State.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String id = "HomePage";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Selector<PhepTinh,bool>(
      selector: (ctx,state) => state.phepTinh,
      builder: (ctx, value, _){
        return HomePageScreen(phepTinh: value,);
      },
    );
  }
}