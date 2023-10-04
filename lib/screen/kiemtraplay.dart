import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math/screen/result.dart';
import 'package:provider/provider.dart';

import '../common/flip_widget.dart';
import '../common/result_dialog.dart';
import '../configs/style_configs.dart';
import '../model/number_model.dart';
import '../provider/phepTinh_State.dart';

class KiemTraPlay extends StatefulWidget {
  const KiemTraPlay({super.key});

  @override
  State<KiemTraPlay> createState() => _KiemTraPlayState();
}

class _KiemTraPlayState extends State<KiemTraPlay> {
  Box boxNumber = Hive.box(boxNumbers);
  late int A;
  late int B;
  late int answer;
  List<NumberModel> lNumber = [];
  List<int> lAnswer = [];
  late NumberModel answerNumber;
  int randomInRange(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }

  doDaianswer() {
    String dodai = answer.toString();
    return dodai.length;
  }

  ranDomAnswer(_answer) {
    int randomNumber = 0;
    if (doDaianswer() < 3) {
      randomNumber = randomInRange(_answer - 5, _answer + 5);
    } else if (doDaianswer() >= 3) {
      randomNumber = randomInRange(_answer - 50, _answer + 50);
    }
    return randomNumber;
  }

  born() {
    A = randomInRange(1, 10);
    B = randomInRange(1, 10);
    answer = A * B;
    answerNumber = context.read<PhepTinh>().phepTinh
        ? NumberModel(
            A: A, B: B, answer: answer, checkAnswer: false, isPick: false,pheptinh: context.read<PhepTinh>().phepTinh)
        : NumberModel(
            A: answer, B: B, answer: A, checkAnswer: false, isPick: false,pheptinh: context.read<PhepTinh>().phepTinh);
  }

  addAsnwer() {
    NumberModel tmpNumber;
    lNumber = [];
    lAnswer = [];
    lNumber.add(answerNumber);
    if (context.read<PhepTinh>().phepTinh) {
      lAnswer.add(answer);
      while (lNumber.length < 4) {
        int randomNumber = ranDomAnswer(answer);
        if (randomNumber > 0 && !lAnswer.contains(randomNumber)) {
          lAnswer.add(randomNumber);
          tmpNumber = NumberModel(
              A: A,
              B: B,
              answer: randomNumber,
              checkAnswer: false,
              isPick: false,pheptinh: context.read<PhepTinh>().phepTinh);
          lNumber.add(tmpNumber);
        }
      }
    } else {
      lAnswer.add(A);
      while (lNumber.length < 4) {
        int randomNumber = ranDomAnswer(A);
        if (randomNumber >= 0 && !lAnswer.contains(randomNumber)) {
          lAnswer.add(randomNumber);
          tmpNumber = NumberModel(
              A: answer,
              B: B,
              answer: randomNumber,
              checkAnswer: false,
              isPick: false,pheptinh: context.read<PhepTinh>().phepTinh);
          lNumber.add(tmpNumber);
        }
      }
    }
    lNumber.shuffle();
  }
  checkAnswer(int index){
    if(lNumber[index].answer == (context.read<PhepTinh>().phepTinh ? answer : A)){
      lNumber[index].checkAnswer = true;
    }
    context.read<PhepTinh>().listAnswer.add(lNumber[index]);
    setState(() {
            born();
            addAsnwer();
    });
    if(context.read<PhepTinh>().listAnswer.length >= 10){
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(manchoi: false),));
        showDialog(
          context: context, 
          builder: (context) {
            return ResultDialog();
          },);
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    born();
    addAsnwer();
    context.read<PhepTinh>().listAnswer = [];
  }

  Widget build(BuildContext context) {
    return Stack(children: [
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
          title: GestureDetector(
            onTap: () {
              print("${boxNumber.get(32)!.numberStar}");
            },
            child: Text(
              "Kiểm tra",
              style: TextStyle(color: Colors.black),
            ),
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
          actions: [
            Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  "1/10",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                ))
          ],
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 120,
                  width: 380,
                  decoration: BoxDecoration(
                      color: BGYellow, borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${answerNumber.A} ${context.read<PhepTinh>().phepTinh ? "x" : ":"} ${answerNumber.B} = ",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: stroke,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Center(
                            child: Text(
                          "?",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: stroke),
                        )),
                      ),
                    ],
                  )),
               SizedBox(
                height: 150,
               )   ,
              Container(
                  height: 350,
                  width: 380,
                  child: GridView.builder(
                    itemCount: lNumber.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisExtent: 150,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: (){
                          checkAnswer(index);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: stroke,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                              child: Text(
                            "${lNumber[index].answer}",
                            style: TextStyle(
                                fontSize: 20,
                                color: !lNumber[index].isPick
                                    ? Colors.black
                                    : Colors.white),
                          )),
                        ),
                      );
                    },
                  ))
            ],
          ),
        ),
      )
    ]);
  }
}
