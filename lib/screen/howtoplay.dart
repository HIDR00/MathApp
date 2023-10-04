import 'package:flutter/material.dart';
import 'package:math/screen/kiemtraplay.dart';

import '../configs/style_configs.dart';

class HowToPlay extends StatefulWidget {
  const HowToPlay({super.key, required this.pheptinh});
  final bool pheptinh;
  @override
  State<HowToPlay> createState() => _HowToPlayState();
}

class _HowToPlayState extends State<HowToPlay> {
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              "Kiểm tra",
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: double.infinity,
                ),
                Image(
                  image: AssetImage("assets/image/test_tutorial.png"),
                  height: 350,
                ),
                Text(
                  "Bài  kiểm tra gồm 10 câu hỏi, có \n giới hạn thời gian mỗi câu",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                Text(
                  "Chúc bạn may mắn!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => KiemTraPlay(),));
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
                    child: Center(
                        child: Text(
                          "Sẵn sàng",
                          style: TextStyle(fontSize: 20),
                        )),
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
