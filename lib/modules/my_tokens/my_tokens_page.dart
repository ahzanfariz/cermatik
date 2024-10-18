import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quizzie_thunder/modules/my_tokens/subscription_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/theme/colors_theme.dart';
import 'package:scoped_model/scoped_model.dart';

class MyTokensPage extends StatefulWidget {
  final MainModel model;

  MyTokensPage(this.model);

  @override
  _MyTokensPageState createState() => _MyTokensPageState();
}

const int maxFailedLoadAttempts = 3;

class _MyTokensPageState extends State<MyTokensPage> {
  static const fluidButtonText = 'Fluid';
  static const inlineAdaptiveButtonText = 'Inline adaptive';
  static const anchoredAdaptiveButtonText = 'Anchored adaptive';
  static const nativeTemplateButtonText = 'Native template';
  static const webviewExampleButtonText = 'Register WebView';
  static const adInspectorButtonText = 'Ad Inspector';
  Color _backgroundColor = Color.fromRGBO(0, 61, 70, 1);

  Timer? _timer;
  EasyLoadingStatus? _easyLoadingStatus = EasyLoadingStatus.show;
  double padding = 16.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.model.subscriptionList.isEmpty) {
      loadData();
    } else {
      setState(() {
        _easyLoadingStatus = EasyLoadingStatus.dismiss;
      });
    }
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

    var data = await widget.model.fetchSubscriptions();
    if (data != null) {
      _timer?.cancel();
      await EasyLoading.dismiss();
      setState(() {
        _easyLoadingStatus = EasyLoadingStatus.dismiss;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.removeAllCallbacks();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: ThemeColor.primary,
        body: Container(
          child: Column(
            children: <Widget>[
              // appbar
              Container(
                height: 200.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: padding,
                      right: padding,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(padding * 0.5),
                        height: 130.0,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                spreadRadius: 1,
                                blurRadius: 1,
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            // which tool
                            Flexible(
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    // tool icon
                                    Container(
                                        padding:
                                            EdgeInsets.only(left: 5.0, top: 5),
                                        margin: EdgeInsets.only(right: padding),
                                        width: 80.0,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.asset(
                                              'assets/icon/fotka.jpeg',
                                              fit: BoxFit.cover),
                                        )),

                                    // text
                                    Flexible(
                                      fit: FlexFit.tight,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                "Cermatik ",
                                                style: TextStyle(
                                                    color:
                                                        ThemeColor.textPrimary,
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Container(
                                                height: 24.0,
                                                width: 40.0,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        242, 197, 145, 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2.0)),
                                                child: Center(
                                                    child: Text(
                                                  "Coin",
                                                  style: TextStyle(
                                                      color: _backgroundColor,
                                                      fontSize: 16.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 8.0),
                                          model.user.accumulatedExpired == null
                                              ? Text(
                                                  "you don't have any coin yet",
                                                  style: TextStyle(
                                                    fontSize: 13.0,
                                                    color: ThemeColor.grey_400,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                )
                                              : Row(children: [
                                                  Icon(Icons.token,
                                                      color: ThemeColor.primary,
                                                      size: 20),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    "Expires in ${daysBetween(DateTime.parse(model.user.accumulatedExpired!), DateTime.now())} days"
                                                        .replaceAll("-", ""),
                                                    style: TextStyle(
                                                      fontSize: 14.0,
                                                      color: ThemeColor.primary,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )
                                                ]),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // subscribe btn
                            Flexible(
                              child: Padding(
                                padding: EdgeInsets.only(top: padding),
                                child: Row(
                                  children: <Widget>[
                                    // unsubscribe
                                    // Flexible(
                                    //   child: Container(
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(4.0),
                                    //       color: Colors.grey,
                                    //       boxShadow: [
                                    //         BoxShadow(
                                    //           color: Colors.black12,
                                    //           blurRadius: 1,
                                    //           spreadRadius: 1,
                                    //         )
                                    //       ],
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "Unsubscribe",
                                    //         style: TextStyle(
                                    //           fontSize: 14.0,
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.w600,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),

                                    // SizedBox(width: padding),

                                    // update payment
                                    Flexible(
                                      child: SizedBox(
                                          width: double.infinity,
                                          height: 44,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              // _showInterstitialAd();
                                              // _showRewardedAd();
                                              Get.to(SubscriptionPage(model));
                                            },
                                            child: Text(
                                                "Subscribe a New Plan 🚀",
                                                style: TextStyle(
                                                    color: ThemeColor.white)),
                                            style: TextButton.styleFrom(
                                              textStyle: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              backgroundColor: ThemeColor.green,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // main box
              Container(
                  padding: EdgeInsets.only(
                      top: padding, left: padding, right: padding),
                  margin: EdgeInsets.all(padding),
                  height: MediaQuery.of(context).size.height / 1.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      // BoxShadow(
                      // color: Colors.black12,
                      // blurRadius: 1,
                      // spreadRadius: 1,
                      // )
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      // title
                      Row(
                        children: <Widget>[
                          Text(
                            "Payment activity",
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.show_chart,
                            size: 20.0,
                            color: Colors.grey,
                          ),
                        ],
                      ),

                      Divider(height: 24.0),

                      // SizedBox(height: 16),
                      model.isLoadingSubscription ||
                              _easyLoadingStatus == EasyLoadingStatus.show
                          ? Expanded(
                              child: Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          ThemeColor.primary))))
                          : Expanded(
                              child: !model.isLoadingSubscription &&
                                      model.subscriptionList.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: model.subscriptionList.length,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, i) {
                                        var mySubs = model.subscriptionList[i];
                                        return Container(
                                          margin: EdgeInsets.only(bottom: 16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // dot
                                              Container(
                                                margin: EdgeInsets.only(
                                                    top: 2.0, right: 16.0),
                                                height: 8.0,
                                                width: 8.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey,
                                                ),
                                              ),

                                              // content
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    "${mySubs.orderNumber!}",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "Subscribe for ${mySubs.product?.period} days - ${mySubs.product?.name}",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    "CZK ${mySubs.product?.price}",
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    )
                                  : _buildPromoBanner(),
                            ),
                    ],
                  ))
            ],
          ),
        ),
      );
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
              Icon(
                Icons.hourglass_empty_rounded,
                size: 150,
                color: ThemeColor.grey_200,
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Oops, you dont have any subscription currently",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: ThemeColor.textSecondary)),
              ),
              SizedBox(
                height: 24,
              ),
            ]));
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
}
