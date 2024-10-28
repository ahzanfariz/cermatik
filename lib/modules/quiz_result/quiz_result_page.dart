import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/model/category.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizzie_thunder/services/main_model.dart';

import '../../theme/colors_theme.dart';

class QuizResultPage extends StatefulWidget {
  final Category category;
  final int? skipQuestionCount,
      correctAnswerCount,
      incorrectAnswerCount,
      completionPercentage;
  final MainModel model;

  QuizResultPage(this.category, this.skipQuestionCount, this.correctAnswerCount,
      this.incorrectAnswerCount, this.completionPercentage, this.model);

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  ScaffoldMessengerState? _snackbarManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ['0BDD08CA2A399454EB7E1DD241BCBB63']));
    //
    _createRewardedAd();
    //

    if (widget.model.user.accumulatedExpired == null ||
        widget.model.user.accumulatedExpired == "" ||
        widget.model.user.accumulatedExpired == "0") {
      _showPopupAndAds();
    }
  }

  Future _showPopupAndAds() async {
    Future.delayed(Duration(seconds: 2), () async {
      _snackbarManager = ScaffoldMessenger.of(context);

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: false,
        duration: Duration(minutes: 10),
        backgroundColor: Colors.transparent,
        content: Container(
            height: 90,
            child: AwesomeSnackbarContent(
              title: 'Help Us',
              message: "Watch this Ad to supporting Duolingo",
              contentType: ContentType.help,
            )),
      );
      _snackbarManager
        ?..hideCurrentSnackBar()
        ..showSnackBar(snackBar);

      Future.delayed(Duration(seconds: 3), () async {
        _showRewardedAd();
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _rewardedAd?.dispose();
    _snackbarManager?.hideCurrentSnackBar();
  }

  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId:
            // Platform.isAndroid
            //     ?
            'ca-app-pub-3484515075017173/1401746072',
        // : 'ca-app-pub-3940256099942544/1712485313',
        request: request,
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd!.setImmersiveMode(true);
    _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    _rewardedAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Result Exam",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: ThemeColor.darkGrey,
                ))
          ],
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: ThemeColor.white,
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: ThemeColor.lightPink,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        "${widget.category.question?[0].subject}",
                        style: TextStyle(
                            color: ThemeColor.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${widget.category.name}",
                        style: TextStyle(
                          color: ThemeColor.white,
                          fontSize: 12,
                        ),
                      ),
                      Image.asset(
                        "assets/images/prize.png",
                        width: 200,
                        height: 200,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "You get ${widget.correctAnswerCount! * 10} Exam Score",
                        style: TextStyle(
                            color: ThemeColor.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CORRECT ANSWER",
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.correctAnswerCount} questions",
                            style: TextStyle(
                                color: ThemeColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("COMPLETION",
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.completionPercentage}%",
                            style: TextStyle(
                                color: ThemeColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("SKIPPED",
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.skipQuestionCount}",
                            style: TextStyle(
                                color: ThemeColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    )),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("INCORRECT ANSWER",
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 12,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 8,
                        ),
                        Text("${widget.incorrectAnswerCount}",
                            style: TextStyle(
                                color: ThemeColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      ],
                    ))
                  ],
                )
              ],
            )));
  }
}
