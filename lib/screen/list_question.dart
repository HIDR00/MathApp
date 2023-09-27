import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../configs/style_configs.dart';
import '../provider/phepTinh_State.dart';

class DanhSach extends StatefulWidget {
  const DanhSach({super.key});

  @override
  State<DanhSach> createState() => _DanhSachState();
}

class _DanhSachState extends State<DanhSach> {
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
              "Danh sách câu hỏi",
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
          body: Padding(
            padding: EdgeInsets.only(left: 15,top: 30),
            child: Container(
                  height: 700,
                  width: 380,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow:[
                          BoxShadow(color: Color(0xFFE7D7BE),offset: Offset(0, 5))
                        ],
                  ),
                  child: ListView.builder(
                    itemCount: context.read<PhepTinh>().listAnswer.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          width: 100,
                          child: 
                          context.read<PhepTinh>().listAnswer[index].checkAnswer ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Icon(Icons.check,color: True,),
                              ),
                              SizedBox(width: 80,),
                              Text("${context.read<PhepTinh>().listAnswer[index].A} x ${context.read<PhepTinh>().listAnswer[index].B} = ${context.read<PhepTinh>().listAnswer[index].Answer}",
                              style: TextStyle(
                                color: True,
                              ),
                              )
                            ],
                          ) : 
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 40),
                                child: Icon(Icons.close_outlined,color: Wrong,),
                              ),
                              SizedBox(width: 80,),
                              Text("${context.read<PhepTinh>().listAnswer[index].A} x ${context.read<PhepTinh>().listAnswer[index].B} = ${context.read<PhepTinh>().listAnswer[index].Answer}",
                              style: TextStyle(
                                color: Wrong,
                              ),
                              )
                            ],
                          )
                        ),
                      );
                    },
                  
                  ),
                ),
          ),
        )
      ],
    );
  }
}