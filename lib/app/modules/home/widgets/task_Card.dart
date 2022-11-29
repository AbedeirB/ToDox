import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/data/modules/task.dart';
import 'package:todox/app/modules/details/view.dart';
import 'package:todox/app/modules/home/controller.dart';

class TaskCard extends StatelessWidget {
  final homectrl = Get.find<HomeController>();
  final Task task;
  TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);
    final squarWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homectrl.changeTask(task);
        homectrl.changeTodos(task.todos ?? []);
        Get.to(() => DetailPage());
      },
      child: Container(
        width: squarWidth / 2,
        height: squarWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps: homectrl.isTodoEmpty(task) ? 1 : task.todos!.length,
              currentStep:
                  homectrl.isTodoEmpty(task) ? 0 : homectrl.getDoneTodos(task),
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  colors: [color.withOpacity(0.5), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                IconData(task.icon, fontFamily: 'MaterialIcons'),
                color: color,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                children: [
                  Text(task.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12.0.sp)),
                  SizedBox(height: 1.5.wp),
                  Text('${task.todos?.length ?? 0} task',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8.0.sp,
                          color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
