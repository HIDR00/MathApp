import 'package:flutter/material.dart';
import 'package:math/configs/style_configs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Training extends StatefulWidget {
  const Training({super.key});

  @override
  State<Training> createState() => _TrainingState();
}

class _TrainingState extends State<Training> {
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
            AppLocalizations.of(context)!.trochoirenluyen,
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
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 180,
                      width: 180,
                                    decoration: BoxDecoration(
                                      color:  Colors.white,
                                      border: Border.all(
                                        color: stroke,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(image: AssetImage('assets/image/block.png'),height: 80),
                                        Text("Ghi nhớ điện",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
                                        Text("Kỉ lục: 7",style: TextStyle(color: Color(0xFFEEB10D)),),
                                        Text("Ghi nhớ và chọn các ô\n sáng lên",textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFC8C3B6)),)
                                      ],
                                    )
                                  ),
                                  Container(
                                    height: 180,
                      width: 180,
                                    decoration: BoxDecoration(
                                      color:  Colors.white,
                                      border: Border.all(
                                        color: stroke,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Image(image: AssetImage('assets/image/book.png'),height: 90),
                                        Text("Find Pair",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20)),
                                        Text("Thành tích: 0/60",style: TextStyle(color: Color(0xFFEEB10D))),
                                        Text("Ghi nhớ và lật các cặp thẻ\n có hình giống nhau",textAlign: TextAlign.center,style: TextStyle(color: Color(0xFFC8C3B6)))
                                      ],
                                    )
                                  ),
                  ],
                ),
              )
            ],
          ),
        ),
        )
      ],
    );
  }
}