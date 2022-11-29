import 'package:get/get.dart';
import 'package:todox/app/data/providers/task/provider.dart';
import 'package:todox/app/data/services/storage/repository.dart';
import 'package:todox/app/modules/home/controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskrepository: Taskrepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
