import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:math/model/number_model.dart';

import '../configs/style_configs.dart';

class PhepTinh extends ChangeNotifier{
  bool _pheptinh = true;
  List<NumberModel> _lNumber = [];
  List<NumberModel> listAnswer = [];
  late AnimationController _controller;
  Box boxNumber = Hive.box(boxNumbers);
  late double _tienTrinh;
  bool _typeAnswer = false;
  String _answerDisplay = '';
  // setting
  int _kkq1 = 0;
  int _kkq2 = 90000;
  bool _kkq3 = false;
  int _ks1 = 0;
  int _ks2 = 90000;


  int get kkq1 => _kkq1;
  int get kkq2 => _kkq2;
  bool get kkq3 => _kkq3;
  int get ks1 => _ks1;
  int get ks2 => _ks2;
  String get answerDisplay => _answerDisplay;


  void updateKkq1(int newValue) {
    _kkq1 = newValue;
    notifyListeners(); 
  }
  void updateKkq2(int newValue) {
    _kkq2 = newValue;
    notifyListeners(); 
  }
  void updateKkq3(bool newValue) {
    _kkq3 = newValue;
    notifyListeners(); 
  }
  void updateKs1(int newValue) {
    _ks1 = newValue;
    notifyListeners(); 
  }
  void updateKs2(int newValue) {
    _ks2 = newValue;
    notifyListeners(); 
  }
  void getAnswerDisplay(String value){
    _answerDisplay = value;
    notifyListeners();
  }
  
  double get tienTrinh => _tienTrinh;
  AnimationController get controller => _controller;
  bool get phepTinh => _pheptinh;
  List<NumberModel> get lNumber => List.from(_lNumber);
  bool get typeAnswer  => _typeAnswer;

  void startAnimation(value){
    if (controller.status == value) {
      controller.reverse();
    } else {
      controller.forward();
    }
  }
  set Controller(AnimationController value) {
    _controller = value;
  }

  set phepTinh(bool value){
    _pheptinh =  value;
    print(_pheptinh);
    notifyListeners();
  }
  set typeAnswer(bool value){
    _typeAnswer =  value;
    notifyListeners();
  }
  getTienTrinh(){
    double sum = 0;
    for(var i in _lNumber){
      sum = sum + i.numberStar;
    }
    _tienTrinh = sum / (5 * 288);
    print("Sum: ${sum}, pheptinh: ${5*288}");
    print("tientrinh: ${(_tienTrinh*100).toInt()*100}");
  }
  fetch(){
    // boxNumber.clear();
    for(int i = 0;i < 12;i++){
      for(int j = 0;j < 12;j++){
        NumberModel tmpChan = NumberModel(A: i, B: j, answer: i*j, checkAnswer: false, isPick: false,pheptinh: true);
        NumberModel tmpLe = NumberModel(A: i*j, B: j, answer: i, checkAnswer: false, isPick: false,pheptinh: false);
        _lNumber.add(tmpChan);
        _lNumber.add(tmpLe);
      }
    }
    boxNumber.put("data", _lNumber);
    print("lengthBox: ${boxNumber.get('data').length}");
    notifyListeners();
  }
  getData(){
    print("get datta");
    for(var i in boxNumber.get('data')){
      _lNumber.add(i);
    }
    print("lengtNumber: ${_lNumber.length}");
    notifyListeners();
  }

  void putdata() {
    boxNumber.put('data', lNumber);
    notifyListeners();
  }
}