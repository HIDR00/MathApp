import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:math/model/moreApp.dart';
import 'package:math/model/number_model.dart';

import '../configs/style_configs.dart';

class PhepTinh extends ChangeNotifier{
  bool _pheptinh = true;
  List<NumberModel> _lNumber = [];
  List<NumberModel> _lNumberTienTrinh = [];
  List<NumberModel> listAnswer = [];
  late AnimationController _controller;
  Box boxNumber = Hive.box(boxNumbers);
  late double _tienTrinh1 = 0;
  late double _tienTrinh2 = 0;
  String _answerDisplay = '';
  int _indexLanguage = 0;
  List<moreApp> listApp = [];
  // setting
  int _kkq1 = 0;
  int _kkq2 = 90000;
  bool _kkq3 = false;
  int _ks1 = 0;
  int _ks2 = 10;
  bool _typeAnswerKT = true;
  bool _typeAnswerLT = true;
  int _ctl2 = 100;
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
  }
  void updateClt2(int newValue) {
    _ctl2 = newValue;
    notifyListeners(); 
  }
  void updatehtk(bool newValue) {
    _htk = newValue;
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
  int get indexLanguage => _indexLanguage;
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
  void updateIndexLanguage(int value){
    _indexLanguage =  value;
    notifyListeners();
  }
  getListTienTrinh(){
    _lNumberTienTrinh = [];
    for(int i = ks1;i < ks2;i++){
      for(int j = ks1;j < ks2;j++){
        NumberModel tmpChan = NumberModel(A: i, B: j, answer: i*j, checkAnswer: false, isPick: false,pheptinh: true);
        NumberModel tmpLe = NumberModel(A: i*j, B: j, answer: i, checkAnswer: false, isPick: false,pheptinh: false);
        _lNumberTienTrinh.add(tmpChan);
        _lNumberTienTrinh.add(tmpLe);
      }
    }
  }
  getTienTrinh(){
    getListTienTrinh();
    double sum1 = 0;
    double sum2 = 0;
    int dem = 0;
    print("sum1: ${sum1}");
    print("lNumber: ${lNumber.length}");
    for(var i in _lNumber){
      if(i.numberStar > 5){
        i.numberStar = 5;
      }
      if(i.pheptinh && i.A >= ks1 && i.A <= ks2 && i.B >= ks1 && i.B <= ks2){
        print("A: ${i.A},B: ${i.B}");
        print("numberStar: ${i.numberStar}");
        dem++;
        sum1 = sum1 + i.numberStar;
      }else if(i.pheptinh == false && i.answer >= ks1 && i.answer <= ks2 && i.B >= ks1 && i.B <= ks2){
        sum2 = sum2 + i.numberStar;
      }
    }
    double length = _lNumberTienTrinh.length * 1.0;
    _tienTrinh1 = sum1 / (5 * length);
    _tienTrinh2 = sum2 / (5 * length);
    print("Sum1 :${sum1},length: ${5*length}");
    print("tientrinh: ${_tienTrinh1}");
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
  }
  getData(){
    _lNumber = [];
    print("get datta");
    for(var i in boxNumber.get('data')){
      _lNumber.add(i);
    }
    print("lengtNumber: ${_lNumber.length}");
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
  Future<void> signInWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    // You can access the user with userCredential.user in newer versions of Firebase.
    // In older versions, it may be userCredential.user.
    User? user = userCredential.user;

    // Get the user's ID token
    String? idToken = await user?.getIdToken();
    print("idToken: ${idToken}");

  } catch (e) {
    print('Login error: $e');
  }
}




  fetchDataFireBase() async {
      listApp = [];
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('moreApp').get();
        for (QueryDocumentSnapshot document in querySnapshot.docs) {
          String name = document['Name'];
          String image = document['image'];
          String numberDownload = document['numberDownLoad'];
          String numberStar = document['numberStar'];
          String url = document['url'];
          moreApp tmp = moreApp(Name: name, image: image, numberDowload: numberDownload, numberStar: numberStar,url: url);
          listApp.add(tmp);
          print(name);
        }
        print("length: ${listApp.length}");
        return listApp;
  }
}