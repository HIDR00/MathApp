import 'package:hive/hive.dart';

part 'number_model.g.dart';

@HiveType(typeId: 0)
class NumberModel{
  @HiveField(0)
  late int A;

  @HiveField(1)
  late int B;

  @HiveField(2)
  late int answer;

  @HiveField(3)
  late bool checkAnswer;
  
  @HiveField(4)
  late bool isPick;

  @HiveField(5)
  late bool pheptinh;

  @HiveField(6)
  int numberStar = 0;
  NumberModel({required this.A,required this.B,required this.answer,required this.checkAnswer,required this.isPick,required this.pheptinh});

  NumberModel.fromMap(Map<String, dynamic> data) {
    A = data['A'];
    B = data['B'];
    answer = data['answer'];
    checkAnswer = data['checkAnswer'];
    isPick = data['isPick'];
  }
}