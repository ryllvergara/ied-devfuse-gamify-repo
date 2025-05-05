// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_path.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskItemDataAdapter extends TypeAdapter<TaskItemData> {
  @override
  final int typeId = 0;

  @override
  TaskItemData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItemData(
      fields[0] as String,
      fields[1] as int,
      done: fields[2] as bool,
      notes: fields[3] as String?,
      scheduled: fields[4] as String?,
      repeat: fields[5] as String?,
      every: fields[6] as String?,
      days: (fields[7] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskItemData obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.task)
      ..writeByte(1)
      ..write(obj.xp)
      ..writeByte(2)
      ..write(obj.done)
      ..writeByte(3)
      ..write(obj.notes)
      ..writeByte(4)
      ..write(obj.scheduled)
      ..writeByte(5)
      ..write(obj.repeat)
      ..writeByte(6)
      ..write(obj.every)
      ..writeByte(7)
      ..write(obj.days);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
