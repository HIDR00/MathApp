import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math/configs/style_configs.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:math/screen/bangtinh.dart';
import 'package:math/screen/home/setting.dart';
import 'package:math/screen/howtoplay.dart';
import 'package:math/screen/language.dart';
import 'package:math/screen/luyentap.dart';
import 'package:math/screen/more_app.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../policy.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key,required this.phepTinh});
  final bool phepTinh;

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<PhepTinh>().getTienTrinh();
  }
  Box boxNumber = Hive.box(boxNumbers);
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
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Setting()));
                    },
                    child: Container(
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
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => Language()));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: stroke
                        ),
                        shape: BoxShape.circle
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2),
                        child: Image(
                          image: AssetImage('assets/image/vi.png')
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(AppLocalizations.of(context)!.bangtinhcuuchuong,
              textAlign: TextAlign.center,
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("A x B",style: TextStyle(fontSize: 20,color: widget.phepTinh ? Color(0xFFFEFDF7) : Colors.black),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,top: 8),
                        child: Text("${(context.read<PhepTinh>().tienTrinh1 *100).toInt()}%",style: TextStyle(fontSize: 18,color:  Color(0xFFFEFDF7))),
                      )
                    ],
                  ),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("A : B",style: TextStyle(fontSize: 20,color: widget.phepTinh ? Colors.black : Color(0xFFFEFDF7)),),
                      Padding(
                        padding: const EdgeInsets.only(left: 8,top: 8),
                        child: Text("${(context.read<PhepTinh>().tienTrinh2 *100).toInt()}%",style: TextStyle(fontSize: 18,color:   Color(0xFFFEFDF7))),
                      )
                    ],
                  ),
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
                            child: Center(child: Text(AppLocalizations.of(context)!.bangtinh,style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => LuyenTap()));
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
                            child: Center(child: Text(AppLocalizations.of(context)!.luyentap,style: TextStyle(fontSize: 20),)),
                          ),
                        ),
            ),     
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => HowToPlay(pheptinh: widget.phepTinh)));
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
                            child: Center(child: Text(AppLocalizations.of(context)!.kiemtra,style: TextStyle(fontSize: 20),)),
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
                            child: Center(child: Text(AppLocalizations.of(context)!.trochoirenluyen,style: TextStyle(fontSize: 20),)),
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
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PrivacyPolicy(name: 'Thông tinh ứng dụng',url: 'https://www.techlead.vn/kid-math-quiz/'),));
                        },
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
                  ),
                  GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => MoreApp()));
                    },
                    child: Container(
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
                          image: AssetImage('assets/image/path6.png'),
                        )  
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                        String title = "Learn Math: Times Tables for kids";
                        String link = "https://www.techlead.vn/";
                        String chooserTitle = "Learn Math: Times Tables for kids";
                        Share.share('$title\n$link', subject: chooserTitle);
                    },
                    child: Container(
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
                  ),
                  GestureDetector(
                    onTap: () async {
                      final likeUrl = Uri.parse('https://play.google.com/store/apps/details?id=vn.techlead.app.mathapp&fbclid=IwAR347_BEXbk0wKlYwx92nBaIg89QcBVFE2fRlISKMc78UP6bBzwgmM8emjc');
                      if(await canLaunchUrl(likeUrl)){
                        await launchUrl(likeUrl);
                      }
                    },
                    child: Container(
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

