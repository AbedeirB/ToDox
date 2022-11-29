import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/modules/home/controller.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key});
  final homectrl = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homectrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                          homectrl.editController.clear();
                          homectrl.changeTask(null);
                        },
                        icon: const Icon(Icons.close)),
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          if (homectrl.formKey.currentState!.validate()) {
                            if (homectrl.task.value == null) {
                              EasyLoading.showError('Select the task type!');
                            } else {
                              var sucess = homectrl.updateTask(
                                  homectrl.task.value!,
                                  homectrl.editController.text);
                              if (sucess) {
                                EasyLoading.showSuccess("Done");
                                Get.back();
                                homectrl.changeTask(null);
                              } else {
                                EasyLoading.showError(
                                    "This todo is already listed");
                              }
                              homectrl.editController.clear();
                            }
                          }
                        },
                        child: Text(
                          'Done',
                          style: TextStyle(
                              fontSize: 14.0.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.5.wp),
                child: Text("New task",
                    style: TextStyle(
                      fontSize: 20.0.sp,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homectrl.editController,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter a valid todo item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 5.0.wp, top: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  'Add this todo to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                  ),
                ),
              ),
              ...homectrl.tasks
                  .map(
                    (element) => Obx(
                      () => InkWell(
                        onTap: () => homectrl.changeTask(element),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 2.2.wp, horizontal: 5.0.wp),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    IconData(element.icon,
                                        fontFamily: 'MaterialIcons'),
                                    color: HexColor.fromHex(element.color),
                                  ),
                                  SizedBox(
                                    width: 3.0.wp,
                                  ),
                                  Text(
                                    element.title,
                                    style: TextStyle(
                                        fontSize: 12.0.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              if (homectrl.task.value == element)
                                const Icon(
                                  Icons.check,
                                  color: Colors.black,
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }
}
