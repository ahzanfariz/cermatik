import 'package:flutter/material.dart';
import 'package:quizzie_thunder/model/category.dart';

import '../../theme/colors_theme.dart';
// import '../models/all_quiz_response_model.dart';

class QuizItemContainer extends StatelessWidget {
  final Category? dataObj;

  const QuizItemContainer({Key? key, required this.dataObj}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.grey_300),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${dataObj?.name}",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ThemeColor.black)),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                      // quizCategoryName?.isEmpty == true
                      // ?
                      "Advanced - ${dataObj?.question?.length} Questions",
                      // ? "${dataObj?.category?.title} - 10 Questions"
                      // : "$quizCategoryName - 10 Questions",
                      style: TextStyle(fontSize: 12, color: ThemeColor.grey))
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: ThemeColor.primary,
            size: 16,
          )
        ],
      ),
    );
  }
}
