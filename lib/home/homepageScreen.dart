import 'package:flutter/material.dart';
import 'package:math/configs/style_configs.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/screen/bangtinh.dart';
import 'package:math/screen/luyentap.dart';
import 'package:provider/provider.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key,required this.phepTinh});
  final bool phepTinh;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
          )
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60,left: 20,right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: stroke
                      ),
                      shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.settings,
                      size: 30,
                      ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: stroke
                      ),
                      shape: BoxShape.circle
                    ),
                    child: Image(
                      image: AssetImage('assets/images/image 14.png')
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text("  Bảng tính\ncửu chương",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  context.read<PhepTinh>().phepTinh = true;
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: widget.phepTinh ? Color(0xFF73C08F) : Color(0xFFFEFDF7),
                    boxShadow:[
                      BoxShadow(color: Color(0xFFE7D7BE),offset: Offset(0, 5))
                    ],
                    shape: BoxShape.circle
                  ),
                  child: Center(child: Text("A x B",style: TextStyle(fontSize: 20),)),
                ),
              ),
              SizedBox(
                width: 40,
              ),
              GestureDetector(
                onTap: (){
                  context.read<PhepTinh>().phepTinh = false;
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: widget.phepTinh ? Color(0xFFFEFDF7) : Color(0xFF73C08F) ,
                    boxShadow:[
                      BoxShadow(color: Color(0xFFE7D7BE),offset: Offset(0, 5))
                    ],
                    shape: BoxShape.circle
                  ),
                  child: Center(child: Text("A : B",style: TextStyle(fontSize: 20),)),
                ),
              ),
            ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => BangTinh(phepTinh: widget.phepTinh,)));
                },
                    child: Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Yellow2,
                              boxShadow: [
                                BoxShadow(color: Color(0xFFE4C36A),
                                )
                              ],
                              border: Border.all(
                                color: stroke,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(child: Text("Bảng tính",style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => LuyenTap(pheptinh: widget.phepTinh,)));
                },
                    child: Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Yellow2,
                              boxShadow: [
                                BoxShadow(color: Color(0xFFE4C36A),
                                )
                              ],
                              border: Border.all(
                                color: stroke,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(child: Text("Luyện tập",style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                },
                    child: Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Yellow2,
                              boxShadow: [
                                BoxShadow(color: Color(0xFFE4C36A),
                                )
                              ],
                              border: Border.all(
                                color: stroke,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(child: Text("Kiểm tra",style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                },
                    child: Container(
                            height: 60,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Yellow2,
                              boxShadow: [
                                BoxShadow(color: Color(0xFFE4C36A),
                                )
                              ],
                              border: Border.all(
                                color: stroke,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Center(child: Text("Trò chơi rèn luyện",style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: stroke
                          ),
                          shape: BoxShape.circle
                        ),
                        child: Center(
                          child: Text("Abs",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.block,
                        color: Wrong,
                        size: 50,
                      ),
                    ]
                  ),
                  Container(
                    height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: stroke
                        ),
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Text("?",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF73C08F),
                          ),
                        ),
                      ),
                  ),
                  Container(
                    height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: stroke
                        ),
                        shape: BoxShape.circle
                      ),
                      child: Center(
                        child: Icon(
                          Icons.share
                        ),
                      ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: stroke
                        ),
                        shape: BoxShape.circle
                      ),
                      child: Image(
                        image: AssetImage('assets/icons/Mask group.png'),
                      )  
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

