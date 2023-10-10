import 'package:flutter/material.dart';
import 'package:math/common/flip_widget.dart';
import 'package:math/common/result_dialog.dart';
import 'package:math/model/number_model.dart';
import 'package:math/screen/result.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../configs/style_configs.dart';
import '../provider/phepTinh_State.dart';

class LuyenTap extends StatefulWidget {
  LuyenTap({super.key});

  @override
  State<LuyenTap> createState() => _LuyenTapState();
}

class _LuyenTapState extends State<LuyenTap> {
  late int A;
  late int B;
  late int answer;
  late int kkq1;
  late int kkq2;
  late int ks1;
  late int ks2;
  List<NumberModel> lNumber = [];
  late NumberModel answerNumber;
  bool _checkAnswer = false;
  int questionLength = 0;
  List<int> lAnswer = [];
  String indexImage = "1";
  String amount = '';

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
    kkq1 = context.read<PhepTinh>().kkq1;
    kkq2 = context.read<PhepTinh>().kkq2;
    ks1 = context.read<PhepTinh>().ks1;
    ks2 = context.read<PhepTinh>().ks2;
    A = randomInRange(1, 10);
    B = randomInRange(1, 10);
    indexImage = B.toString();
    answer = A * B;
    while (answer < kkq1 ||
        answer > kkq2 ||
        A < ks1 ||
        A > ks2 ||
        B < ks1 ||
        B > ks2) {
      born();
    }
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

  checkAnswer(int index, List<NumberModel> lNumbers) {
    if (_checkAnswer) return;
    if (lNumber[index].answer ==
        (context.read<PhepTinh>().phepTinh ? answer : A)) {
      if (!lNumber[index].isPick) {
        context.read<PhepTinh>().listAnswer.add(lNumber[index]);
      }
      if (questionLength < 9) {
        context.read<PhepTinh>().startAnimation(AnimationStatus.completed);
        questionLength++;
        print("A");
        lNumber[index].isPick = true;
        setState(() {
          _checkAnswer = true;
          lNumber[index].checkAnswer = true;
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          setState(() {
            born();
            addAsnwer();
            _checkAnswer = false;
          });
        });
      } else {
        lNumber[index].isPick = true;
        setState(() {
          lNumber[index].checkAnswer = true;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Result(
            manchoi: true,
          ),
        ));
        showDialog(
          context: context,
          builder: (context) {
            return ResultDialog();
          },
        );
      }
      if (A >= 0 && A <= 11 && B >= 0 && B <= 11) {
        context.read<PhepTinh>().phepTinh
            ? lNumbers[24 * A + B * 2].numberStar =
                lNumbers[24 * A + B * 2].numberStar + 1
            : lNumbers[24 * A + B * 2 + 1].numberStar =
                lNumbers[24 * A + B * 2 + 1].numberStar + 1;
        print(
            "index: ${context.read<PhepTinh>().phepTinh ? 24 * A + B * 2 : 24 * A + B * 2 + 1}");
        print(
            "star: ${context.read<PhepTinh>().phepTinh ? context.read<PhepTinh>().lNumber[24 * A + B * 2].numberStar : context.read<PhepTinh>().lNumber[24 * A + B * 2 + 1].numberStar}");
        context.read<PhepTinh>().putdata();
      }
    } else {
      print("B");
      if (!lNumber[index].isPick) {
        context.read<PhepTinh>().listAnswer.add(lNumber[index]);
      }
      setState(() {
        lNumber[index].isPick = true;
      });
    }
    print("list Answer: ${context.read<PhepTinh>().listAnswer.length}");
  }

  checkAnswer2(List<NumberModel> lNumbers) {
    if (int.parse(context.read<PhepTinh>().answerDisplay) ==
        (context.read<PhepTinh>().phepTinh ? answer : A)) {
      context.read<PhepTinh>().listAnswer.add(answerNumber);
      if (questionLength < 9) {
        context.read<PhepTinh>().startAnimation(AnimationStatus.completed);
        questionLength++;
        print("A");
        answerNumber.isPick = true;
        setState(() {
          _checkAnswer = true;
          answerNumber.checkAnswer = true;
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          setState(() {
            born();
            addAsnwer();
            _checkAnswer = false;
          });
        });
      } else {
        answerNumber.isPick = true;
        setState(() {
          answerNumber.checkAnswer = true;
        });
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Result(
            manchoi: true,
          ),
        ));
        showDialog(
          context: context,
          builder: (context) {
            return ResultDialog();
          },
        );
      }
      if (A >= 0 && A <= 11 && B >= 0 && B <= 11) {
        context.read<PhepTinh>().phepTinh
            ? lNumbers[24 * A + B * 2].numberStar =
                lNumbers[24 * A + B * 2].numberStar + 1
            : lNumbers[24 * A + B * 2 + 1].numberStar =
                lNumbers[24 * A + B * 2 + 1].numberStar + 1;
        print(
            "index: ${context.read<PhepTinh>().phepTinh ? 24 * A + B * 2 : 24 * A + B * 2 + 1}");
        print(
            "star: ${context.read<PhepTinh>().phepTinh ? context.read<PhepTinh>().lNumber[24 * A + B * 2].numberStar : context.read<PhepTinh>().lNumber[24 * A + B * 2 + 1].numberStar}");
        context.read<PhepTinh>().putdata();
      }
      context.read<PhepTinh>().getAnswerDisplay('');
      amount = '';
    } else {
      print("B");
      NumberModel tmp = context.read<PhepTinh>().phepTinh ? NumberModel(A: A, B: B, answer: int.parse(context.read<PhepTinh>().answerDisplay), checkAnswer: false, isPick: true, pheptinh: context.read<PhepTinh>().phepTinh) :
      NumberModel(A: answer, B: B, answer: int.parse(context.read<PhepTinh>().answerDisplay), checkAnswer: false, isPick: true, pheptinh: context.read<PhepTinh>().phepTinh);
      context.read<PhepTinh>().listAnswer.add(tmp);
      context.read<PhepTinh>().getAnswerDisplay('');
      amount = '';
    }
  }

  onKeyTap(val) {
    amount = amount + val;
    context.read<PhepTinh>().getAnswerDisplay(amount);
  }

  onBackPress() {
    amount = amount.substring(0, amount.length - 1);
    context.read<PhepTinh>().getAnswerDisplay(amount);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    born();
    addAsnwer();
    context.read<PhepTinh>().listAnswer = [];
    context.read<PhepTinh>().getTypeAnswerLT();
  }

  @override
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
          title: Text(
            "Bài học",
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
          actions: [
            Padding(
                padding: EdgeInsets.only(top: 20, right: 10),
                child: Text(
                  "${questionLength + 1}/10",
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
                height: 20,
              ),
              Container(
                  height: 120,
                  width: 380,
                  decoration: BoxDecoration(
                      color: BGYellow, borderRadius: BorderRadius.circular(10)),
                  child: context.read<PhepTinh>().htk ? Wrap(
                      direction: Axis.horizontal,
                      children: List.generate(
                          A,
                          (index) => Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 5, bottom: 5),
                                child: Container(
                                    height: 50,
                                    width: 50,
                                    child: Image(
                                        image: AssetImage(
                                            "assets/image/dice_${indexImage}.png"))),
                              ))) : Center(child: Text("Bảng tính \n cửu chương",textAlign: TextAlign.center,style: TextStyle(fontSize: 20),))
                              ),
              SizedBox(
                height: 10,
              ),
              FlipWidget(
                  A: answerNumber.A,
                  B: answerNumber.B,
                  answer: answerNumber.answer,
                  flip: _checkAnswer),
              SizedBox(
                height: 80,
              ),
              context.read<PhepTinh>().typeAnswerLT
                  ? Container(
                      height: 400,
                      width: 380,
                      child: GridView.builder(
                        itemCount: lNumber.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 150,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          return Selector<PhepTinh, List<NumberModel>>(
                            selector: (ctx, state) => state.lNumber,
                            builder: (context, value, child) {
                              return GestureDetector(
                                onTap: () {
                                  checkAnswer(index, value);
                                  print(
                                      "listCheck: ${lNumber[index].checkAnswer}");
                                  print("isPick: ${lNumber[index].isPick}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: !lNumber[index].isPick
                                        ? Colors.white
                                        : lNumber[index].checkAnswer
                                            ? True
                                            : Wrong,
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
                          );
                        },
                      ))
                  : Selector<PhepTinh, List<NumberModel>>(
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
                      }),
            ],
          ),
        ),
      )
    ]);
  }
}
