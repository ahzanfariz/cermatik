import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quizzie_thunder/modules/discover/discover_page.dart';
import 'package:quizzie_thunder/modules/quiz_detail/quiz_detail_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../theme/colors_theme.dart';
import '../../utils/app_utils.dart';
import '../../widgets/quiz_item_container.dart';

class HomePage extends StatefulWidget {
  final MainModel model;
  HomePage(this.model);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;
  EasyLoadingStatus? _easyLoadingStatus = EasyLoadingStatus.show;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // if (widget.model.categories.isEmpty)
    loadData();
  }

  Future loadData() async {
    EasyLoading.addStatusCallback((status) {
      print('EasyLoading Status $status');
      setState(() {
        _easyLoadingStatus = status;
      });
    });

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    var data = await widget.model.fetchAllCategories();
    if (data['data'] != null) {
      var dataMyScore = await widget.model.fetchMyAvgScore();
      if (dataMyScore['data'] != null) {
        var dataResponse = await widget.model.fetchUser();
        if (dataResponse.email != null) {
          // Future.delayed(Duration(seconds: 1), () async {
          _timer?.cancel();
          await EasyLoading.dismiss().then((_) {
            setState(() {
              _easyLoadingStatus = EasyLoadingStatus.dismiss;
            });
          });
          // });
        }
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    EasyLoading.removeAllCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
          backgroundColor: ThemeColor.primary,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  // padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                            'assets/images/cermatik.jpeg',
                                            height: 40,
                                          )),
                                      SizedBox(width: 10),
                                      Text(
                                        "${AppUtils.getGreeting()}",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: ThemeColor.white),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 8,
                                  // ),
                                  // Visibility(
                                  //   visible: true,
                                  //   // profileController.fullName.value.isNotNullOrEmpty,
                                  //   child: Text(
                                  //     "Hi, ${model.nama} 👋",
                                  //     // "${profileController.fullName}",
                                  //     style: TextStyle(
                                  //         fontSize: 22,
                                  //         fontWeight: FontWeight.normal,
                                  //         color: ThemeColor.white),
                                  //   ),
                                  // ),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  model.setIndexBottomNav(2);
                                },
                                child: Visibility(
                                  visible: true,
                                  child: Container(
                                      width: 50,
                                      height: 50,
                                      child: CircleAvatar(
                                        backgroundColor: ThemeColor.white,
                                        child: ClipOval(
                                          child: CachedNetworkImage(
                                              imageUrl: model.user.image == null
                                                  ? ""
                                                  : "${Constant.baseUrl}${Constant.publicAssets}${model.user.image}",
                                              width: double.infinity,
                                              height: double.infinity,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child: Container(
                                                      color: ThemeColor.white,
                                                      width: 20,
                                                      height: 20,
                                                      child:
                                                          CircularProgressIndicator(
                                                        color:
                                                            ThemeColor.primary,
                                                      ),
                                                    ),
                                                  ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Container(
                                                      color: ThemeColor.white,
                                                      alignment:
                                                          Alignment.center,
                                                      // margin: EdgeInsets.all(8),
                                                      child: Icon(
                                                        Icons
                                                            .account_circle_sharp,
                                                        color:
                                                            ThemeColor.grey_300,
                                                        size: 50,
                                                      ))),
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.toNamed(AppRoutes.quizDetailPage,
                      //         arguments: {
                      //           ARG_QUIZ_DETAIL: Quiz(
                      //             id: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.id,
                      //             title: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.title,
                      //             description: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.description,
                      //             category: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.category,
                      //             createdAt: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.createdAt,
                      //             updatedAt: homeController
                      //                 .homeScreenResponseModel
                      //                 ?.mostPlayedQuiz
                      //                 ?.updatedAt,
                      //           )
                      //         });
                      //   },
                      //   child: Stack(
                      //     children: [
                      //       ClipRRect(
                      //         borderRadius:
                      //             BorderRadius.circular(16.0),
                      //         child: Image.asset(
                      //           "assets/images/most_played_quiz_bg.png",
                      //           width: double.infinity,
                      //           fit: BoxFit.cover,
                      //           height: 100,
                      //         ),
                      //       ),
                      //       Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Column(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.start,
                      //           crossAxisAlignment:
                      //               CrossAxisAlignment.start,
                      //           children: [
                      //             SizedBox(
                      //               height: 2,
                      //             ),
                      //             Container(
                      //                 child: Row(
                      //               children: [
                      //                 Text("NEWS / PROMO",
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(
                      //                         fontSize: 18,
                      //                         fontWeight:
                      //                             FontWeight.bold,
                      //                         color: ThemeColor
                      //                             .dustyRose)),
                      //                 Container(
                      //                   child: Row(
                      //                     children: [
                      //                       Container(
                      //                         height: 10,
                      //                         width: 10,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius:
                      //                                 BorderRadius
                      //                                     .circular(
                      //                                         100),
                      //                             border: Border.all(
                      //                                 color:
                      //                                     Colors.grey,
                      //                                 width: 2),
                      //                             color: Colors.grey),
                      //                       ),
                      //                       Container(
                      //                         height: 10,
                      //                         width: 10,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius:
                      //                                 BorderRadius
                      //                                     .circular(
                      //                                         100),
                      //                             border: Border.all(
                      //                                 color: Colors
                      //                                     .black,
                      //                                 width: 2),
                      //                             color:
                      //                                 Colors.black),
                      //                       ),
                      //                       Container(
                      //                         height: 10,
                      //                         width: 10,
                      //                         decoration: BoxDecoration(
                      //                             borderRadius:
                      //                                 BorderRadius
                      //                                     .circular(
                      //                                         100),
                      //                             border: Border.all(
                      //                                 color:
                      //                                     Colors.grey,
                      //                                 width: 2),
                      //                             color: Colors.grey),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 )
                      //               ],
                      //             )),
                      //             SizedBox(
                      //               height: 4,
                      //             ),
                      //             Center(
                      //                 child: Text(
                      //                     '"Chytrá příprava na zkoušky.\nSnadno a efektivně"',
                      //                     textAlign: TextAlign.center,
                      //                     // "${homeController.homeScreenResponseModel?.mostPlayedQuiz?.title}",
                      //                     style: TextStyle(
                      //                         fontStyle:
                      //                             FontStyle.italic,
                      //                         fontSize: 14,
                      //                         fontWeight:
                      //                             FontWeight.bold,
                      //                         color: ThemeColor
                      //                             .burgundy)))
                      //           ],
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      model.isLoadingCategory ||
                              model.isLoadingUser ||
                              model.isLoadingScore ||
                              _easyLoadingStatus == EasyLoadingStatus.show
                          ? SizedBox()
                          : ExpandableCarousel(
                              options: ExpandableCarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 2),
                              ),
                              items: [1, 2, 3, 4, 5].map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        // decoration: BoxDecoration(
                                        //     color: Colors.amber),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.asset(
                                                  'assets/images/fotka.jpeg',
                                                  // height: 150,
                                                  fit: BoxFit.cover,
                                                ))
                                          ],
                                        ));
                                  },
                                );
                              }).toList(),
                            ),
                      SizedBox(
                        height: 16,
                      ),
                      // Stack(children: [
                      // Container(
                      //   height: 220,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(16),
                      //       color: ThemeColor.lighterPrimary),
                      // ),
                      // Image.asset(
                      //   "assets/images/featured_bg.png",
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      // _buildPromoBanner()
                      model.isLoadingCategory ||
                              model.isLoadingUser ||
                              model.isLoadingScore ||
                              _easyLoadingStatus == EasyLoadingStatus.show
                          ? SizedBox()
                          : _buildStatistics(model)
                      // ]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                model.isLoadingCategory ||
                        model.isLoadingUser ||
                        model.isLoadingScore ||
                        _easyLoadingStatus == EasyLoadingStatus.show
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                              top: 16, left: 16, right: 16),
                          decoration: BoxDecoration(
                              color: ThemeColor.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Categories",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: ThemeColor.black),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(DiscoverPage());
                                    },
                                    child: Text(
                                      "More Categories",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: ThemeColor.primary),
                                    ),
                                  )
                                ],
                              ),
                              ListView.separated(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 8);
                                  },
                                  scrollDirection: Axis.vertical,
                                  itemCount: model.categories.length,
                                  // homeController
                                  //         .homeScreenResponseModel?.quizzes?.length ??
                                  //     0,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                        onTap: () {
                                          Get.to(QuizDetailPage(
                                              model.categories[index]));
                                          // , arguments: {
                                          //   ARG_QUIZ_DETAIL: homeController
                                          //       .homeScreenResponseModel?.quizzes?[index]
                                          // });
                                        },
                                        child: QuizItemContainer(
                                            dataObj: model.categories[index]
                                            // homeController
                                            //     .homeScreenResponseModel?.quizzes?[index]
                                            ));
                                  }),
                            ],
                          ),
                        ),
                      ),
                SizedBox(
                  height: 24,
                ),
              ],
            ),
          ));
    });
  }

  Widget _buildPromoBanner() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              Text("PROMOTION",
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: ThemeColor.primary.withOpacity(0.8))),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Take this promo now\ndon't miss it",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ThemeColor.primary)),
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/subsPage');
                    },
                    child: Text(
                      "🛒 Buy a Plan",
                      style: TextStyle(color: ThemeColor.white),
                    ),
                    style: TextButton.styleFrom(
                      textStyle:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      backgroundColor: ThemeColor.black,
                    ),
                  )),
            ]));
  }

  Widget _buildStatistics(MainModel model) {
    return Container(
        // height: 220,
        margin: EdgeInsets.symmetric(horizontal: 16),
        width: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ThemeColor.lighterPrimary),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "Your Overview",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.textPrimary),
            ),
            SizedBox(height: 10),
            PieChartMyScore(model),
            SizedBox(height: 10),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: ThemeColor.primary,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Chemistry",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: ThemeColor.orange,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Sosiology",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: ThemeColor.primaryDark,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Mathematics",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.textPrimary),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                              color: ThemeColor.green,
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Biology",
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: ThemeColor.textPrimary),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class PieChartMyScore extends StatefulWidget {
  final MainModel model;

  PieChartMyScore(this.model);

  @override
  State<StatefulWidget> createState() => PieChartMyScoreState();
}

class PieChartMyScoreState extends State<PieChartMyScore> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSections(widget.model),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(MainModel model) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: ThemeColor.primary,
            value: 40,
            title: model.scoreList
                        .firstWhereOrNull(
                            (p) => p.categoryName!.contains("Chemistry"))!
                        .averageScore ==
                    null
                ? "0%"
                : '${double.parse(model.scoreList.firstWhereOrNull((p) => p.categoryName!.contains("Chemistry"))!.averageScore!).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/images/ophthalmology-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: ThemeColor.orange,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: ThemeColor.orange,
            value: 30,
            title: model.scoreList
                        .firstWhereOrNull(
                            (p) => p.categoryName!.contains("Sosiology"))!
                        .averageScore ==
                    null
                ? "0%"
                : '${double.parse(model.scoreList.firstWhereOrNull((p) => p.categoryName!.contains("Sosiology"))!.averageScore!).toInt()}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/images/librarian-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: ThemeColor.primary,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: ThemeColor.green,
            value: 16,
            title: model.scoreList
                        .firstWhereOrNull(
                            (p) => p.categoryName!.contains("Biology"))!
                        .averageScore ==
                    null
                ? "0%"
                : '${double.parse(model.scoreList.firstWhereOrNull((p) => p.categoryName!.contains("Biology"))!.averageScore!).toInt()}%',

            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/images/fitness-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: ThemeColor.primaryDark,
            // ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: ThemeColor.primaryDark,
            value: 15,
            title: model.scoreList
                        .firstWhereOrNull(
                            (p) => p.categoryName!.contains("Mathematics"))!
                        .averageScore ==
                    null
                ? "0%"
                : '${double.parse(model.scoreList.firstWhereOrNull((p) => p.categoryName!.contains("Mathematics"))!.averageScore!).toInt()}%',

            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            // badgeWidget: _Badge(
            //   'assets/images/worker-svgrepo-com.svg',
            //   size: widgetSize,
            //   borderColor: ThemeColor.green,
            // ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: SvgPicture.asset(
          svgAsset,
        ),
      ),
    );
  }
}
