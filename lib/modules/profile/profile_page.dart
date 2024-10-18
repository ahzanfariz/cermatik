import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/modules/settings/settings_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/constant.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';
import '../../utils/app_utils.dart';

class ProfilePage extends StatefulWidget {
  final MainModel model;

  ProfilePage(this.model);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Timer? _timer;

  EasyLoadingStatus? _easyLoadingStatus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.model.user.name == null || widget.model.user.name == "")
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

    var data = await widget.model.fetchUser();
    if (data.email != null) {
      _timer?.cancel();
      await EasyLoading.dismiss();
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
    // ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => SettingsPage());
              },
              icon: Icon(
                Icons.settings_rounded,
                color: ThemeColor.white,
              ))
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: ThemeColor.primary,
      body: ScopedModelDescendant<MainModel>(builder: (context, child, model) {
        // Obx(() => RefreshIndicator(
        //       onRefresh: () async {
        //         profileController.getProfileScreenDetails();
        //       },
        //       child: profileController.isLoading.value
        //           ? const Center(
        //               child: CircularProgressIndicator(
        //               color: ThemeColor.white,
        //             ))
        //           :

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 36),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                decoration: BoxDecoration(
                    color: ThemeColor.white,
                    borderRadius: BorderRadius.circular(20)),
                child:
                    // Obx(
                    //   () =>
                    SingleChildScrollView(
                        child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Text(
                      "${model.nama}",
                      // "${profileController.profileScreenResponseModel?.userDetail?.firstname} ${profileController.profileScreenResponseModel?.userDetail?.lastname}",
                      style: TextStyle(
                          color: ThemeColor.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${model.email}",
                      // "${profileController.profileScreenResponseModel?.userDetail?.firstname} ${profileController.profileScreenResponseModel?.userDetail?.lastname}",
                      style: TextStyle(
                          color: ThemeColor.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 12),
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Text(
                      model.user.about == null ? '' : '"${model.user.about}"',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: ThemeColor.grey,
                          fontWeight: FontWeight.normal,
                          fontStyle: FontStyle.italic,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: ThemeColor.primary,
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          userInfoBlock(
                              Icons.star_border_outlined,
                              "AVG. SCORE",
                              model.scoreList
                                      .where((p) => p.averageScore != null)
                                      .toList()
                                      .isEmpty
                                  ? "0"
                                  : "${(model.scoreList.where((p) => p.averageScore != null).toList().map((m) => double.parse(m.averageScore!)).reduce((a, b) => a + b) / model.scoreList.length).toStringAsFixed(2)}"),
                          // "${profileController.profileScreenResponseModel?.stats?.points ?? 0}"),
                          // userInfoBlock(
                          //     Icons.bar_chart_outlined,
                          //     "RANK",
                          //     "#${profileController.profileScreenResponseModel?.stats?.rank ?? "--"}"),
                          userInfoBlock(Icons.book_outlined, "CATEGORIES",
                              "${model.scoreList.length}")
                          // "${profileController.profileScreenResponseModel?.stats?.quizWon ?? 0
                          // }
                          // "),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     // Column(
                    //     //   children: [
                    //     //     InkWell(
                    //     //       onTap: () {
                    //     //         profileController
                    //     //             .selectedTabIndex.value = 0;
                    //     //       },
                    //     //       child: Text(
                    //     //         "Badge",
                    //     //         style: TextStyle(
                    //     //             color: profileController
                    //     //                         .selectedTabIndex
                    //     //                         .value ==
                    //     //                     0
                    //     //                 ? ThemeColor.primaryDark
                    //     //                 : ThemeColor.grey_500,
                    //     //             fontSize: 16,
                    //     //             fontWeight: profileController
                    //     //                         .selectedTabIndex
                    //     //                         .value ==
                    //     //                     0
                    //     //                 ? FontWeight.bold
                    //     //                 : FontWeight.normal),
                    //     //       ),
                    //     //     ),
                    //     //     SizedBox(
                    //     //       height: 12,
                    //     //     ),
                    //     //     Visibility(
                    //     //       visible: profileController
                    //     //               .selectedTabIndex.value ==
                    //     //           0,
                    //     //       child: CircleAvatar(
                    //     //         radius: 3,
                    //     //         backgroundColor:
                    //     //             ThemeColor.primaryDark,
                    //     //       ),
                    //     //     )
                    //     //   ],
                    //     // ),
                    //     Column(
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             // profileController.selectedTabIndex.value = 1;
                    //           },
                    //           child:
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bar_chart_outlined, color: ThemeColor.green),
                        SizedBox(width: 5),
                        Text(
                          "My Statstics",
                          style: TextStyle(
                              color:
                                  //  profileController
                                  //             .selectedTabIndex.value ==
                                  //         1
                                  //     ? ThemeColor.textPrimary
                                  //     :
                                  ThemeColor.grey_500,
                              fontSize: 16,
                              fontWeight:
                                  //  profileController
                                  //             .selectedTabIndex.value ==
                                  //         1
                                  //     ? FontWeight.bold
                                  //     :
                                  FontWeight.normal),
                        ),
                      ],
                    )),
                    //         SizedBox(
                    //           height: 12,
                    //         ),
                    //         Visibility(
                    //           visible: true,
                    //           // profileController.selectedTabIndex.value ==
                    //           //     1,
                    //           child: CircleAvatar(
                    //             radius: 3,
                    //             backgroundColor: ThemeColor.textPrimary,
                    //           ),
                    //         )
                    //       ],
                    //     ),
                    //     Column(
                    //       children: [
                    //         InkWell(
                    //           onTap: () {
                    //             // profileController.selectedTabIndex.value = 2;
                    //           },
                    //           child: Text(
                    //             "My Profile",
                    //             style: TextStyle(
                    //                 color:
                    //                     // profileController
                    //                     //             .selectedTabIndex.value ==
                    //                     //         2
                    //                     //     ? ThemeColor.textPrimary
                    //                     //     :
                    //                     ThemeColor.grey_500,
                    //                 fontSize: 16,
                    //                 fontWeight:
                    //                     // profileController
                    //                     //             .selectedTabIndex.value ==
                    //                     //         2
                    //                     //     ? FontWeight.bold
                    //                     //     :
                    //                     FontWeight.normal),
                    //           ),
                    //         ),
                    //         SizedBox(
                    //           height: 12,
                    //         ),
                    //         Visibility(
                    //           visible: true,
                    //           // profileController.selectedTabIndex.value ==
                    //           //     2,
                    //           child: CircleAvatar(
                    //             radius: 3,
                    //             backgroundColor: ThemeColor.textPrimary,
                    //           ),
                    //         )
                    //       ],
                    //     )
                    //   ],
                    // ),
                    SizedBox(
                      height: 16,
                    ),
                    // if (profileController.selectedTabIndex.value == 0)
                    //   badgeSection()
                    // else if (profileController.selectedTabIndex.value == 1)
                    statsSection(model),
                    // else
                    SizedBox(
                      height: 64,
                    ),
                  ],
                )),
              ),
              // )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 80,
                    height: 80,
                    child: CircleAvatar(
                      backgroundColor: ThemeColor.white,
                      child: ClipOval(
                        child: CachedNetworkImage(
                            imageUrl:
                                "${Constant.baseUrl}${Constant.publicAssets}${model.user.image}",
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                                  child: Container(
                                    color: ThemeColor.white,
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      color: ThemeColor.primary,
                                    ),
                                  ),
                                ),
                            errorWidget: (context, url, error) => Container(
                                color: ThemeColor.white,
                                alignment: Alignment.center,
                                // margin: EdgeInsets.all(8),
                                child: Icon(
                                  Icons.account_circle_sharp,
                                  color: ThemeColor.grey_300,
                                  size: 80,
                                ))),
                      ),
                    )),
              ],
            ),
          ],
        );
      }),
    );
    // ));
  }

  Container detailSection(MainModel model) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "EMAIL",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.grey, fontSize: 12),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "mimdudin@gmail.com",
            // "${profileController.profileScreenResponseModel?.userDetail?.email}",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.black, fontSize: 16),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "PHONE",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.grey, fontSize: 12),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "+62 1231 4444 325",
            // "${profileController.profileScreenResponseModel?.userDetail?.mobile}",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.black, fontSize: 16),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "ABOUT",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.grey, fontSize: 12),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "${model.user.about}",
            // "${profileController.profileScreenResponseModel?.userDetail?.about ?? "--"}",
            textAlign: TextAlign.left,
            style: TextStyle(color: ThemeColor.black, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget statsSection(MainModel model) {
    return Stack(children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            "assets/images/stats_bg.png",
            width: double.infinity,
            fit: BoxFit.cover,
            height: 300,
          )),
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 48,
            ),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(
                        text: "Total complete questions ",
                        style: TextStyle(
                          color: ThemeColor.black,
                        ),
                      ),
                      // TextSpan(
                      //     text: "0 ",
                      //     // "${profileController.profileScreenResponseModel?.stats?.totalQuizPlayed ?? 0} ",
                      //     style: TextStyle(
                      //         color: ThemeColor.primary,
                      //         fontWeight: FontWeight.bold)),
                      TextSpan(
                          text: "from all topics",
                          style: TextStyle(
                              color: ThemeColor.black,
                              fontWeight: FontWeight.bold)),
                    ])),
            SizedBox(
              height: 36,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ThemeColor.primaryDark),
                    value: model.scoreList
                            .where((p) => p.averageScore != null)
                            .toList()
                            .isEmpty
                        ? 0.0
                        : double.parse((model.scoreList
                                    .where((p) => p.averageScore != null)
                                    .toList()
                                    .map((m) => double.parse(m.averageScore!))
                                    .reduce((a, b) => a + b) /
                                model.scoreList.length /
                                100)
                            .toStringAsFixed(2)),
                    // color: ThemeColor.primaryDark,
                    backgroundColor: ThemeColor.white,
                    strokeWidth: 10,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      model.scoreList
                              .where((p) => p.averageScore != null)
                              .toList()
                              .isEmpty
                          ? "0%"
                          : "${(model.scoreList.where((p) => p.averageScore != null).toList().map((m) => double.parse(m.averageScore!)).reduce((a, b) => a + b) / model.scoreList.length).toStringAsFixed(2)}%",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ThemeColor.black,
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Success Rate",
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColor.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            // SizedBox(
            //   height: 44,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Expanded(
            //         child: Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //           color: ThemeColor.white,
            //           borderRadius: BorderRadius.circular(10)),
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "0",
            //             // "${profileController.profileScreenResponseModel?.stats?.averagePointsPerQuiz?.toInt() ?? 0}",
            //             style: TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.bold,
            //               color: ThemeColor.black,
            //             ),
            //           ),
            //           SizedBox(
            //             height: 8,
            //           ),
            //           Text(
            //             "Average Score Per Questions",
            //             style: TextStyle(
            //               fontSize: 14,
            //               fontWeight: FontWeight.w500,
            //               color: ThemeColor.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //     )),
            //     SizedBox(
            //       width: 16,
            //     ),
            //     Expanded(
            //         child: Container(
            //       padding: const EdgeInsets.all(8),
            //       decoration: BoxDecoration(
            //           color: ThemeColor.primary,
            //           borderRadius: BorderRadius.circular(10)),
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Text(
            //               "0",
            //               // "${profileController.profileScreenResponseModel?.stats?.quizParticipationRate?.toInt() ?? 0}",
            //               style: TextStyle(
            //                 fontSize: 20,
            //                 fontWeight: FontWeight.bold,
            //                 color: ThemeColor.white,
            //               ),
            //             ),
            //             SizedBox(
            //               height: 8,
            //             ),
            //             Text(
            //               "Exam Test from All Categories",
            //               style: TextStyle(
            //                 fontSize: 14,
            //                 fontWeight: FontWeight.w500,
            //                 color: ThemeColor.white,
            //               ),
            //             ),
            //           ]),
            //     ))
            //   ],
            // )
          ],
        ),
      )
    ]);
  }

  GridView badgeSection() {
    return GridView.builder(
      itemCount: 6,
      padding: const EdgeInsets.all(12),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Image.asset(
          "assets/images/lock_badge.png",
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 32,
        mainAxisSpacing: 16,
      ),
    );
  }

  Column userInfoBlock(IconData icon, String title, String subTitle) {
    return Column(
      children: [
        Icon(
          icon,
          color: ThemeColor.white,
          size: 24,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: TextStyle(
              color: ThemeColor.white.withOpacity(0.5),
              fontWeight: FontWeight.bold,
              fontSize: 12),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          subTitle,
          style: TextStyle(
              color: ThemeColor.white,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        )
      ],
    );
  }
}
