// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'number_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NumberModelAdapter extends TypeAdapter<NumberModel> {
  @override
  final int typeId = 0;

  @override
  NumberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NumberModel(
      A: fields[0] as int,
      B: fields[1] as int,
      answer: fields[2] as int,
      checkAnswer: fields[3] as bool,
      isPick: fields[4] as bool,
      pheptinh: fields[5] as bool,
    )..numberStar = fields[6] as int;
  }

  @override
  void write(BinaryWriter writer, NumberModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.A)
      ..writeByte(1)
      ..write(obj.B)
      ..writeByte(2)
      ..write(obj.answer)
      ..writeByte(3)
      ..write(obj.checkAnswer)
      ..writeByte(4)
      ..write(obj.isPick)
      ..writeByte(5)
      ..write(obj.pheptinh)
      ..writeByte(6)
      ..write(obj.numberStar);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NumberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
