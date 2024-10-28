import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/model/product.dart';
import 'package:quizzie_thunder/modules/my_tokens/buy_plan_page.dart';
import 'package:quizzie_thunder/modules/privacy_policy/privacy_policy_page.dart';
import 'package:quizzie_thunder/modules/terms_conditions/terms_conditions_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/theme/colors_theme.dart';
import 'package:scoped_model/scoped_model.dart';

// https://dribbble.com/shots/7619455-SubscriptionPage/attachments/390409?mode=media

class SubscriptionPage extends StatefulWidget {
  final MainModel model;

  SubscriptionPage(this.model);

  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  // String _image =
  //     "https://cdn.pixabay.com/photo/2019/07/25/17/09/camp-4363073__340.png";
  Color _backgroundColor = Color.fromRGBO(0, 61, 70, 1);
  // Color  ThemeColor.orange = Color.fromRGBO(98, 121, 193, 1);

  Timer? _timer;
  // EasyLoadingStatus? _easyLoadingStatus;

  Product? _selectedSubs;

  void selectedSubs(Product? product) {
    setState(() {
      _selectedSubs = product;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.model.productList.isEmpty) loadData();
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.removeAllCallbacks();
  }

  Future loadData() async {
    // EasyLoading.addStatusCallback((status) {
    //   print('EasyLoading Status $status');
    //   setState(() {
    //     _easyLoadingStatus = status;
    //   });
    // });

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    var data = await widget.model.fetchSubscriptionPlanProducts();
    if (data != null) {
      _timer?.cancel();
      await EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return Scaffold(
        backgroundColor: ThemeColor.lighterPrimary,
        body: Stack(
          children: <Widget>[
            //
//           Positioned(
//             top: 24.0,
//             left: 16.0,
//             right: 16.0,
//             bottom: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8.0),
//                   color: Colors.deepPurple),
// //          child: Placeholder(),
//             ),
//           ),
            // main
            Positioned(
              top: 32.0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                // decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8.0),
                // image: DecorationImage(
                //     image: NetworkImage(_image), fit: BoxFit.fill)),
                child: Column(
                  children: <Widget>[
                    _buildAppBar(),
                    // Spacer(),
                    SizedBox(height: 60),
                    Text(
                      "Choose a best offer only for you:",
                      style: TextStyle(
                          color: ThemeColor.textPrimary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),

                    Container(
//                    alignment: Alignment.center,
                        height: 300.0,
                        child: model.isLoadingProduct
                            ? Center(child: CircularProgressIndicator())
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: model.productList.map((e) {
                                  return Expanded(
                                      child: GestureDetector(
                                    onTap: () {
                                      selectedSubs(e);
                                    },
                                    child: _selectedSubs == e
                                        ? Container(
                                            child: Stack(
                                              children: <Widget>[
                                                Positioned(
                                                  top: 8.0,
                                                  right: 8.0,
                                                  left: 8.0,
                                                  bottom: 12.0,
                                                  child: Container(
                                                    height: 250.0,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      color: ThemeColor.orange,
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                            height: 16.0,
                                                            child: Center(
                                                              child: Text(
                                                                "CHOOSEN"
                                                                    .toUpperCase(),
                                                                style: TextStyle(
                                                                    color: ThemeColor
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 4.0,
                                                          ),
                                                          Flexible(
                                                            flex: 6,
                                                            child: Container(
                                                              color:
                                                                  Colors.white,
                                                              child: Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "${e.name}"
                                                                          .toUpperCase(),
                                                                      style: TextStyle(
                                                                          color: ThemeColor
                                                                              .orange,
                                                                          fontSize:
                                                                              18.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                        height:
                                                                            8),
                                                                    Text(
                                                                      "${e.period} days",
                                                                      style: TextStyle(
                                                                          color: ThemeColor
                                                                              .orange,
                                                                          fontSize:
                                                                              16.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          8.0,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: 2.0,
                                                            color: ThemeColor
                                                                .orange,
                                                          ),
                                                          Flexible(
                                                            flex: 3,
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  borderRadius: BorderRadius.only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8.0))),
                                                              child: Center(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      "CZK ${e.price}",
                                                                      style: TextStyle(
                                                                          color: ThemeColor
                                                                              .orange,
                                                                          fontSize:
                                                                              20.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      "${e.description}",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                      style: TextStyle(
                                                                          color: ThemeColor.orange.withOpacity(
                                                                              0.5),
                                                                          fontSize:
                                                                              11.0,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    size: 28.0,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 64.0),
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: ThemeColor.grey_200
                                                      .withOpacity(0.5),
                                                  spreadRadius: 2,
                                                  blurRadius: 7,
                                                  offset: Offset(2,
                                                      1), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                  flex: 6,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "${e.name}"
                                                            .toUpperCase(),
                                                        style: TextStyle(
                                                            color: ThemeColor
                                                                .textPrimary,
                                                            fontSize: 18.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(height: 8),
                                                      Text(
                                                        "${e.period} days",
                                                        style: TextStyle(
                                                            color: ThemeColor
                                                                .textPrimary,
                                                            fontSize: 16.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // SizedBox(
                                                      //   height: 8.0,
                                                      // ),
                                                      // Text(
                                                      //   "\$27.99",
                                                      //   style: TextStyle(
                                                      //       color:  ThemeColor.orange,
                                                      //       fontSize: 20.0,
                                                      //       fontWeight: FontWeight.bold),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height: 2.0,
                                                  color: ThemeColor.grey_200,
                                                ),
                                                Flexible(
                                                  flex: 3,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Text(
                                                        "CZK ${e.price}",
                                                        style: TextStyle(
                                                            color: ThemeColor
                                                                .textPrimary,
                                                            fontSize: 20.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        "${e.description}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: ThemeColor
                                                                .textPrimary
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 11.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ));
                                }).toList(),

                                //     GestureDetector(
                                //         onTap: () {
                                //           selectedSubs(model.productList[0]);
                                //         },
                                //         child: Flexible(
                                //           flex: 1,
                                //           child: Container(
                                //             margin: EdgeInsets.only(
                                //                 left: 8.0,
                                //                 right: 16.0,
                                //                 top: 64.0),
                                //             decoration: BoxDecoration(
                                //               borderRadius:
                                //                   BorderRadius.circular(8.0),
                                //               color: Colors.white,
                                //             ),
                                //             child: Column(
                                //               crossAxisAlignment:
                                //                   CrossAxisAlignment.center,
                                //               children: <Widget>[
                                //                 Flexible(
                                //                   flex: 6,
                                //                   child: Column(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment.center,
                                //                     mainAxisAlignment:
                                //                         MainAxisAlignment.center,
                                //                     children: <Widget>[
                                //                       Text(
                                //                         "\$${model.productList[0].period}",
                                //                         style: TextStyle(
                                //                             color: ThemeColor
                                //                                 .textPrimary,
                                //                             fontSize: 40.0,
                                //                             fontWeight:
                                //                                 FontWeight.bold),
                                //                       ),
                                //                       Text(
                                //                         "month",
                                //                         style: TextStyle(
                                //                             color: ThemeColor
                                //                                 .textPrimary,
                                //                             fontSize: 20.0,
                                //                             fontWeight:
                                //                                 FontWeight.bold),
                                //                       ),
                                //                       // SizedBox(
                                //                       //   height: 8.0,
                                //                       // ),
                                //                       // Text(
                                //                       //   "\47.99",
                                //                       //   style: TextStyle(
                                //                       //       color:  ThemeColor.orange,
                                //                       //       fontSize: 20.0,
                                //                       //       fontWeight: FontWeight.bold),
                                //                       // ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //                 Container(
                                //                   height: 2.0,
                                //                   color: ThemeColor.textPrimary,
                                //                 ),
                                //                 Flexible(
                                //                   flex: 3,
                                //                   child: Column(
                                //                     crossAxisAlignment:
                                //                         CrossAxisAlignment.center,
                                //                     mainAxisAlignment:
                                //                         MainAxisAlignment.center,
                                //                     children: <Widget>[
                                //                       Text(
                                //                         "\$${model.productList[0].price}",
                                //                         style: TextStyle(
                                //                             color: ThemeColor
                                //                                 .textPrimary,
                                //                             fontSize: 20.0,
                                //                             fontWeight:
                                //                                 FontWeight.bold),
                                //                       ),
                                //                       Text(
                                //                         "most popular",
                                //                         style: TextStyle(
                                //                             color: ThemeColor
                                //                                 .textPrimary
                                //                                 .withOpacity(0.5),
                                //                             fontSize: 12.0,
                                //                             fontWeight:
                                //                                 FontWeight.bold),
                                //                       ),
                                //                     ],
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           ),
                                //         // )),
                                //   // ],
                              )),

                    SizedBox(height: 40.0),
                    // text
                    Text(
                      "Best deal for student",
                      style: TextStyle(
                          color: ThemeColor.textSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "until october",
                      style: TextStyle(
                          color: ThemeColor.textSecondary,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                    ),

                    // try for free
                    InkWell(
                      onTap: () async {
                        _timer?.cancel();
                        await EasyLoading.show(
                            maskType: EasyLoadingMaskType.custom);
                        //
                        // Get.toNamed(AppRoutes.successPayment);
                        var response = await model.makePayment({
                          "order_description": _selectedSubs?.name,
                          "amount": _selectedSubs?.price,
                          "email": model.user.email,
                          "phone_number": model.user.phone,
                          "first_name": model.user.name,
                          "last_name": "${model.uid}",
                          "products_id": _selectedSubs?.id,
                          "users_id": model.user.id,
                        });

                        print(response['data']);

                        if (response['data'] != null) {
                          //
                          _timer?.cancel();
                          await EasyLoading.dismiss();
                          //
                          Get.to(BuyPlanPage(
                              response['data'], model, _selectedSubs!));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        height: 48.0,
                        decoration: BoxDecoration(
                            color: ThemeColor.primary,
                            borderRadius: BorderRadius.circular(4.0)),
                        child: Center(
                            child: Text(
                          "Buy a Plan",
                          style: TextStyle(
                              color: ThemeColor.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),

                    // text
                    Text(
                      "By clicking subscribe, you agree to the rules",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: "for ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                        TextSpan(
                          text: "using the servies ",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(TermsConditionsPage());
                            },
                          style: TextStyle(
                              color: ThemeColor.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                        TextSpan(
                          text: "and ",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                              fontSize: 12.0),
                        ),
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(PrivacyPolicyPage());
                            },
                          text: "processing a payment",
                          style: TextStyle(
                              color: ThemeColor.orange,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 32.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return // appbar
        SafeArea(
      top: true,
      left: true,
      right: true,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0),
        height: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              height: 40.0,
              width: 200.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Cermatik ",
                        style: TextStyle(
                            color: ThemeColor.textPrimary,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Container(
                        height: 24.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(242, 197, 145, 1),
                            borderRadius: BorderRadius.circular(2.0)),
                        child: Center(
                            child: Text(
                          "Coin",
                          style: TextStyle(
                              color: _backgroundColor,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )),
                      )
                    ],
                  ),
                  Text(
                    "open full access exam",
                    style: TextStyle(
                        color: ThemeColor.textSecondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10.0),
                  ),
                ],
              ),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 32.0,
                width: 32.0,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                child: Center(
                    child: Icon(
                  Icons.close,
                  size: 20.0,
                  color: Colors.white,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
