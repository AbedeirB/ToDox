import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/core/values/colors.dart';
import 'package:todox/app/modules/home/controller.dart';

class DoneList extends StatelessWidget {
  final homecontrl = Get.find<HomeController>();
  DoneList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homecontrl.doneTodos.isNotEmpty
          ? ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 8.0.wp, vertical: 3.0.wp),
                  child: Text(
                    'Completed(${homecontrl.doneTodos.length})',
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                ...homecontrl.doneTodos.map(
                  (element) => Dismissible(
                    key: ObjectKey(element),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red.withOpacity(0.8),
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: EdgeInsets.only(right: 5.0.wp),
                          child: const Icon(Icons.delete, color: Colors.white)),
                    ),
                    onDismissed: (_) => homecontrl.deleteDoneTodo(element),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 3.0.wp, horizontal: 8.2.wp),
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 20,
                            child: Icon(Icons.done, color: blue),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                            child: GestureDetector(
                              onLongPress: () {
                                homecontrl.unDoneTodo(element['title']);
                                EasyLoading.showSuccess("Task retrived");
                              },
                              child: Text(
                                element['title'],
                                style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ),
                          ),
                        ].toList(),
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
