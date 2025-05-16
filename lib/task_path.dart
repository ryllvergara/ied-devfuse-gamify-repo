import 'package:hive/hive.dart';

// Part directive para sa generated adapter code nga ginahimo sang Hive
part 'task_path.g.dart';

// HiveType annotation para i-register ang class sa Hive database
@HiveType(typeId: 0)
class TaskItemData extends HiveObject {
  // HiveField annotations naga-assign sang unique field indexes para sa serialization

  @HiveField(0)
  String task; // Ngalan sang task (task name)

  @HiveField(1)
  int xp; // XP points nga maangkon kung matapos ang task

  @HiveField(2)
  bool done; // Boolean kung tapos na ang task (true if done)

  @HiveField(3)
  String? notes; // Optional notes or description para sa task

  @HiveField(4)
  String? scheduled; // Optional scheduled date or time para sa task

  @HiveField(5)
  String? repeat; // Optional repeat pattern (e.g., daily, weekly)

  @HiveField(6)
  String? every; // Optional interval para sa pag-repeat (e.g., every 2 days)

  @HiveField(7)
  List<String>? days; // Optional list sang days kung specific days lang (e.g., ["Mon", "Wed"])

  // Constructor sang TaskItemData
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
