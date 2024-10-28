import 'dart:async';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/model/category.dart';
import 'package:quizzie_thunder/modules/quiz_result/quiz_result_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class QuizQuestionArrangePage extends StatefulWidget {
  final Category category;

  QuizQuestionArrangePage(this.category);

  @override
  State<QuizQuestionArrangePage> createState() =>
      _QuizQuestionArrangePageState();
}

class _QuizQuestionArrangePageState extends State<QuizQuestionArrangePage> {
  final arguments = Get.arguments;

  var _topicSelected = "No Answer";
  var _feedbackController = TextEditingController();
  var _isInvalid = false, optionSelectSubmitted = false;
  List<String>? _dropdownAnswers = [];

  var isLoading = false;
  var questionCount = 0;
  var optionSelectedIndex = (-1);
  var isAnswerCorrect = (-1);

  var quizId = "";
  var quizName = "";
  var quizCategoryName = "";
  var skipQuestionCount = 0;
  var correctAnswerCount = 0;
  var incorrectAnswerCount = 0;

  Timer? _timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.removeAllCallbacks();
  }

  void nextQuestion({bool isSkipped = false, MainModel? model}) async {
    if (isSkipped) {
      setState(() {
        optionSelectSubmitted = false;
        skipQuestionCount++;
      });
    } else {
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        optionSelectSubmitted = true;
      });

      for (final answer in widget.category.question![questionCount].options!
          .where((q) => q != "")
          .toList()) {
        setState(() {
          _dropdownAnswers!.remove(answer);
        });
      }
      await Future.delayed(Duration(seconds: 1));

      setState(() {
        var correctAnswer = widget.category.question![questionCount].options!
                .where((q) => q != "")
                .toList()
                .length -
            _dropdownAnswers!.length;
        correctAnswerCount += correctAnswer;
        incorrectAnswerCount += _dropdownAnswers!.length;
      });
      print("correct answer result : $correctAnswerCount");
      print("incorrect answer result : $incorrectAnswerCount");
    }
    if (questionCount + 1 == widget.category.question?.length) {
      endQuiz(model!);
    } else {
      setState(() {
        // isAnswerCorrect = -1;
        // optionSelectedIndex = -1;
        questionCount += 1;
      });
    }
  }

  Future endQuiz(MainModel model) async {
    var completionPercentage =
        (skipQuestionCount + correctAnswerCount + incorrectAnswerCount) * 10;

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    //
    var response = await model.submitScore({
      "users_id": model.user.id,
      "category_id": widget.category.id,
      "questions_id": widget.category.question![0].id,
      "score": correctAnswerCount * 10,
    });

    print(response['data']);

    if (response['data'] != null) {
      //
      _timer?.cancel();
      await EasyLoading.dismiss();
      //
      Get.off(QuizResultPage(
          widget.category,
          skipQuestionCount,
          correctAnswerCount,
          incorrectAnswerCount,
          completionPercentage,
          model));
    }

    //
    // , arguments: {
    //   ARG_QUIZ_NAME: quizName,
    //   ARG_QUIZ_CATEGORY_NAME: quizCategoryName,
    //   ARG_SKIPPED_QUESTIONS_COUNT: skipQuestionCount,
    //   ARG_CORRECT_ANSWER_COUNT: correctAnswerCount,
    //   ARG_INCORRECT_ANSWER_COUNT: incorrectAnswerCount
    // });
  }

  Future complimentQuestion(MainModel model) async {
    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);
    //
    var response = await model.complainQuestion({
      "users_id": model.user.id,
      "topic": _topicSelected,
      "questions_id": widget.category.question![0].id,
      "comment": _feedbackController.text,
    });

    print(response['data']);

    if (response['data'] != null) {
      //
      _timer?.cancel();
      await EasyLoading.dismiss();
      //
      AppUtils.showSnackBar("Compliment submitted",
          title: "Success", status: MessageStatus.SUCCESS);
    }

    //
    // , arguments: {
    //   ARG_QUIZ_NAME: quizName,
    //   ARG_QUIZ_CATEGORY_NAME: quizCategoryName,
    //   ARG_SKIPPED_QUESTIONS_COUNT: skipQuestionCount,
    //   ARG_CORRECT_ANSWER_COUNT: correctAnswerCount,
    //   ARG_INCORRECT_ANSWER_COUNT: incorrectAnswerCount
    // });
  }

  final List<String> _issueList = [
    'Questions Bug',
    'No Answer',
    'Basic Question',
    'etc.'
  ];

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return PopScope(
          onPopInvoked: (canPop) async {
            await showEndQuizAlertDialog(model);
            return;
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () async {
                      await showEndQuizAlertDialog(model);
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      color: ThemeColor.white,
                    )),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "${widget.category.question?[0].subject}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: ThemeColor.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "${widget.category.name}",
                      style: TextStyle(fontSize: 12, color: ThemeColor.white),
                    ),
                  ],
                ),
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
              ),
              backgroundColor: ThemeColor.primary,
              body: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: ThemeColor.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: ListView(
                    padding: const EdgeInsets.all(16),

                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 32,
                      ),
                      Text(
                        "QUESTION ${questionCount + 1} OF ${widget.category.question?.length}",
                        style: TextStyle(
                            color: ThemeColor.grey_500,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "${widget.category.question?[questionCount].subject}",
                        style: TextStyle(
                            color: ThemeColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "${widget.category.question?[questionCount].questionText}",
                        style: TextStyle(
                            color: ThemeColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      optionContainerList(model),
                      // Spacer(),
                      Container(
                          margin: EdgeInsets.only(top: 10),
                          child: TextButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  elevation: 0,
                                  enableDrag: true,
                                  isDismissible: true,
                                  isScrollControlled: true,
                                  showDragHandle: true,
                                  useSafeArea: true,
                                  // backgroundColor: color4,
                                  // barrierColor: darkBarrierColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(24),
                                      topRight: Radius.circular(24),
                                    ),
                                  ),
                                  context: context,
                                  builder: (context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context, setterState) {
                                      return Container(
                                          // height: MediaQuery.of(context)
                                          //     .size
                                          //     .height,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(20))),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: <Widget>[
                                              Container(
                                                  // alignment: Alignment.centerRight,
                                                  child: Stack(
                                                children: [
                                                  Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Container(
                                                          child: Text(
                                                              "Feedback this Question",
                                                              style: const TextStyle(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)))),
                                                ],
                                              )),
                                              SizedBox(height: 10),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15,
                                                      vertical: 10),
                                                  child: CustomDropdown<String>(
                                                    hintText: 'Select Topic',
                                                    items: _issueList,
                                                    initialItem: _topicSelected,
                                                    onChanged: (value) {
                                                      print(
                                                          'changing value to: $value');

                                                      setState(() {
                                                        _topicSelected = value!;
                                                      });
                                                    },
                                                  )),
                                              SizedBox(height: 5),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: TextFormField(
                                                    scrollPadding:
                                                        EdgeInsets.only(
                                                            bottom: 40),
                                                    maxLines: 8,
                                                    controller:
                                                        _feedbackController,
                                                    onChanged: (v) {
                                                      setterState(() {
                                                        _feedbackController
                                                            .text = v;
                                                      });
                                                    },
                                                    decoration: InputDecoration(
                                                        hintText:
                                                            "Write your feedback...",
                                                        hintStyle: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 16),
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            const Radius
                                                                .circular(14.0),
                                                          ),
                                                          borderSide:
                                                              BorderSide(
                                                            width: 0,
                                                            style: BorderStyle
                                                                .none,
                                                          ),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            ThemeColor.white),
                                                  )),
                                              _isInvalid
                                                  ? Container(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8,
                                                              horizontal: 20),
                                                      child: Text(
                                                        "Feedback can't be empty",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            color:
                                                                ThemeColor.red),
                                                      ))
                                                  : SizedBox(),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: 20,
                                                      horizontal: 10),
                                                  width: double.infinity,
                                                  height: 36,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      if (_feedbackController
                                                          .text.isEmpty) {
                                                        setterState(() {
                                                          _isInvalid = true;
                                                        });
                                                      } else {
                                                        setterState(() {
                                                          _isInvalid = false;
                                                          FocusManager.instance
                                                              .primaryFocus
                                                              ?.unfocus();
                                                        });
                                                        Navigator.of(context)
                                                            .pop();

                                                        await complimentQuestion(
                                                            model);
                                                        _feedbackController
                                                            .clear();
                                                      }
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.send,
                                                          color: Colors.white,
                                                        ),
                                                        SizedBox(width: 8),
                                                        Text("Submit Feedback",
                                                            style: TextStyle(
                                                                color: ThemeColor
                                                                    .white)),
                                                      ],
                                                    ),
                                                    style: TextButton.styleFrom(
                                                      textStyle: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12)),
                                                      backgroundColor:
                                                          ThemeColor
                                                              .primaryDark,
                                                    ),
                                                  )),
                                            ],
                                          ));
                                    });
                                    // return CustomAddMenuScreen();
                                  },
                                );
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.report,
                                      color: ThemeColor.green,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "Compliment this Question",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: ThemeColor.green),
                                    )
                                  ],
                                ),
                              ))),
                      SizedBox(height: 20),
                      // Spacer(),
                      Row(
                        children: [
                          Expanded(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      nextQuestion(
                                          isSkipped: true, model: model);
                                    },
                                    child: Text("Skip",
                                        style:
                                            TextStyle(color: ThemeColor.white)),
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: ThemeColor.primaryDark,
                                    ),
                                  ))),
                          SizedBox(width: 10),
                          Expanded(
                              child: SizedBox(
                                  width: double.infinity,
                                  height: 44,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      nextQuestion(
                                          isSkipped: false, model: model);
                                    },
                                    child: Text("Next Question",
                                        style:
                                            TextStyle(color: ThemeColor.white)),
                                    style: TextButton.styleFrom(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      backgroundColor: ThemeColor.primary,
                                    ),
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              )));
    });
  }

  Column optionContainerList(MainModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.category.question![questionCount].options!
          .where((q) => q != "")
          .toList()
          .asMap()
          .entries
          .map((entry) => optionContainer(entry.key, entry.value, model))
          .toList(),
    );
  }

  Column optionContainer(int index, String optionName, MainModel model) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                  "${widget.category.question![questionCount].questionNumber}.${index + 1}",
                  style: TextStyle(fontSize: 18, color: ThemeColor.black)),
              SizedBox(width: 30),
              Expanded(
                child: Container(
                    width: double.infinity,
                    // padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        color:
                            // (optionSelectedIndex == index &&
                            //         isAnswerCorrect == -1)
                            //     ? ThemeColor.lightPrimary.withOpacity(0.4)
                            //     : (optionSelectedIndex == index &&
                            //             isAnswerCorrect == 1)
                            //         ?
                            !_dropdownAnswers!
                                        .map((e) =>
                                            e.replaceAll(RegExp(r'[A-Z]'), ''))
                                        .toList()
                                        .contains(
                                            "${widget.category.question![questionCount].questionNumber}.${index + 1} ") &&
                                    optionSelectSubmitted
                                ? ThemeColor.vibrantGreen
                                :
                                // : (optionSelectedIndex == index &&
                                //         isAnswerCorrect == 0)
                                //     ? ThemeColor.white
                                //     :
                                ThemeColor.white,
                        border: Border.all(
                            color: _dropdownAnswers!
                                        .map((e) =>
                                            e.replaceAll(RegExp(r'[A-Z]'), ''))
                                        .toList()
                                        .contains(
                                            "${widget.category.question![questionCount].questionNumber}.${index + 1} ") &&
                                    optionSelectSubmitted

                                // (optionSelectedIndex == index &&
                                //         isAnswerCorrect == 0)
                                ? ThemeColor.coralRed
                                : !_dropdownAnswers!
                                            .map((e) => e.replaceAll(
                                                RegExp(r'[A-Z]'), ''))
                                            .toList()
                                            .contains(
                                                "${widget.category.question![questionCount].questionNumber}.${index + 1} ") &&
                                        optionSelectSubmitted
                                    // optionSelectedIndex == index
                                    ? Colors.transparent
                                    : ThemeColor.lightPrimary.withOpacity(0.4),
                            width: 2),
                        borderRadius: BorderRadius.circular(20)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CustomDropdown<String>(
                        hintText: 'Select Answer',
                        items: [
                          'A',
                          'B',
                          'C',
                          'D',
                          'E',
                          'F',
                          'G',
                          'H',
                          'I',
                          'J'
                        ],
                        // initialItem: '',
                        onChanged: (value) {
                          // print('changing value to: $value');

                          setState(() {
                            _dropdownAnswers!.add(
                                "${widget.category.question![questionCount].questionNumber}.${index + 1} $value");
                          });
                          print(_dropdownAnswers);
                        },
                      ),
                    )
                    // Text(
                    //   "$optionName",
                    //   style: TextStyle(
                    //       color: (optionSelectedIndex == index && isAnswerCorrect == 1)
                    //           ? ThemeColor.white
                    //           : (optionSelectedIndex == index && isAnswerCorrect == 0)
                    //               ? ThemeColor.coralRed
                    //               : ThemeColor.black,
                    //       fontSize: 14,
                    //       fontWeight: optionSelectedIndex == index
                    //           ? FontWeight.bold
                    //           : FontWeight.normal),
                    // ),
                    ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }

  Future<bool> showEndQuizAlertDialog(MainModel model) {
    Completer<bool> completer = Completer<bool>();
    Get.defaultDialog(
        title: "Quit Exam",
        middleText: "Are you sure you want to quit the exam?",
        backgroundColor: ThemeColor.white,
        titleStyle: TextStyle(fontSize: 18, color: ThemeColor.black),
        middleTextStyle: TextStyle(fontSize: 16, color: ThemeColor.textPrimary),
        titlePadding: const EdgeInsets.all(16),
        contentPadding: const EdgeInsets.all(16),
        radius: 8,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.close,
              size: 16,
              color: ThemeColor.textPrimary,
            ),
            label: Text(
              "No",
              style: TextStyle(
                  color: ThemeColor.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              side: BorderSide(color: ThemeColor.textPrimary, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              Get.back();
              endQuiz(model);
            },
            icon: Icon(
              Icons.check,
              size: 16,
              color: ThemeColor.white,
            ),
            label: Text(
              "Yes",
              style: TextStyle(
                  color: ThemeColor.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ThemeColor.primary,
              side: BorderSide(color: ThemeColor.primary, width: 1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
          ),
        ]);
    return completer.future;
  }
}
