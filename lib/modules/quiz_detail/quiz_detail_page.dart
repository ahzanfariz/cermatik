import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizzie_thunder/model/category.dart';
import 'package:quizzie_thunder/modules/quiz_question/quiz_question_arrange_page.dart';
import 'package:quizzie_thunder/modules/quiz_question/quiz_question_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class QuizDetailPage extends StatefulWidget {
  final Category? category;

  QuizDetailPage(this.category);

  @override
  State<QuizDetailPage> createState() => _QuizDetailPageState();
}

class _QuizDetailPageState extends State<QuizDetailPage> {
  var _adsLoaded = false;
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  int maxFailedLoadAttempts = 3;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    MobileAds.instance.updateRequestConfiguration(RequestConfiguration(
        testDeviceIds: ['0BDD08CA2A399454EB7E1DD241BCBB63']));
    _createInterstitialAd();
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        print('ad onAdShowedFullScreenContent.');

        setState(() {
          _adsLoaded = true;
        });
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId:
            //  Platform.isAndroid
            //     ?
            'ca-app-pub-3484515075017173/3248587316',
        // : 'ca-app-pub-3940256099942544/4411468910',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }

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
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: ThemeColor.primary,
          body: Stack(
            children: [
              // Container(
              //     height: 200,
              //     color: ThemeColor.lighterPrimary,
              //     child: Center(
              //         child: Text(
              //       "Banner here",
              //     ))),
              Container(
                  margin: EdgeInsets.only(left: 0, right: 0),
                  padding: EdgeInsets.symmetric(horizontal: 0, vertical: 7),
                  color: ThemeColor.lighterPrimary,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.category!.name!.toLowerCase().contains("math")
                            ? 'assets/siroky/4.jpg'
                            : widget.category!.name!
                                    .toLowerCase()
                                    .contains("bio")
                                ? 'assets/siroky/3.jpg'
                                : widget.category!.name!
                                        .toLowerCase()
                                        .contains("phy")
                                    ? 'assets/siroky/1.jpg'
                                    : 'assets/siroky/2.jpg',
                        width: double.infinity,
                        height: 190,
                        fit: BoxFit.cover,
                      ))),
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: ThemeColor.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "TOPIC",
                            // quizDetailController.quizCategoryName.isEmpty
                            //     ? "${quizDetailController.quizDetail?.category?.title.toString().toUpperCase()}"
                            //     : quizDetailController.quizCategoryName
                            //         .toString()
                            //         .toUpperCase(),
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${widget.category?.name}",
                            style: TextStyle(
                                color: ThemeColor.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Container(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                  color: ThemeColor.candyPink,
                                  borderRadius: BorderRadius.circular(16)),
                              child: Text(
                                "Make sure you answer correctly. each ready has a value of 10 point",
                                style: TextStyle(
                                    color: ThemeColor.black, fontSize: 12),
                              )),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                                color: ThemeColor.lighterPrimary,
                                borderRadius: BorderRadius.circular(16)),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ThemeColor.lightGreen,
                                      radius: 14,
                                      child: Icon(
                                        Icons.question_mark_rounded,
                                        color: ThemeColor.white,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text(
                                        "${widget.category?.question?.length} questions",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                )),
                                SizedBox(
                                  width: 16,
                                ),
                                Expanded(
                                    child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: ThemeColor.lightOrange,
                                      radius: 14,
                                      child: Icon(
                                        Icons.extension_rounded,
                                        color: ThemeColor.white,
                                        size: 18,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Text("Advanced",
                                        style: TextStyle(
                                            color: ThemeColor.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "DESCRIPTION",
                            style: TextStyle(
                                color: ThemeColor.grey_500,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Cermatik category is the best category for learning various sciences. Dynamic questions with in-depth knowledge",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              color: ThemeColor.black,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 44,
                          ),
                          SizedBox(
                              width: double.infinity,
                              height: 44,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (model.user.accumulatedExpired == null ||
                                      model.user.accumulatedExpired == "" ||
                                      model.user.accumulatedExpired == "0") {
                                    if (!_adsLoaded) {
                                      _showInterstitialAd();
                                    }
                                  } else {
                                    setState(() {
                                      _adsLoaded = false;
                                    });

                                    if (widget.category!.question!
                                        .where((test) =>
                                            test.type!.contains("Arrange"))
                                        .toList()
                                        .isNotEmpty) {
                                      Get.to(QuizQuestionArrangePage(
                                          widget.category!));
                                    } else {
                                      Get.to(
                                          QuizQuestionPage(widget.category!));
                                    }
                                  }
                                },
                                child: Text("Start Exam",
                                    style: TextStyle(color: ThemeColor.white)),
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: ThemeColor.primaryDark,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ))
            ],
          ));
    });
  }
}
