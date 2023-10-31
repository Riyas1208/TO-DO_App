

import 'package:hive/hive.dart';

part 'data_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  late String title;

  @HiveField(1)
  late String description;

  @HiveField(2)
  late bool isCompleted;

  Task(this.title, this.description, this.isCompleted);
}
