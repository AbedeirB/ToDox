import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/modules/home/controller.dart';

class DoingList extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homectrl.doingTodos.isEmpty && homectrl.doneTodos.isEmpty
          ? Column(
              children: [
                Image.asset(
                  'assets/images/tasks.png',
                  fit: BoxFit.cover,
                  width: 60.0.wp,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0.wp),
                  child: Text(
                    "Add task",
                    style: TextStyle(
                        fontSize: 16.0.sp, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homectrl.doingTodos
                    .map(
                      (element) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp, horizontal: 8.2.wp),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Checkbox(
                                fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey,
                                ),
                                value: element['done'],
                                onChanged: (value) {
                                  homectrl.doneTodo(element['title']);
                                },
                              ),
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 4.0.wp),
                                child: Text(element['title'])),
                          ],
                        ),
                      ),
                    )
                    .toList(),
                if (homectrl.doingTodos.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                    child: const Divider(
                      thickness: 2,
                    ),
                  )
              ],
            ),
    );
  }
}
