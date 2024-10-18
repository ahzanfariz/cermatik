import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/theme/colors_theme.dart';
import 'package:confirmation_success/confirmation_success.dart';
import 'package:scoped_model/scoped_model.dart';

// https://dribbble.com/shots/7619455-SuccessPaymentPage/attachments/390409?mode=media

class SuccessPaymentPage extends StatefulWidget {
  @override
  _SuccessPaymentPageState createState() => _SuccessPaymentPageState();
}

class _SuccessPaymentPageState extends State<SuccessPaymentPage> {
  // String _image =
  //     "https://cdn.pixabay.com/photo/2019/07/25/17/09/camp-4363073__340.png";
  Color _backgroundColor = Color.fromRGBO(0, 61, 70, 1);
  // Color  ThemeColor.orange = Color.fromRGBO(98, 121, 193, 1);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ScaffoldMessengerState? _snackbarManager;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 1), () async {
      _snackbarManager = ScaffoldMessenger.of(context);

      var snackBar = SnackBar(
        /// need to set following properties for best effect of awesome_snackbar_content
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        showCloseIcon: false,
        duration: Duration(minutes: 10),
        backgroundColor: Colors.transparent,
        content: Container(
            height: 110,
            child: AwesomeSnackbarContent(
              title: 'Activate',
              message: "Premium Plan access has been activated to your account",
              contentType: ContentType.success,
            )),
      );
      _snackbarManager
        ?..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _snackbarManager?.hideCurrentSnackBar();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      return PopScope(
          canPop: false,
          onPopInvoked: (didPop) async {
            // logic
            Get.back();
            // _snackbarManager?.hideCurrentSnackBar();
            await model.fetchSubscriptions();
          },
          child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: ThemeColor.lighterPrimary,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            // floatingActionButton: Container(
            //   // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            //   height: 48.0,
            //   decoration: BoxDecoration(
            //       color: ThemeColor.primary,
            //       borderRadius: BorderRadius.circular(4.0)),
            //   child: Center(
            //       child: Text(
            //     "Print",
            //     style: TextStyle(
            //         color: ThemeColor.white,
            //         fontSize: 20.0,
            //         fontWeight: FontWeight.bold),
            //   )),
            // ),
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
                  bottom: 20,
                  child: Container(
                    // decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(8.0),
                    // image: DecorationImage(
                    //     image: NetworkImage(_image), fit: BoxFit.fill)),
                    child: Column(
                      children: <Widget>[
                        // appbar
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                color: Color.fromRGBO(
                                                    242, 197, 145, 1),
                                                borderRadius:
                                                    BorderRadius.circular(2.0)),
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
                                      // Text(
                                      //   "Your Receipt",
                                      //   style: TextStyle(
                                      //       color: ThemeColor.textSecondary,
                                      //       fontWeight: FontWeight.w600,
                                      //       fontSize: 10.0),
                                      // ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    Get.back();
                                    await model.fetchSubscriptions();
                                  },
                                  child: Container(
                                    height: 32.0,
                                    width: 32.0,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black),
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
                        ),
                        // Container(
                        //     margin: EdgeInsets.symmetric(vertical: 20),
                        //     padding: EdgeInsets.symmetric(horizontal: 20),
                        //     child: Text(
                        //       "You've successfully make a subscription for Premium plan. Here's your receipt, we'll send into your email too",
                        //       textAlign: TextAlign.center,
                        //       style: TextStyle(
                        //           color: ThemeColor.textSecondary,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 14.0),
                        //     )),
                        // SizedBox(height: 10),
                        // // Spacer(),
                        // Expanded(
                        //     child: Container(
                        //         padding: EdgeInsets.symmetric(horizontal: 16),
                        //         child: Image.asset(
                        //           'assets/images/img.png',
                        //           fit: BoxFit.cover,
                        //         ))),
                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(top: 110),
                            // padding: EdgeInsets.symmetric(horizontal: 20),
                            child: ConfirmationSuccess(
                                reactColor: ThemeColor.green,
                                showBubbleSplash: true,
                                child: Text("SUCCESS!",
                                    style: TextStyle(
                                        fontSize: 35,
                                        color: ThemeColor.white,
                                        fontWeight: FontWeight.bold)))),
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 50),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "You can access unlimited questions, remove ads and many more!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ThemeColor.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0),
                            )),
                        SizedBox(height: 10),

                        // listview
//                   Container(
// //                    alignment: Alignment.center,
//                       height: 250.0,
//                       child: Row(
//                         children: <Widget>[
//                           Flexible(
//                             flex: 1,
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   left: 16.0, right: 8.0, top: 64.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.white,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Flexible(
//                                     flex: 6,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Text(
//                                           "3",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 40.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "month",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         // SizedBox(
//                                         //   height: 8.0,
//                                         // ),
//                                         // Text(
//                                         //   "\$27.99",
//                                         //   style: TextStyle(
//                                         //       color:  ThemeColor.orange,
//                                         //       fontSize: 20.0,
//                                         //       fontWeight: FontWeight.bold),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 2.0,
//                                     color: ThemeColor.textPrimary,
//                                   ),
//                                   Flexible(
//                                     flex: 3,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Text(
//                                           "\$8.99",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "per month",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary
//                                                   .withOpacity(0.5),
//                                               fontSize: 12.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Flexible(
//                             flex: 1,
//                             child: Stack(
//                               children: <Widget>[
//                                 Positioned(
//                                   top: 8.0,
//                                   right: 8.0,
//                                   left: 8.0,
//                                   bottom: 12.0,
//                                   child: Container(
//                                     height: 250.0,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(8.0),
//                                       color: ThemeColor.orange,
//                                     ),
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Column(
//                                         children: <Widget>[
//                                           SizedBox(
//                                             height: 16.0,
//                                             child: Center(
//                                               child: Text(
//                                                 "PUPULAR".toUpperCase(),
//                                                 style: TextStyle(
//                                                     color: ThemeColor.white,
//                                                     fontSize: 12.0,
//                                                     fontWeight:
//                                                         FontWeight.bold),
//                                               ),
//                                             ),
//                                           ),
//                                           SizedBox(
//                                             height: 4.0,
//                                           ),
//                                           Flexible(
//                                             flex: 6,
//                                             child: Container(
//                                               color: Colors.white,
//                                               child: Center(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: <Widget>[
//                                                     Text(
//                                                       "12",
//                                                       style: TextStyle(
//                                                           color:
//                                                               ThemeColor.orange,
//                                                           fontSize: 40.0,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     Text(
//                                                       "month",
//                                                       style: TextStyle(
//                                                           color:
//                                                               ThemeColor.orange,
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     SizedBox(
//                                                       height: 8.0,
//                                                     ),
//                                                     // Text(
//                                                     //   "\$119.88",
//                                                     //   style: TextStyle(
//                                                     //       color:  ThemeColor.orange
//                                                     //           .withOpacity(0.5),
//                                                     //       fontSize: 12.0,
//                                                     //       fontWeight:
//                                                     //           FontWeight.bold,
//                                                     //       decoration:
//                                                     //           TextDecoration
//                                                     //               .lineThrough),
//                                                     // ),
//                                                     // Text(
//                                                     //   "\$79.99",
//                                                     //   style: TextStyle(
//                                                     //       color:  ThemeColor.orange,
//                                                     //       fontSize: 20.0,
//                                                     //       fontWeight:
//                                                     //           FontWeight.bold),
//                                                     // ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                           Container(
//                                             height: 2.0,
//                                             color: ThemeColor.orange,
//                                           ),
//                                           Flexible(
//                                             flex: 3,
//                                             child: Container(
//                                               decoration: BoxDecoration(
//                                                   color: Colors.white,
//                                                   borderRadius:
//                                                       BorderRadius.only(
//                                                           bottomLeft:
//                                                               Radius.circular(
//                                                                   8.0),
//                                                           bottomRight:
//                                                               Radius.circular(
//                                                                   8.0))),
//                                               child: Center(
//                                                 child: Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.center,
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.center,
//                                                   children: <Widget>[
//                                                     Text(
//                                                       "\$6.67",
//                                                       style: TextStyle(
//                                                           color:
//                                                               ThemeColor.orange,
//                                                           fontSize: 20.0,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                     Text(
//                                                       "per month",
//                                                       style: TextStyle(
//                                                           color: ThemeColor
//                                                               .orange
//                                                               .withOpacity(0.5),
//                                                           fontSize: 12.0,
//                                                           fontWeight:
//                                                               FontWeight.bold),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Positioned(
//                                   top: 0,
//                                   right: 0,
//                                   child: Icon(
//                                     Icons.check_circle,
//                                     size: 28.0,
//                                     color: Colors.white,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                           Flexible(
//                             flex: 1,
//                             child: Container(
//                               margin: EdgeInsets.only(
//                                   left: 8.0, right: 16.0, top: 64.0),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(8.0),
//                                 color: Colors.white,
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: <Widget>[
//                                   Flexible(
//                                     flex: 6,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Text(
//                                           "6",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 40.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "month",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         // SizedBox(
//                                         //   height: 8.0,
//                                         // ),
//                                         // Text(
//                                         //   "\47.99",
//                                         //   style: TextStyle(
//                                         //       color:  ThemeColor.orange,
//                                         //       fontSize: 20.0,
//                                         //       fontWeight: FontWeight.bold),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                   Container(
//                                     height: 2.0,
//                                     color: ThemeColor.textPrimary,
//                                   ),
//                                   Flexible(
//                                     flex: 3,
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: <Widget>[
//                                         Text(
//                                           "\$7.99",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary,
//                                               fontSize: 20.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                         Text(
//                                           "per month",
//                                           style: TextStyle(
//                                               color: ThemeColor.textPrimary
//                                                   .withOpacity(0.5),
//                                               fontSize: 12.0,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       )),

                        // SizedBox(height: 24.0),
                        // // text
                        // Text(
                        //   "Select your plan after 7-days",
                        //   style: TextStyle(
                        //       color: ThemeColor.textSecondary,
                        //       fontSize: 16.0,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        // Text(
                        //   "trial period",
                        //   style: TextStyle(
                        //       color: ThemeColor.textSecondary,
                        //       fontSize: 16.0,
                        //       fontWeight: FontWeight.bold),
                        // ),

                        // // try for free
                        // Container(
                        //   margin:
                        //       EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                        //   height: 48.0,
                        //   decoration: BoxDecoration(
                        //       color: ThemeColor.primary,
                        //       borderRadius: BorderRadius.circular(4.0)),
                        //   child: Center(
                        //       child: Text(
                        //     "Try for free",
                        //     style: TextStyle(
                        //         color: ThemeColor.white,
                        //         fontSize: 20.0,
                        //         fontWeight: FontWeight.bold),
                        //   )),
                        // ),

                        // // text
                        // Text(
                        //   "By clicking subscribe, you agree to the rules",
                        //   style: TextStyle(
                        //       color: Colors.grey[500],
                        //       fontWeight: FontWeight.w600,
                        //       fontSize: 10.0),
                        // ),
                        // RichText(
                        //   text: TextSpan(children: [
                        //     TextSpan(
                        //       text: "for ",
                        //       style: TextStyle(
                        //           color: Colors.grey[500],
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 10.0),
                        //     ),
                        //     TextSpan(
                        //       text: "using the servies ",
                        //       style: TextStyle(
                        //           color: ThemeColor.orange,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 10.0),
                        //     ),
                        //     TextSpan(
                        //       text: "and ",
                        //       style: TextStyle(
                        //           color: Colors.grey[500],
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 10.0),
                        //     ),
                        //     TextSpan(
                        //       text: "processing a payment",
                        //       style: TextStyle(
                        //           color: ThemeColor.orange,
                        //           fontWeight: FontWeight.w600,
                        //           fontSize: 10.0),
                        //     ),
                        //   ]),
                        // ),
                        // SizedBox(
                        //   height: 32.0,
                        // ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
