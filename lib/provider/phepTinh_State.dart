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


  double get tienTrinh => _tienTrinh;
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