import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todox/app/core/utils/extensions.dart';
import 'package:todox/app/core/values/colors.dart';
import 'package:todox/app/modules/home/controller.dart';

class ReportPage extends StatelessWidget {
  final homecontrl = Get.find<HomeController>();
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Obx(() {
        var completedTasks = homecontrl.getTotalDoneTasks();
        var createdTasks = homecontrl.getTotalTask();
        var liveTasks = createdTasks - completedTasks;
        var precentage = (completedTasks / createdTasks * 100).toString();
        return ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(4.0.wp),
              child: Text(
                "Report Center",
                style:
                    TextStyle(fontSize: 24.0.sp, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
              child: Text(
                DateFormat.yMMMd().format(DateTime.now()),
                style: TextStyle(
                  fontSize: 14.0.sp,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 4.0.wp, vertical: 3.0.wp),
              child: const Divider(
                thickness: 2,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatus(Colors.green, liveTasks, 'Live'),
                    _buildStatus(Colors.orange, completedTasks, 'Completed'),
                    _buildStatus(Colors.blue, createdTasks, 'Total'),
                  ]),
            ),
            SizedBox(
              height: 8.0.wp,
            ),
            UnconstrainedBox(
              child: SizedBox(
                width: 70.0.wp,
                height: 70.0.wp,
                child: CircularStepProgressIndicator(
                  totalSteps: createdTasks == 0 ? 1 : createdTasks,
                  currentStep: 20,
                  selectedColor: green,
                  unselectedColor: Colors.grey,
                  padding: 0,
                  width: 150,
                  height: 150,
                  selectedStepSize: 22,
                  roundedCap: (_, __) => true,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${createdTasks == 0 ? 0 : precentage}%',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0.wp,
                        ),
                      ),
                      SizedBox(
                        height: 1.0.wp,
                      ),
                      const Text(
                        'Efficiency',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6.0.wp,
            ),
            const Center(child: Text("By Abdalla Bedeir"))
          ],
        );
      }),
    ));
  }

  Row _buildStatus(Color color, int number, String title) {
    return Row(
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(
          width: 3.0.wp,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp,
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 12.0.sp, color: Colors.grey),
            )
          ],
        ),
      ],
    );
  }
}
