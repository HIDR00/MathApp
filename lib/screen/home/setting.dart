import 'package:flutter/material.dart';
import 'package:math/common/error_dialog.dart';
import 'package:math/common/xoaTienTrinh_dialog.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/screen/policy.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../configs/style_configs.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController kkq1 = TextEditingController();
  TextEditingController kkq2 = TextEditingController();
  TextEditingController ks1 = TextEditingController();
  TextEditingController ks2 = TextEditingController();
  TextEditingController ctl2 = TextEditingController();
  TextEditingController tgtl = TextEditingController();
  FocusNode kkq2FocusNode = FocusNode();
  FocusNode kkq1FocusNode = FocusNode();
  FocusNode ks2FocusNode = FocusNode();
  FocusNode ks1FocusNode = FocusNode();
  FocusNode ctl2FocusNode = FocusNode();
  FocusNode tgt1FocusNode = FocusNode();
  @override
  int countMultiplications(int ks1, int ks2, int kkq1, int kkq2) {
    int count = 0;

    for (int i = ks1; i <= ks2; i++) {
      if (i == 0) continue;
      int lowerBound = (kkq1 ~/ i).clamp(ks1, ks2);
      int upperBound = (kkq2 ~/ i).clamp(ks1, ks2);
      if (lowerBound <= upperBound) {
        count += (upperBound - lowerBound + 1);
      }
    }
  return count;
  }
  

  check() {
    int A = int.parse(ks1.text.trim());
    int B = int.parse(ks2.text.trim());
    if(countMultiplications(A,B,int.parse(kkq1.text.trim()),int.parse(kkq2.text.trim())) < 10){
      return false;
    }
    print(countMultiplications(A,B,int.parse(kkq1.text.trim()),int.parse(kkq2.text.trim())));
    // if (int.parse(kkq1.text.trim()) >= int.parse(kkq2.text.trim()) || A >= B) {
    //   return false;
    // }else if((B - A+1) *(B - A+1) < 10){
    //   return false;
    // }else if(B-A <3){
    //   return false;
    // }else if(B-A == 3){
    //   if((B-1) * (B-1) < int.parse(kkq2.text.trim())){
    //     return false;
    //   }
    //   else{
    //     return true;
    //   }
    // }
    return true;
  }

  Widget build(BuildContext context) {
    // ks1.text = "0";
    // ks2.text = "90000";
    // ctl2.text = "100 %";
    // tgtl.text = "15";
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
              "Cài đặt",
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: BG,
            shadowColor: Shadow,
            leading: GestureDetector(
              onTap: () {
                if (check() == false) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ErrorDialog();
                    },
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              child: Container(
                margin: EdgeInsets.all(10),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                    height: 90,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BGYellow),
                    child: Selector<PhepTinh, bool>(
                      selector: (ctx, state) => state.phepTinh,
                      builder: (ctx, value, _) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "Chế độ",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<PhepTinh>().phepTinh = true;
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: stroke),
                                    borderRadius: BorderRadius.circular(15),
                                    color: value ? Yellow2 : Colors.white),
                                child: Center(
                                    child: Text(
                                  "A x B = ?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: value
                                          ? Colors.black
                                          : Color(0xFF968B7E)),
                                )),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.read<PhepTinh>().phepTinh = false;
                              },
                              child: Container(
                                height: 50,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: stroke),
                                    borderRadius: BorderRadius.circular(15),
                                    color: value ? Colors.white : Yellow2),
                                child: Center(
                                    child: Text(
                                  "A : B = ?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: value
                                          ? Color(0xFF968B7E)
                                          : Colors.black),
                                )),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 10,),
                  Selector<PhepTinh, Tuple2<int, int>>(
                    selector: (ctx, state) => Tuple2(state.kkq1, state.kkq2),
                    builder: (context, value, child) {
                      kkq1.text = value.item1.toString();
                      kkq2.text = value.item2.toString();
                      return Container(
                        height: 130,
                        width: 380,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BGYellow),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 218, top: 20),
                              child: Text("Khoảng kết quả",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border:
                                          Border.all(color: stroke, width: 2),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Checkbox(
                                    value: context.read<PhepTinh>().kkq3,
                                    checkColor: Colors.black,
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    side: BorderSide(color: Colors.white),
                                    activeColor: Yellow2,
                                    onChanged: (newValue) {
                                      setState(() {
                                        context
                                            .read<PhepTinh>()
                                            .updateKkq3(newValue!);
                                        if (context.read<PhepTinh>().kkq3 ==
                                            false) {
                                          context
                                              .read<PhepTinh>()
                                              .updateKkq1(0);
                                          context
                                              .read<PhepTinh>()
                                              .updateKkq2(90000);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  "Từ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border: Border.all(color: stroke),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                    controller: kkq1,
                                    cursorColor: Yellow2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                    focusNode: kkq1FocusNode,
                                    onEditingComplete: () {
                                      try {
                                        context
                                            .read<PhepTinh>()
                                            .updateKkq1(int.parse(kkq1.text));
                                      } catch (e) {
                                        print(e);
                                      }
                                      kkq1FocusNode.unfocus();
                                    },
                                    enabled: context.read<PhepTinh>().kkq3,
                                  ),
                                ),
                                Text(
                                  "đến",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border: Border.all(color: stroke),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                    controller: kkq2,
                                    cursorColor: Yellow2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      border: InputBorder.none
                                    ),
                                    focusNode: kkq2FocusNode,
                                    onEditingComplete: () {
                                      try {
                                        context
                                            .read<PhepTinh>()
                                            .updateKkq2(int.parse(kkq2.text));
                                      } catch (e) {
                                        print(e);
                                      }
                                      kkq2FocusNode.unfocus();
                                    },
                                    enabled: context.read<PhepTinh>().kkq3,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Selector<PhepTinh, Tuple2<int, int>>(
                    selector: (ctx, state) => Tuple2(state.ks1, state.ks2),
                    builder: (ctx, value, _) {
                      ks1.text = context.read<PhepTinh>().ks1.toString();
                      ks2.text = context.read<PhepTinh>().ks2.toString();
                      return Container(
                        height: 140,
                        width: 380,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: BGYellow),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 250, top: 20),
                              child: Text("Khoảng số",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Từ", style: TextStyle(fontSize: 18)),
                                Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border: Border.all(color: stroke),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                    controller: ks1,
                                    cursorColor: Yellow2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    focusNode: ks1FocusNode,
                                    onEditingComplete: () {
                                      try {
                                        context
                                            .read<PhepTinh>()
                                            .updateKs1(int.parse(ks1.text));
                                        context
                                            .read<PhepTinh>().getTienTrinh();
                                      } catch (e) {
                                        print(e);
                                      }
                                      ks1FocusNode.unfocus();
                                    },
                                  ),
                                ),
                                Text("đến", style: TextStyle(fontSize: 18)),
                                Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border: Border.all(color: stroke),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                    controller: ks2,
                                    cursorColor: Yellow2,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 20),
                                    decoration: InputDecoration(
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    focusNode: ks2FocusNode,
                                    onEditingComplete: () {
                                      try {
                                        context
                                            .read<PhepTinh>()
                                            .updateKs2(int.parse(ks2.text));
                                        context
                                            .read<PhepTinh>().getTienTrinh();
                                      } catch (e) {
                                        print(e);
                                      }
                                      ks2FocusNode.unfocus();
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 140,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BGYellow),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 250, top: 20),
                          child: Text("Gõ câu trả lời",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border:
                                          Border.all(color: stroke, width: 2),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Checkbox(
                                    value: context.read<PhepTinh>().typeAnswerKT,
                                    checkColor: Colors.black,
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    side: BorderSide(color: Colors.transparent),
                                    activeColor: Yellow2,
                                    onChanged: (newValue) {
                                      setState(() {
                                        context
                                            .read<PhepTinh>()
                                            .getTypeAnswerKT(newValue!);
                                      });
                                    },
                                  ),
                                ),
                            Text("Kiểm tra", style: TextStyle(fontSize: 18)),
                            Text("Luyện tập từ",
                                style: TextStyle(fontSize: 18)),

                            Selector<PhepTinh,int>(
                              selector: (ctx, state) => state.ctl2,
                              builder: (ctx, value, _) {
                                ctl2.text = context.read<PhepTinh>().ctl2.toString();
                                return Container(
                                    height: 50,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                        border: Border.all(color: stroke),
                                        borderRadius: BorderRadius.circular(15)),
                                    child: TextField(
                                      controller: ctl2,
                                      cursorColor: Yellow2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20),
                                      decoration: InputDecoration(
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      focusNode: ctl2FocusNode,
                                      onEditingComplete: () {
                                        try {
                                          context
                                              .read<PhepTinh>()
                                              .updateClt2(int.parse(ctl2.text));
                                        } catch (e) {
                                          print(e);
                                        }
                                        ctl2FocusNode.unfocus();
                                      },
                                    ),
                                  );
                              } 
                            ),
                          ]
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 140,
                    width: 380,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: BGYellow),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,),
                              child: Text("Hiện khối trong khi học tập:",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                                  height: 22,
                                  width: 22,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                      border:
                                          Border.all(color: stroke, width: 2),
                                      borderRadius: BorderRadius.circular(7)),
                                  child: Checkbox(
                                    value: context.read<PhepTinh>().htk,
                                    checkColor: Colors.black,
                                    shape: BeveledRectangleBorder(
                                        borderRadius: BorderRadius.circular(3)),
                                    side: BorderSide(color: Colors.white),
                                    activeColor: Yellow2,
                                    onChanged: (newValue) {
                                      setState(() {
                                        context
                                            .read<PhepTinh>()
                                            .updatehtk(newValue!);
                                      });
                                    },
                                  ),
                                ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text("Thời gian trả lời (kiểm tra):",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Selector<PhepTinh,int>(
                              selector: (ctx, state) => state.tgtl,
                              builder: (ctx, value, _) {
                                tgtl.text = context.read<PhepTinh>().tgtl.toString();
                                return Expanded(
                                  child: Container(
                                      height: 50,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                          border: Border.all(color: stroke),
                                          borderRadius: BorderRadius.circular(15)),
                                      child: TextField(
                                        controller: tgtl,
                                        cursorColor: Yellow2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 20),
                                        decoration: InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                        focusNode: tgt1FocusNode,
                                        onEditingComplete: () {
                                          try {
                                            context
                                                .read<PhepTinh>()
                                                .updateTgtl(int.parse(tgtl.text));
                                          } catch (e) {
                                            print(e);
                                          }
                                          tgt1FocusNode.unfocus();
                                        },
                                      ),
                                    ),
                                );
                              } 
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child:
                                  Text("Giây", style: TextStyle(fontSize: 18)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          showDialog(
                          context: context,
                          builder: (context) {
                            return XoaTienTrinh();
                          },
                        );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: stroke),
                              color: Yellow2,
                              shape: BoxShape.circle),
                          child: Icon(
                            Icons.delete_forever,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Text(
                        "Xóa tiến trình",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 85,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicy(name: 'Chính sách bảo mật',url: 'https://www.techlead.vn/privacy-policy/'),));
                        },
                        child: Text(
                          "Chính sách bảo mật",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.black,
                            decorationThickness: 2.0,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
