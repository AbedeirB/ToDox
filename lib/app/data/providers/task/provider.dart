import 'dart:convert';

import 'package:get/get.dart';
import 'package:todox/app/core/utils/keys.dart';
import 'package:todox/app/data/modules/task.dart';
import 'package:todox/app/data/services/storage/services.dart';

class TaskProvider {
  StorageServices _storage = Get.find<StorageServices>();
  List<Task> readTasks() {
    var tasks = <Task>[];
    jsonDecode(_storage.read(taskKey).toString())
        .forEach((e) => tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void writeTask(List<Task> tasks) {
    _storage.write(taskKey, jsonEncode(tasks));
  }
}
