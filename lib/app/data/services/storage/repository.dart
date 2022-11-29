import 'package:todox/app/data/modules/task.dart';
import 'package:todox/app/data/providers/task/provider.dart';

class Taskrepository {
  TaskProvider taskProvider;
  Taskrepository({required this.taskProvider});
  List<Task> readTasks() => taskProvider.readTasks();
  void writeTask(List<Task> tasks) => taskProvider.writeTask(tasks);
}
