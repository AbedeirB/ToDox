import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/core/values/colors.dart';
import 'package:todox/app/data/modules/task.dart';
import 'package:todox/app/modules/home/controller.dart';
import 'package:todox/app/wedgets/icons.dart';

class AddCard extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squarewidth = Get.width - 12.0.wp;
    return Container(
      width: squarewidth / 2,
      height: squarewidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            title: 'Task Type',
            radius: 5,
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            content: Form(
                key: homectrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                      child: TextFormField(
                        controller: homectrl.editController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter the title',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter the task title';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons
                            .map((e) => Obx(() {
                                  final index = icons.indexOf(e);
                                  return ChoiceChip(
                                    label: e,
                                    selected: homectrl.chipIndex.value == index,
                                    onSelected: (bool selected) {
                                      homectrl.chipIndex.value =
                                          selected ? index : 0;
                                    },
                                  );
                                }))
                            .toList(),
                      ),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          minimumSize: const Size(150, 40),
                        ),
                        onPressed: () {
                          if (homectrl.formKey.currentState!.validate()) {
                            int icon =
                                icons[homectrl.chipIndex.value].icon!.codePoint;
                            String color =
                                icons[homectrl.chipIndex.value].color!.toHex();
                            var task = Task(
                                title: homectrl.editController.text,
                                icon: icon,
                                color: color);
                            Get.back();
                            homectrl.addTask(task)
                                ? EasyLoading.showSuccess('Done')
                                : EasyLoading.showError(
                                    'Duplicated or unsupported');
                          }
                        },
                        child: const Text('Confirm'))
                  ],
                )),
          );
          homectrl.editController.clear();
          homectrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
