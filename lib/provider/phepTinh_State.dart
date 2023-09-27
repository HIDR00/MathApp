import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:math/model/number_model.dart';

class PhepTinh extends ChangeNotifier{
  bool _pheptinh = true;
  List<NumberModel> listAnswer = [];
  late AnimationController _controller;
  AnimationController get controller => _controller;
  bool get phepTinh => _pheptinh;

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
}