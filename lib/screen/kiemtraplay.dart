import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:math/screen/result.dart';
import 'package:percent_indicator/percent_indicator.dart';
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

class _KiemTraPlayState extends State<KiemTraPlay> with TickerProviderStateMixin{
  Box boxNumber = Hive.box(boxNumbers);
  late int A;
  late int B;
  late int answer;
  List<NumberModel> lNumber = [];
  List<int> lAnswer = [];
  List<String> lQuestion = [];
  late NumberModel answerNumber;
  String amount = '';
   late AnimationController _controller;
  double percent = 1.0; 
  int ctl = 1;

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
            A: A,
            B: B,
            answer: answer,
            checkAnswer: false,
            isPick: false,
            pheptinh: context.read<PhepTinh>().phepTinh)
        : NumberModel(
            A: answer,
            B: B,
            answer: A,
            checkAnswer: false,
            isPick: false,
            pheptinh: context.read<PhepTinh>().phepTinh);
      String question = A.toString() + (context.read<PhepTinh>().phepTinh ? 'x' : ':') + B.toString();
      print("question: ${question}");
      if(lQuestion.contains(question)){
        print('check');
        born();
      }
      lQuestion.add(question);
  }

  addAsnwer() {
    NumberModel tmpNumber;
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
              isPick: false,
              pheptinh: context.read<PhepTinh>().phepTinh);
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
              isPick: false,
              pheptinh: context.read<PhepTinh>().phepTinh);
          lNumber.add(tmpNumber);
        }
      }
    }
    lNumber.shuffle();
  }

  checkAnswer(int index) {
    if (lNumber[index].answer ==
        (context.read<PhepTinh>().phepTinh ? answer : A)) {
      lNumber[index].checkAnswer = true;
    }
    context.read<PhepTinh>().listAnswer.add(lNumber[index]);
    ctl++;
    startCountdown();
    setState(() {
      born();
      addAsnwer();
    });
    if (ctl >= 10) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Result(manchoi: false),
      ));
      showDialog(
        context: context,
        builder: (context) {
          return ResultDialog();
        },
      );
    }
  }

  checkAnswer2(List<NumberModel> lNumbers) {
    if (context.read<PhepTinh>().answerDisplay != '' && int.parse(context.read<PhepTinh>().answerDisplay) ==
        (context.read<PhepTinh>().phepTinh ? answer : A)) {
          print('true');
      answerNumber.checkAnswer = true;
      context.read<PhepTinh>().listAnswer.add(answerNumber);
    } else {
      print("false");
      NumberModel tmp = context.read<PhepTinh>().phepTinh
          ? NumberModel(
              A: A,
              B: B,
              answer: context.read<PhepTinh>().answerDisplay == '' ? -1 : int.parse(context.read<PhepTinh>().answerDisplay),
              checkAnswer: false,
              isPick: true,
              pheptinh: context.read<PhepTinh>().phepTinh)
          : NumberModel(
              A: answer,
              B: B,
              answer: context.read<PhepTinh>().answerDisplay == '' ? -1 : int.parse(context.read<PhepTinh>().answerDisplay),
              checkAnswer: false,
              isPick: true,
              pheptinh: context.read<PhepTinh>().phepTinh);
      context.read<PhepTinh>().listAnswer.add(tmp);
    }
    if (context.read<PhepTinh>().listAnswer.length >= 10) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Result(manchoi: false),
      ));
      showDialog(
        context: context,
        builder: (context) {
          return ResultDialog();
        },
      );
      context.read<PhepTinh>().getAnswerDisplay('');
      amount = '';
    }else{
      startCountdown();
      context.read<PhepTinh>().getAnswerDisplay('');
      amount = '';
      setState(() {
        born();
        addAsnwer();
        ctl++;
      });
    }
  }

  onKeyTap(val) {
    amount = amount + val;
    context.read<PhepTinh>().getAnswerDisplay(amount);
  }

  onBackPress() {
    if(amount.length > 0){
      amount = amount.substring(0, amount.length - 1);
    }else{
      amount = '';
    }
    context.read<PhepTinh>().getAnswerDisplay(amount);
  }
  void startCountdown() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: context.read<PhepTinh>().tgtl), // Thời gian đếm ngược
    );

    _controller.reverse(from: 1.0);
    
    _controller.addListener(() {
      setState(() {
        percent = _controller.value;
        if(percent == 0.0){
          context.read<PhepTinh>().typeAnswerKT ? checkAnswer2(context.read<PhepTinh>().lNumber) : checkAnswer(ctl-1);
          setState(() {
          context.read<PhepTinh>().getAnswerDisplay(amount);
          percent = 1.0;
          if (ctl > 10) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Result(manchoi: false),
      ));
      showDialog(
        context: context,
        builder: (context) {
          return ResultDialog();
        },
      );
    }
          startCountdown();
        });
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    born();
    addAsnwer();
    context.read<PhepTinh>().listAnswer = [];
    startCountdown();
    lNumber = [];
  }

   void dispose() {
    _controller.dispose(); 
    super.dispose();
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
              print("lengthBox: ${boxNumber.get('data').length}");
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
                  "${ctl}/10",
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
              LinearPercentIndicator(
                padding: EdgeInsets.zero,
                lineHeight: 5,
                backgroundColor: Colors.transparent,
                progressColor: button,
                percent: percent,
                
              ),
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
                      context.read<PhepTinh>().typeAnswerKT
                          ? Selector<PhepTinh, String>(
                              selector: (ctx, state) => state.answerDisplay,
                              builder: (context, value, _) {
                                return Container(
                                  height: 50,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                      color: stroke,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Center(
                                      child: Text(
                                    "${value}",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: stroke),
                                  )),
                                );
                              },
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: stroke,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                              ),
                              child: Center(
                                  child: Text(
                                "?",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: stroke),
                              )),
                            )
                    ],
                  )),
              SizedBox(
                height: 150,
              ),
              context.read<PhepTinh>().typeAnswerKT
                  ? Selector<PhepTinh, List<NumberModel>>(
                      selector: (ctx, state) => state.lNumber,
                      builder: (context, value, child) {
                        return Container(
                            height: 400,
                            width: 350,
                            child: GridView.builder(
                              itemCount: 12,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisExtent: 60,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 35),
                              itemBuilder: (context, index) {
                                if (index == 9) {
                                  return GestureDetector(
                                      onTap: () {
                                        onBackPress();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Wrong,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          Icons.backspace_outlined,
                                          color: Wrong,
                                          size: 30,
                                        )),
                                      ));
                                }
                                if (index == 11) {
                                  return GestureDetector(
                                      onTap: () {
                                        checkAnswer2(value);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: True,
                                          border: Border.all(
                                            color: stroke,
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Center(
                                            child: Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                      ));
                                }
                                if (index == 10) {
                                  return GestureDetector(
                                    onTap: () {
                                      onKeyTap("0");
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Yellow2,
                                        border: Border.all(
                                          color: stroke,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "0",
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      )),
                                    ),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    onKeyTap((index + 1).toString());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Yellow2,
                                      border: Border.all(
                                        color: stroke,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${index + 1}",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    )),
                                  ),
                                );
                              },
                            ));
                      })
                  : Container(
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
                            onTap: () {
                              checkAnswer(index);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: stroke,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
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
