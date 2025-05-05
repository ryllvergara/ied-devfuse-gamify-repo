import 'package:hive/hive.dart';

part 'task_path.g.dart';

@HiveType(typeId: 0)
class TaskItemData extends HiveObject {
  @HiveField(0)
  String task;

  @HiveField(1)
  int xp;

  @HiveField(2)
  bool done;

  @HiveField(3)
  String? notes;

  @HiveField(4)
  String? scheduled;

  @HiveField(5)
  String? repeat;

  @HiveField(6)
  String? every;

  @HiveField(7)
  List<String>? days;

  TaskItemData(
    this.task,
    this.xp, {
    this.done = false,
    this.notes,
    this.scheduled,
    this.repeat,
    this.every,
    this.days,
  });
}
