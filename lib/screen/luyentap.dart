import 'package:flutter/material.dart';
import 'package:math/common/flip_widget.dart';
import 'package:math/common/result_dialog.dart';
import 'package:math/screen/result.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../configs/style_configs.dart';
import '../provider/phepTinh_State.dart';

class LuyenTap extends StatefulWidget {
  LuyenTap({super.key,required this.pheptinh});
  final bool pheptinh;

  @override
  State<LuyenTap> createState() => _LuyenTapState();
}

class _LuyenTapState extends State<LuyenTap> {
  late int A;
  late int B;
  late int answer;
  List<int> lAnswer = [];
  bool _checkAnswer = false;
  List<bool> lCheckAnswer = [];
  List<bool> isPick = [];
  int questionLength = 0;
  String indexImage = "1";
  int randomInRange(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }
  doDaianswer(){
    String dodai = answer.toString();
    return dodai.length;
  }
  ranDomAnswer(){
    int randomNumber = 0;
    if(doDaianswer() < 3){
      randomNumber = randomInRange(answer-5,answer+5);
    }else if(doDaianswer() >= 3){
      randomNumber = randomInRange(answer-50,answer+50);
    }
    return randomNumber;
  }
  addAsnwer(){
    lAnswer = [];
    lCheckAnswer = [];
    isPick = [];
    lAnswer.add(answer);
    lCheckAnswer.add(false);
    isPick.add(false);
    while(lAnswer.length < 4){
      int randomNumber = ranDomAnswer();
      if(randomNumber > 0 && !lAnswer.contains(randomNumber)){
        lAnswer.add(randomNumber);
        lCheckAnswer.add(false);
        isPick.add(false);
      }
    }
    lAnswer.shuffle();
  }
  born(){
    A = randomInRange(1, 10);
    B = randomInRange(1, 10);
    indexImage = B.toString();
    answer = A * B;
  }

  checkAnswer(int index){
    if(answer == lAnswer[index]){
      if(questionLength < 10){
        context.read<PhepTinh>().startAnimation(AnimationStatus.completed);
        questionLength++;
        print("A");
        isPick[index] = true;
        setState(() {
          _checkAnswer = true;
          lCheckAnswer[index] = true;
        });
        Future.delayed(const Duration(seconds: 1)).then((value) {
          setState(() {
            born();
            addAsnwer();
            _checkAnswer = false;
          });
        });
      }else{
        isPick[index] = true;
        setState(() {
          lCheckAnswer[index] = true;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(),));
        showDialog(
          context: context, 
          builder: (context) {
            return ResultDialog();
          },);
      }
    }else{
      print("B");
      setState(() {
        isPick[index] = true;
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    born();
    addAsnwer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(),));
              },
              child: Text("Bài học",
                style: TextStyle(
                  color: Colors.black
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: BG,
            shadowColor: Shadow,
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: stroke
                  ),
                  color: Yellow2,
                  shape: BoxShape.circle
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: stroke,
                ),
              ),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(top: 20,right: 10),
                child: Text("${questionLength}/10",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),))
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
                  color: BGYellow,
                  borderRadius:BorderRadius.circular(10)
                ),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(A, (index) => Padding(
                    padding: const EdgeInsets.only(left: 10,top: 5,bottom: 5),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: Image(image: AssetImage("assets/image/dice_${indexImage}.png"))),
                  ))
                )
              ),
              SizedBox(
                height: 10,
              ),
              FlipWidget(A: A,B: B,answer: answer ,flip: _checkAnswer),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 350,
                width: 380,
                child: GridView.builder(
                  itemCount: lAnswer.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisExtent: 150,mainAxisSpacing: 10,crossAxisSpacing: 20
                    ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        checkAnswer(index);
                        print("listCheck: ${lCheckAnswer}");
                        print("isPick: ${isPick}");
                      },
                      child: Container(
                          decoration: BoxDecoration(
                            color: !isPick[index] ? Colors.white : lCheckAnswer[index] ? True : Wrong,
                            border: Border.all(
                              color: stroke,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Center(
                            child: Text("${lAnswer[index]}",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: !isPick[index] ? Colors.black : Colors.white
                                                ),
                                        )
                                ),
                        ),
                    );
                  },
                ) 
              )
            ],
          ),
        ),
        )
      ] 
    );
  }
}