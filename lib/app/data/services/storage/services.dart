import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todox/app/core/utils/keys.dart';

class StorageServices extends GetxService {
  late GetStorage _box;
  Future<StorageServices> init() async {
    _box = GetStorage();
    await _box.writeIfNull(taskKey, []);
    return this;
  }

  read<T>(String key) {
    return _box.read(key); // return the same type you save in the storage
  }

  void write(String key, dynamic value) async {
    await _box.write(key,
        value); //save what you want to save in the storage and no return cause it's void
  }
}
