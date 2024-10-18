import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/model/product.dart';
import 'package:quizzie_thunder/modules/success_payment/success_payment_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';

import '../../theme/colors_theme.dart';
// import 'update_profile_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BuyPlanPage extends StatefulWidget {
  final dynamic data;
  final MainModel model;
  final Product product;

  BuyPlanPage(this.data, this.model, this.product);

  @override
  State<BuyPlanPage> createState() => _BuyPlanPageState();
}

class _BuyPlanPageState extends State<BuyPlanPage> {
  var controller;

  Timer? _timer;
  EasyLoadingStatus? _easyLoadingStatus = EasyLoadingStatus.show;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = WebViewController()
      ..setOnConsoleMessage(checkJavascriptLog)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(widget.data)) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.data));
  }

  Future checkJavascriptLog(JavaScriptConsoleMessage message) async {
    print("message: ${message.message}");

    if (message.message.contains("getEshopRedirect")) {
      _timer?.cancel();
      await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

      var formData = {
        'name': widget.model.user.name,
        'email': widget.model.user.email,
        'accumulated_expired': widget.model.user.accumulatedExpired == null ||
                widget.model.user.accumulatedExpired == ""
            ? "${DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: widget.product.period!)))}"
            : "${DateFormat('yyyy-MM-dd').format(DateTime.parse(widget.model.user.accumulatedExpired!).add(Duration(days: widget.product.period!)))}",
      };

      var responseData = await widget.model.editProfile(formData);
      if (responseData['data'] != null) {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();

        Navigator.of(context).pop();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => SuccessPaymentPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // UpdateProfileController updateProfileController =
    //     Get.find<UpdateProfileController>();
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: ThemeColor.black,
              )),
          title: Text(
            "Buy a Plan",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: ThemeColor.black),
          ),
          backgroundColor: Colors.transparent,
          centerTitle: false,
          elevation: 0,
        ),
        backgroundColor: ThemeColor.lighterPrimary,
        body: Container(
            padding: EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: ThemeColor.white,
                borderRadius: BorderRadius.circular(16)),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: WebViewWidget(controller: controller)));
  }
}
