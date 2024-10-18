import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/modules/dashboard/dashboard_page.dart';
import 'package:quizzie_thunder/modules/forgot_password/forgot_password_page.dart';
import 'package:quizzie_thunder/modules/privacy_policy/privacy_policy_page.dart';
import 'package:quizzie_thunder/modules/terms_conditions/terms_conditions_page.dart';
import 'package:quizzie_thunder/modules/verify_otp/verify_otp_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../routes/app_routes.dart';
import '../../theme/colors_theme.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var _passwordInVisible = true;
  Timer? _timer;
  var _formKey = GlobalKey<FormState>();

  Future _validateAndSubmit(MainModel model) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      var data = {
        'email': _emailController.text,
        'password': _passwordController.text,
        // 'fcm': "model.fcmToken"
      };

      var responseData = await model.signIn(data);
      if (responseData.statusCode == 200) {
        if (responseData.data["email_verified_at"] == "" ||
            responseData.data["email_verified_at"] == null) {
          var responseOTP = await model.sendOTPemail(responseData.data);

          if (responseOTP['otp'] != null) {
            //
            _timer?.cancel();
            await EasyLoading.dismiss();
            //
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    VerifyOtpPage(responseData.data, responseOTP)));
          }
        } else {
          //
          _timer?.cancel();
          await EasyLoading.dismiss();
          //
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                  builder: (BuildContext context) => DashboardPage()),
              (Route<dynamic> route) => false);
          //
          model.setIndexBottomNav(0);
        }

        //
        _passwordController.clear();
        _emailController.clear();
        //
      } else if (responseData.statusCode != 200) {
        print("Unathorized");
        AppUtils.showSnackBar(model.message,
            title: "Sign In", status: MessageStatus.ERROR);
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
      }
      // });
    } catch (e) {
      //
      _timer?.cancel();
      await EasyLoading.dismiss();
      print("Unathorized login");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    //
    _timer?.cancel();
    EasyLoading.dismiss();
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
                  color: ThemeColor.black,
                )),
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: ThemeColor.lighterPrimary,
          body:
              // Obx(() => signinController.isLoading.value
              //     ? const Center(child: CircularProgressIndicator())
              //     :
              SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Log In using your Account",
                    style: TextStyle(
                        fontSize: 26,
                        color: ThemeColor.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.textPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  color: ThemeColor.black, fontSize: 14),
                              // maxLength: 10,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  size: 18,
                                ),
                                contentPadding: EdgeInsets.all(12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Email",
                                hintStyle: TextStyle(
                                    fontSize: 14, color: ThemeColor.grey_500),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: ThemeColor.white,
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Email should not be empty";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Password",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.textPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              keyboardType: TextInputType.text,
                              obscureText: _passwordInVisible,
                              style: TextStyle(
                                  color: ThemeColor.black, fontSize: 14),
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outlined,
                                  size: 18,
                                ),
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordInVisible
                                          ? Icons.visibility_off
                                          : Icons
                                              .visibility, //change icon based on boolean value
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordInVisible =
                                            !_passwordInVisible;
                                      });
                                    }),
                                contentPadding: EdgeInsets.all(12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontSize: 14, color: ThemeColor.grey_500),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: ThemeColor.white,
                              ),
                              validator: (v) {
                                if (v!.isEmpty) {
                                  return "Password should not be empty";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              // autovalidateMode:
                              //     AutovalidateMode.onUserInteraction,
                            ),
                          ])),
                  SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(ForgotPasswordPage());
                    },
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 14,
                              color: ThemeColor.textSecondary,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(
                    height: 44,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _validateAndSubmit(model);
                          // signinController.login();
                        },
                        child: Text("Login",
                            style: TextStyle(color: ThemeColor.white)),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: ThemeColor.primary,
                        ),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  //   child: RichText(
                  //       text: TextSpan(
                  //           style: TextStyle(
                  //             fontSize: 14,
                  //           ),
                  //           children: [
                  //         TextSpan(
                  //           text: "Don't have the account yet? ",
                  //           style: TextStyle(
                  //             color: ThemeColor.grey,
                  //           ),
                  //         ),
                  //         TextSpan(
                  //             text: "Sign up",
                  //             style: TextStyle(
                  //                 color: ThemeColor.primary,
                  //                 fontSize: 17,
                  //                 fontWeight: FontWeight.bold),
                  //             recognizer: TapGestureRecognizer()
                  //               ..onTap =
                  //                   () => Get.toNamed(AppRoutes.signUpPage))
                  //       ])),
                  // ),
                  // SizedBox(
                  //   height: 44,
                  // ),
                  Container(
                      alignment: Alignment.center,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              style: TextStyle(fontSize: 14, height: 1.8),
                              children: [
                                TextSpan(
                                  text: "By continuing, you agree to our ",
                                  style: TextStyle(
                                      color: ThemeColor.grey, fontSize: 14),
                                ),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(TermsConditionsPage());
                                      },
                                    text: "Terms & Conditions",
                                    style: TextStyle(
                                        color: ThemeColor.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: "\nand ",
                                    style: TextStyle(
                                        color: ThemeColor.grey, fontSize: 14)),
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.to(PrivacyPolicyPage());
                                      },
                                    text: "Privacy Policy.",
                                    style: TextStyle(
                                        color: ThemeColor.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)),
                              ])))
                ],
              ),
            ),
          ));
    });
  }
}
