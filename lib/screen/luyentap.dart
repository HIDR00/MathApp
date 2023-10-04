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
  List<NumberModel> lNumber = [];
  late NumberModel answerNumber;
  bool _checkAnswer = false;
  int questionLength = 0;
  List<int> lAnswer = [];
  String indexImage = "1";
  int randomInRange(int min, int max) {
    Random random = Random();
    return min + random.nextInt(max - min + 1);
  }
  doDaianswer(){
    String dodai = answer.toString();
    return dodai.length;
  }
  ranDomAnswer(_answer){
    int randomNumber = 0;
    if(doDaianswer() < 3){
      randomNumber = randomInRange(_answer-5,_answer+5);
    }else if(doDaianswer() >= 3){
      randomNumber = randomInRange(_answer-50,_answer+50);
    }
    return randomNumber;
  }
  born(){
    A = randomInRange(1, 10);
    B = randomInRange(1, 10);
    indexImage = B.toString();
    answer = A * B;
    answerNumber = context.read<PhepTinh>().phepTinh ? NumberModel(A: A, B: B, answer: answer, checkAnswer: false,isPick: false,pheptinh: context.read<PhepTinh>().phepTinh) :
    NumberModel(A: answer, B: B, answer: A, checkAnswer: false,isPick: false,pheptinh: context.read<PhepTinh>().phepTinh)
    ;
  }
  addAsnwer(){
    NumberModel tmpNumber;
    lNumber = [];
    lAnswer = [];
    lNumber.add(answerNumber);  
    if(context.read<PhepTinh>().phepTinh){
      lAnswer.add(answer);
      while(lNumber.length < 4){
      int randomNumber =  ranDomAnswer(answer);
      if(randomNumber > 0 && !lAnswer.contains(randomNumber)){
        lAnswer.add(randomNumber);
        tmpNumber =  NumberModel(A: A, B: B,answer: randomNumber, checkAnswer: false, isPick: false,pheptinh: context.read<PhepTinh>().phepTinh);
        lNumber.add(tmpNumber);
      }
    }
    }else{
      lAnswer.add(A);
      while(lNumber.length < 4){
      int randomNumber = ranDomAnswer(A);
      if(randomNumber >= 0 && !lAnswer.contains(randomNumber)){
        lAnswer.add(randomNumber);
        tmpNumber =  NumberModel(A: answer, B: B, answer: randomNumber, checkAnswer: false, isPick: false,pheptinh: context.read<PhepTinh>().phepTinh);
        lNumber.add(tmpNumber);
      }
    }
    }
    lNumber.shuffle();
  }
  

  checkAnswer(int index, List<NumberModel> lNumbers){
    if(_checkAnswer) return;
    if(lNumber[index].answer == (context.read<PhepTinh>().phepTinh ? answer : A)){
      if(!lNumber[index].isPick){
      context.read<PhepTinh>().listAnswer.add(lNumber[index]);
      }
      if(questionLength < 9){
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
      }else{
        lNumber[index].isPick = true;
        setState(() {
          lNumber[index].checkAnswer = true;
        });
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Result(manchoi: true,),));
        showDialog(
          context: context, 
          builder: (context) {
            return ResultDialog();
          },);
      }
      if(A >= 0 && A <= 11 && B >= 0 && B <= 11){
        context.read<PhepTinh>().phepTinh ? lNumbers[24*A+B*2].numberStar = lNumbers[24*A+B*2].numberStar + 1 : lNumbers[24*A+B*2+1].numberStar = lNumbers[24*A+B*2+1].numberStar + 1;
        print("index: ${context.read<PhepTinh>().phepTinh ? 24*A+B*2 : 24*A+B*2 + 1}");
        print("star: ${context.read<PhepTinh>().phepTinh ? context.read<PhepTinh>().lNumber[24*A+B*2].numberStar : context.read<PhepTinh>().lNumber[24*A+B*2+1].numberStar}");
        context.read<PhepTinh>().putdata();
      }
    }else{
      print("B");
      if(!lNumber[index].isPick){
        context.read<PhepTinh>().listAnswer.add(lNumber[index]);
      }
      setState(() {
        lNumber[index].isPick = true;
      });
    }
    print("list Answer: ${context.read<PhepTinh>().listAnswer.length}");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    born();
    addAsnwer();
    context.read<PhepTinh>().listAnswer = [];
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
            title: Text("Bài học",
              style: TextStyle(
                color: Colors.black
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
                child: Text("${questionLength+1}/10",style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.w700),))
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
              FlipWidget(A: answerNumber.A,B: answerNumber.B,answer: answerNumber.answer ,flip: _checkAnswer),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 350,
                width: 380,
                child: GridView.builder(
                  itemCount: lNumber.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,mainAxisExtent: 150,mainAxisSpacing: 10,crossAxisSpacing: 20
                    ),
                  itemBuilder: (context, index) {
                    return Selector<PhepTinh, List<NumberModel>>(
                      selector: (ctx,state) => state.lNumber,
                      builder: (context, value, child) {
                      return  GestureDetector(
                        onTap: (){
                          checkAnswer(index,value);
                          print("listCheck: ${lNumber[index].checkAnswer}");
                          print("isPick: ${lNumber[index].isPick}");
                        },
                        child: Container(
                            decoration: BoxDecoration(
                              color: !lNumber[index].isPick ? Colors.white : lNumber[index].checkAnswer ? True : Wrong,
                              border: Border.all(
                                color: stroke,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                            ),
                            child: Center(
                              child: Text("${lNumber[index].answer}",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: !lNumber[index].isPick ? Colors.black : Colors.white
                                                  ),
                                          )
                                  ),
                          ),
                      );
                      }, 
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