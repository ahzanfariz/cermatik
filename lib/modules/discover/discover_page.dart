import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/modules/quiz_detail/quiz_detail_page.dart';
import 'package:quizzie_thunder/modules/quizzes/quizzes_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';
import '../../utils/app_utils.dart';

class DiscoverPage extends StatelessWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
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
            "All Categories",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.white),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: ThemeColor.primary,
        body:

            // Obx(() => RefreshIndicator(
            //       onRefresh: () async {
            //         discoverController.getDiscoverScreenDetails();
            //       },
            //       child: discoverController.isLoading.value
            //           ? const Center(
            //               child: CircularProgressIndicator(
            //               color: ThemeColor.white,
            //             ))
            //           :
            SingleChildScrollView(
                child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Get.toNamed(AppRoutes.quizDetailPage,
                    //     arguments: {
                    //       ARG_QUIZ_DETAIL: Quiz(
                    //           id: discoverController
                    //               .discoverScreenResponseModel
                    //               ?.topPicQuiz
                    //               ?.id,
                    //           title: discoverController
                    //               .discoverScreenResponseModel
                    //               ?.topPicQuiz
                    //               ?.title,
                    //           description: discoverController
                    //               .discoverScreenResponseModel
                    //               ?.topPicQuiz
                    //               ?.description,
                    //           category: Category(
                    //               id: discoverController
                    //                   .discoverScreenResponseModel
                    //                   ?.topPicQuiz
                    //                   ?.category
                    //                   ?.id,
                    //               title: discoverController
                    //                   .discoverScreenResponseModel
                    //                   ?.topPicQuiz
                    //                   ?.category
                    //                   ?.title,
                    //               createdAt: discoverController
                    //                   .discoverScreenResponseModel
                    //                   ?.topPicQuiz
                    //                   ?.category
                    //                   ?.createdAt,
                    //               updatedAt: discoverController
                    //                   .discoverScreenResponseModel
                    //                   ?.topPicQuiz
                    //                   ?.category
                    //                   ?.updatedAt),
                    //           createdAt: discoverController.discoverScreenResponseModel?.topPicQuiz?.createdAt,
                    //           updatedAt: discoverController.discoverScreenResponseModel?.topPicQuiz?.updatedAt)
                    //     });
                  },
                  child: Stack(children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/cermatik_header.png",
                          width: double.infinity,
                          fit: BoxFit.fill,
                          height: 170,
                        )),
                    // Padding(
                    //     padding: const EdgeInsets.all(16.0),
                    //     child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           SizedBox(
                    //             height: 76,
                    //           ),
                    //           Text("Choose the categories below",
                    //               // "${discoverController.discoverScreenResponseModel?.topPicQuiz?.title}",
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.bold,
                    //                   color: ThemeColor.white)),
                    //           SizedBox(
                    //             height: 8,
                    //           ),
                    //           Text(
                    //               "You've 4 category with dynamic questions with in-depth knowledge",
                    //               // "${discoverController.discoverScreenResponseModel?.topPicQuiz?.category?.title} - 10 Questions",
                    //               style: TextStyle(
                    //                   fontSize: 12, color: ThemeColor.white))
                    //         ])),
                  ]),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Visibility(
                      //   visible: discoverController
                      //           .discoverScreenResponseModel
                      //           ?.weekTopRank !=
                      //       null,
                      //   child: Column(
                      //     mainAxisAlignment:
                      //         MainAxisAlignment.start,
                      //     crossAxisAlignment:
                      //         CrossAxisAlignment.start,
                      //     children: [
                      //       Text(
                      //         "Top rank of the week",
                      //         style: TextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //             color: ThemeColor.black),
                      //       ),
                      //       SizedBox(
                      //         height: 8,
                      //       ),
                      //       Stack(children: [
                      //         Image.asset(
                      //           "assets/images/top_rank_bg.png",
                      //           width: double.infinity,
                      //           fit: BoxFit.cover,
                      //         ),
                      //         Padding(
                      //             padding:
                      //                 const EdgeInsets.all(16.0),
                      //             child: Column(
                      //               children: [
                      //                 SizedBox(
                      //                   height: 24,
                      //                 ),
                      //                 Row(
                      //                   crossAxisAlignment:
                      //                       CrossAxisAlignment
                      //                           .center,
                      //                   children: [
                      //                     Container(
                      //                       padding:
                      //                           const EdgeInsets
                      //                               .all(8),
                      //                       decoration:
                      //                           BoxDecoration(
                      //                               shape: BoxShape
                      //                                   .circle,
                      //                               border:
                      //                                   Border.all(
                      //                                 color:
                      //                                     ThemeColor
                      //                                         .white,
                      //                               )),
                      //                       child: Text(
                      //                         "1",
                      //                         style: TextStyle(
                      //                             fontSize: 12,
                      //                             fontWeight:
                      //                                 FontWeight
                      //                                     .bold,
                      //                             color: ThemeColor
                      //                                 .white),
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 16,
                      //                     ),
                      //                     CircleAvatar(
                      //                       backgroundColor: AppUtils
                      //                           .getRandomAvatarBgColor(),
                      //                       radius: 24,
                      //                       child: ClipOval(
                      //                         child:
                      //                             CachedNetworkImage(
                      //                           imageUrl:
                      //                               "${discoverController.discoverScreenResponseModel?.weekTopRank?.user?.profilePic}",
                      //                           width:
                      //                               double.infinity,
                      //                           height:
                      //                               double.infinity,
                      //                           fit: BoxFit.cover,
                      //                           placeholder:
                      //                               (context,
                      //                                       url) =>
                      //                                   Center(
                      //                             child: Container(
                      //                               width: 20,
                      //                               height: 20,
                      //                               child:
                      //                                   CircularProgressIndicator(
                      //                                 color:
                      //                                     ThemeColor
                      //                                         .accent,
                      //                               ),
                      //                             ),
                      //                           ),
                      //                           errorWidget:
                      //                               (context, url,
                      //                                       error) =>
                      //                                   Icon(
                      //                             Icons.error,
                      //                             color: ThemeColor
                      //                                 .red,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ),
                      //                     SizedBox(
                      //                       width: 12,
                      //                     ),
                      //                     Column(
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment
                      //                               .start,
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment
                      //                               .start,
                      //                       children: [
                      //                         Text(
                      //                           "${discoverController.discoverScreenResponseModel?.weekTopRank?.user?.firstname} ${discoverController.discoverScreenResponseModel?.weekTopRank?.user?.lastname}",
                      //                           style: TextStyle(
                      //                               fontSize: 16,
                      //                               fontWeight:
                      //                                   FontWeight
                      //                                       .bold,
                      //                               color:
                      //                                   ThemeColor
                      //                                       .white),
                      //                         ),
                      //                         SizedBox(
                      //                           height: 4,
                      //                         ),
                      //                         Text(
                      //                           "${discoverController.discoverScreenResponseModel?.weekTopRank?.points} points",
                      //                           style: TextStyle(
                      //                               fontSize: 14,
                      //                               color:
                      //                                   ThemeColor
                      //                                       .white),
                      //                         ),
                      //                       ],
                      //                     )
                      //                   ],
                      //                 ),
                      //               ],
                      //             ))
                      //       ]),
                      //       SizedBox(
                      //         height: 16,
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text(
                        "Categories",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: ThemeColor.black),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GridView.builder(
                        itemCount: model.categories.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var category = model.categories[index];
                          final cardBgColor = AppUtils.getRandomCardBgColor();
                          return Card(
                              // color: cardBgColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 2,
                              child: InkWell(
                                  onTap: () {
                                    Get.to(QuizDetailPage(
                                        model.categories[index]));

                                    // Get.toNamed(AppRoutes.quizzesPage,
                                    //     arguments: {
                                    //       ARG_QUIZ_CATEGORY_ID:
                                    //           discoverController
                                    //               .discoverScreenResponseModel
                                    //               ?.quizCategories?[
                                    //                   index]
                                    //               .id,
                                    //       ARG_QUIZ_CATEGORY_NAME:
                                    //           discoverController
                                    //               .discoverScreenResponseModel
                                    //               ?.quizCategories?[
                                    //                   index]
                                    //               .title
                                    //     });
                                  },
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(category.name!
                                              .toLowerCase()
                                              .contains("math")
                                          ? 'assets/ikony/1.jpg'
                                          : category.name!
                                                  .toLowerCase()
                                                  .contains("bio")
                                              ? 'assets/ikony/2.jpg'
                                              : category.name!
                                                      .toLowerCase()
                                                      .contains("phy")
                                                  ? 'assets/ikony/3.jpg'
                                                  : 'assets/ikony/4.jpg'))
                                  //  Column(
                                  //   mainAxisAlignment: MainAxisAlignment.center,
                                  //   crossAxisAlignment: CrossAxisAlignment.center,
                                  //   children: [
                                  //     Icon(
                                  //       Icons.science_outlined,
                                  //       size: 36,
                                  //       color: ThemeColor.white,
                                  //     ),
                                  //     SizedBox(
                                  //       height: 16,
                                  //     ),
                                  //     Text(
                                  //       "${model.categories[index].name}",
                                  //       textAlign: TextAlign.center,
                                  //       style: TextStyle(
                                  //           fontSize: 16,
                                  //           color: ThemeColor.white,
                                  //           fontWeight: FontWeight.bold),
                                  //     ),
                                  //     SizedBox(
                                  //       height: 4,
                                  //     ),
                                  //     Text(
                                  //       "${model.categories[index].question?.length} Questions",
                                  //       style: TextStyle(
                                  //         fontSize: 12,
                                  //         color: ThemeColor.white,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  ));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                      )
                    ])),
          ),
          SizedBox(
            height: 24,
          ),
        ])),
      );
    });
  }
}
