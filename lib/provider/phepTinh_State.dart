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
  late double _tienTrinh1 = 0;
  late double _tienTrinh2 = 0;
  String _answerDisplay = '';
  

  // setting
  int _kkq1 = 0;
  int _kkq2 = 90000;
  bool _kkq3 = false;
  int _ks1 = 0;
  int _ks2 = 90000;
  bool _typeAnswerKT = true;
  bool _typeAnswerLT = true;
  int _ctl2 = 0;
  bool _htk = false;
  int _tgtl = 10;

  int get kkq1 => _kkq1;
  int get kkq2 => _kkq2;
  bool get kkq3 => _kkq3;
  int get ks1 => _ks1;
  int get ks2 => _ks2;
  String get answerDisplay => _answerDisplay;
  bool get typeAnswerKT  => _typeAnswerKT;
  bool get typeAnswerLT  => _typeAnswerLT;
  int get ctl2 => _ctl2;
  bool get htk => _htk;
  int get tgtl => _tgtl;

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
  void getTypeAnswerKT(bool value){
    _typeAnswerKT =  value;
    notifyListeners();
  }
  getTypeAnswerLT(){
    int tientrinh = 0;
    if(_pheptinh){
      tientrinh = (_tienTrinh1*100).toInt();
    }else{
      tientrinh = (_tienTrinh2*100).toInt();
    }
    if(tientrinh > _ctl2){
      _typeAnswerLT = false;
    }else{
       _typeAnswerLT = true;
    }
    notifyListeners();
  }
  void updateClt2(int newValue) {
    _ctl2 = newValue;
    notifyListeners(); 
  }
  void updatehtk(bool newValue) {
    _htk = newValue;
    notifyListeners(); 
  }
  void updateTgtl(int newValue) {
    _tgtl = newValue;
    notifyListeners(); 
  }
  
  double get tienTrinh1 => _tienTrinh1;
  double get tienTrinh2 => _tienTrinh2;
  AnimationController get controller => _controller;
  bool get phepTinh => _pheptinh;
  List<NumberModel> get lNumber => List.from(_lNumber);

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
  getTienTrinh(){
    double sum1 = 0;
    double sum2 = 0;
    int dem = 0;
    print("sum1: ${sum1}");
    print("lNumber: ${lNumber.length}");
    for(var i in _lNumber){
      if(i.numberStar > 5){
        i.numberStar = 5;
      }
      if(i.pheptinh){
        dem++;
        sum1 = sum1 + i.numberStar;
      }else{
        sum2 = sum2 + i.numberStar;
      }
    }
    _tienTrinh1 = sum1 / (5 * 144);
    _tienTrinh2 = sum2 / (5 * 144);
    print("dem: ${dem}");
    print("Sum: ${sum1}, pheptinh: ${5*288}");
    print("tientrinh: ${(_tienTrinh1*100).toInt()}");
    notifyListeners();
  }
  fetch(){
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
    _lNumber = [];
    print("get datta");
    for(var i in boxNumber.get('data')){
      _lNumber.add(i);
    }
    print("lengtNumber: ${_lNumber.length}");
    notifyListeners();
  }
  xoaTIenTrinh(){
    _lNumber = [];
    for(int i = 0;i < 12;i++){
      for(int j = 0;j < 12;j++){
        NumberModel tmpChan = NumberModel(A: i, B: j, answer: i*j, checkAnswer: false, isPick: false,pheptinh: true);
        NumberModel tmpLe = NumberModel(A: i*j, B: j, answer: i, checkAnswer: false, isPick: false,pheptinh: false);
        _lNumber.add(tmpChan);
        _lNumber.add(tmpLe);
      }
    }
    boxNumber.put("data", _lNumber);
    getTienTrinh();
    notifyListeners();
  }
  void putdata() {
    boxNumber.put('data', lNumber);
    notifyListeners();
  }
}