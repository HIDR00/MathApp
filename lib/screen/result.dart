import 'package:flutter/material.dart';

import '../configs/style_configs.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    double _width = 350;
    double _wTienTrinh = (340 / 100) *100;
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Kết quả",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: BG,
            shadowColor: Shadow,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Transform.rotate(
                    angle: -0.2,
                    alignment: AlignmentDirectional(4, 40),
                    child: Text(
                      "Tiến trình học \ntập của bạn",
                      textAlign: TextAlign.center,
                    )),
                Padding(
                  padding: const EdgeInsets.only(right: 140, top: 30,bottom: 10),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image(
                          image: AssetImage("assets/images/Vector 1@2x.png"))),
                ),
                Stack(
                  children: [
                    Container(
                      height: 50,
                      width: _width,
                      decoration: BoxDecoration(
                        color: BGYellow,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFFE4C36A),
                          )
                        ],
                        border: Border.all(
                          color: stroke,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5,top: 10),
                      child: Container(
                          height: 30,
                          width: _wTienTrinh,
                          decoration: BoxDecoration(
                            color: button,
                            borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                        ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
