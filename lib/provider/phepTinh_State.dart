import 'package:flutter/material.dart';

class PhepTinh extends ChangeNotifier{
  bool _pheptinh = true;
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