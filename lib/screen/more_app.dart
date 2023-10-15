
import 'package:flutter/material.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../configs/style_configs.dart';
import 'home/homepage.dart';

class MoreApp extends StatefulWidget {
  const MoreApp({super.key});

  @override
  State<MoreApp> createState() => _MoreAppState();
}

class _MoreAppState extends State<MoreApp> {
  bool isLoading = true;
  @override
  void fetchData() async {
  // Fetch data from Firebase
  await context.read<PhepTinh>().fetchDataFireBase();
  isLoading = false;
  setState(() {}); // This triggers a rebuild of the UI
}

  void initState() {
  super.initState();
  fetchData();
  isLoading = true;
}
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
          body:
            
           Stack(
             children: [ListView.builder(
              itemCount: context.read<PhepTinh>().listApp.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.amber,
                              image: DecorationImage(image: NetworkImage(context.read<PhepTinh>().listApp[index].image))
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.read<PhepTinh>().listApp[index].Name),
                              Wrap(
                              direction: Axis.horizontal,
                              children: List.generate(
                                 5,
                                  (index1) => Icon(Icons.star, color: index1 <= int.parse(context.read<PhepTinh>().listApp[index].numberStar) ? Color(0xFFeeab04) : Colors.grey))),
                              Row(
                                children: [
                                  Image(image: AssetImage('assets/image/Download.png')),
                                  Text(context.read<PhepTinh>().listApp[index].numberDowload)
                                ],
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: ()async {
                    final likeUrl = Uri.parse(context.read<PhepTinh>().listApp[index].url);
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
             Visibility(
                visible: isLoading,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Yellow2,
                  ),))
             ],
           ),
        )
      ],
    );
  }
}