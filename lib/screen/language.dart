import 'package:flutter/material.dart';
import 'package:math/provider/phepTinh_State.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';
import 'home/homepage.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
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
                "Ngôn ngữ",
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
            body: Selector<PhepTinh,int>(
              selector: (ctx, state) => state.indexLanguage,
              builder: (context, value, child) {
                return Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(supportedLanguage.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                        onTap: () {
                          context.read<PhepTinh>().updateIndexLanguage(index);
                          print(supportedLanguage[index]);
                        },
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: value == index ? Yellow2 : Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFFE7D7BE), offset: Offset(0, 5))
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image(
                                  width: 50,
                                  height: 50,
                                  image: AssetImage(
                                      'assets/image/${supportedLanguage[index]}.png')),
                              Text(languageCodeToName[supportedLanguage[index]]!),
                            ],
                          ),
                        ),
                      ),
                    );
                  }));
              },
            )
            // ListView.builder(
            //     itemCount: supportedLanguage.length,
            //     scrollDirection: Axis.vertical,
            //     itemBuilder: (context, index) {
            //       return GestureDetector(
            //       onTap: () {
            //         context.read<PhepTinh>().updateIndexLanguage(index);
            //       },
            //       child: Container(
            //         height: 100,
            //         width: 100,
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius: BorderRadius.circular(15),
            //           boxShadow: [
            //             BoxShadow(color: Color(0xFFE7D7BE), offset: Offset(0, 5))
            //           ],
            //         ),
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Image(
            //               width: 50,
            //               height: 50,
            //               image: AssetImage('assets/image/${supportedLanguage[index]}.png')),
            //             Text(languageCodeToName[supportedLanguage[index]]!),
            //           ],
            //         ),
            //       ),
            //     );
            //     },
            // ),
            )
      ],
    );
  }
}
