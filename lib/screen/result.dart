import 'dart:math';

import 'package:flutter/material.dart';
import 'package:math/screen/list_question.dart';
import 'package:math/screen/luyentap.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../configs/style_configs.dart';
import '../home/homepage.dart';
import '../provider/phepTinh_State.dart';

class Result extends StatefulWidget {
  const Result({super.key});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    double _width = 350;
    double _wTienTrinh = (340 / 100) * 100;
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
                  padding:
                      const EdgeInsets.only(right: 140, top: 30, bottom: 10),
                  child: Container(
                      height: 20,
                      width: 20,
                      child: Image(
                          image: AssetImage("assets/images/Vector 1@2x.png"))),
                ),
                Container(
                  height: 40,
                  width: 350,
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: LinearPercentIndicator(
                      backgroundColor: Colors.transparent,
                      progressColor: button,
                      percent: 0.4,
                      lineHeight: 28,
                      barRadius: Radius.circular(10)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DanhSach(),));
                      },
                      child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                              color: True,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("10",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500)),
                              Text("Chính xác",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DanhSach(),));
                      },
                      child: Container(
                          height: 150,
                          width: 160,
                          decoration: BoxDecoration(
                              color: Wrong,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("0",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w500)),
                              Text("Sai",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500))
                            ],
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DanhSach(),));
                      },
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Yellow2,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE4C36A),
                        )
                      ],
                      border: Border.all(
                        color: stroke,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage("assets/image/check_list.png"),
                            height: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Danh sách câu hỏi",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap:(){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => LuyenTap(pheptinh: context.read<PhepTinh>().phepTinh)));
                  },
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Yellow2,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE4C36A),
                        )
                      ],
                      border: Border.all(
                        color: stroke,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage("assets/image/redo.png"),
                            height: 20),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Chơi lại",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.pushNamed(context, HomePage.id);
                  },
                  child: Container(
                    height: 60,
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE4C36A),
                        )
                      ],
                      border: Border.all(
                        color: stroke,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                            image: AssetImage("assets/image/arrow_back.png"),
                            height: 15),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Menu",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
