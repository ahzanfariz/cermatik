import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/model/category.dart';

import '../../theme/colors_theme.dart';
import '../../widgets/quiz_item_container.dart';

class QuizzesPage extends StatefulWidget {
  final Category category;

  QuizzesPage(this.category);

  @override
  State<QuizzesPage> createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  @override
  Widget build(BuildContext context) {
    // QuizzesController quizzesController = Get.find<QuizzesController>();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeColor.white,
              )),
          title: Text(
            "${widget.category.name}",
            // quizzesController.quizCategoryName.isEmpty
            //     ? "Quizzes"
            //     : "${quizzesController.quizCategoryName} Quizzes",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.white),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: ThemeColor.primary,
        body:
            // Obx(() => quizzesController.isLoading.value
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //         color: ThemeColor.white,
            //       ))
            //     :
            Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 12, right: 12, top: 12),
            decoration: BoxDecoration(
                color: ThemeColor.lighterPrimary,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 8);
                },
                scrollDirection: Axis.vertical,
                itemCount: widget.category.question!.length,
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        // Get.toNamed(AppRoutes.quizDetailPage, arguments: {
                        //   ARG_QUIZ_DETAIL:
                        //       quizzesController.allQuizzes[index],
                        //   ARG_QUIZ_CATEGORY_NAME:
                        //       quizzesController.quizCategoryName
                        // });
                      },
                      child: QuizItemContainer(
                        dataObj: widget.category,
                        // {},
                        // quizzesController.allQuizzes[index],
                      ));
                }),
          ),
        ));
  }
}
