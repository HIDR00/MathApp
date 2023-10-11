import 'package:flutter/material.dart';

import '../configs/style_configs.dart';
import 'home/homepage.dart';

class MoreApp extends StatefulWidget {
  const MoreApp({super.key});

  @override
  State<MoreApp> createState() => _MoreAppState();
}

class _MoreAppState extends State<MoreApp> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          )),
        ),
        Scaffold(
          appBar: AppBar(
          title: Text(
                "Ứng dụng khác",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
              backgroundColor: BG,
              shadowColor: Shadow,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, HomePage.id);
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: stroke),
                      color: Yellow2,
                      shape: BoxShape.circle),
                  child: Icon(
                    Icons.arrow_back,
                    color: stroke,
                  ),
                ),
              ),
          ),
        )
      ],
    );
  }
}