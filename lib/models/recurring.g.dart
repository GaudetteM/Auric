// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recurring.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecurringAdapter extends TypeAdapter<Recurring> {
  @override
  final int typeId = 2;

  @override
  Recurring read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Recurring(
      id: fields[0] as String,
      title: fields[1] as String,
      amount: fields[2] as double,
      type: fields[3] as TransactionType,
      startDate: fields[4] as DateTime,
      interval: fields[5] as RecurringInterval,
    );
  }

  @override
  void write(BinaryWriter writer, Recurring obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.startDate)
      ..writeByte(5)
      ..write(obj.interval);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecurringIntervalAdapter extends TypeAdapter<RecurringInterval> {
  @override
  final int typeId = 1;

  @override
  RecurringInterval read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return RecurringInterval.daily;
      case 1:
        return RecurringInterval.weekly;
      case 2:
        return RecurringInterval.monthly;
      case 3:
        return RecurringInterval.yearly;
      default:
        return RecurringInterval.daily;
    }
  }

  @override
  void write(BinaryWriter writer, RecurringInterval obj) {
    switch (obj) {
      case RecurringInterval.daily:
        writer.writeByte(0);
        break;
      case RecurringInterval.weekly:
        writer.writeByte(1);
        break;
      case RecurringInterval.biweekly:
        writer.writeByte(2);
        break;
      case RecurringInterval.monthly:
        writer.writeByte(3);
        break;
      case RecurringInterval.yearly:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecurringIntervalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
