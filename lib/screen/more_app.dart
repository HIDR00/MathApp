
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
          body: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image(image: AssetImage('assets/images/Group 3109.png')),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("English Vocab"),
                            Wrap(
                            direction: Axis.horizontal,
                            children: List.generate(
                                5,
                                (index) => Icon(Icons.star, color: Color(0xFFeeab04)))),
                            Row(
                              children: [
                                Image(image: AssetImage('assets/image/Download.png')),
                                Text("1621")
                              ],
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: ()async {
                  final likeUrl = Uri.parse('https://play.google.com/store/apps/details?id=vn.techlead.android.game.findword');
                      if(await canLaunchUrl(likeUrl)){
                        await launchUrl(likeUrl);
                      }
                },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Color(0xFFFEB704),
                              border: Border.all(color: stroke,width: 1),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Center(child: Text("GET",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                          ),
                        )
                      ],
                    ),
                    Divider(color: Color(0xFFDCDCDC),thickness: 1,)
                  ],
                ),
              );
            },
          ),
        )
      ],
    );
  }
}