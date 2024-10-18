import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quizzie_thunder/modules/privacy_policy/privacy_policy_page.dart';
import 'package:quizzie_thunder/modules/terms_conditions/terms_conditions_page.dart';
import 'package:quizzie_thunder/modules/verify_otp/verify_otp_page.dart';
import 'package:quizzie_thunder/routes/app_routes.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  final _fullNameController = TextEditingController();
  final _organizationController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneNumberController = TextEditingController();
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
        'name': _fullNameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        'phone': _phoneNumberController.text,
        'organization': _organizationController.text,
      };

      var responseData = await model.signUp(data);
      if (responseData["user"] != null) {
        var responseOTP = await model.sendOTPemail(responseData);

        if (responseOTP['otp'] != null) {
          _timer?.cancel();
          await EasyLoading.dismiss();
          //
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      VerifyOtpPage(responseData['user'], responseOTP)));

          //
          _fullNameController.clear();
          _organizationController.clear();
          _emailController.clear();
          _phoneNumberController.clear();
          _passwordController.clear();
        }
      } else {
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        print("Unathorized");
        AppUtils.showSnackBar(model.message,
            title: "Sign Up", status: MessageStatus.ERROR);
      }
    } catch (e) {
      print(e);
      print("Unathorized");
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
      // SignupController signupController = Get.find<SignupController>();
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
              // Obx(() => signupController.isLoading.value
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
                    "Create an Account",
                    style: TextStyle(
                        fontSize: 24,
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
                              "Full Name",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.textPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _fullNameController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: ThemeColor.black, fontSize: 14),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 18,
                                ),
                                contentPadding: EdgeInsets.all(12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Full Name",
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
                                  return "Full Name should not be empty";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Organization",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.textPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              controller: _organizationController,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: ThemeColor.black, fontSize: 14),
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  size: 18,
                                ),
                                contentPadding: EdgeInsets.all(12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Organization Name",
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
                                  return "Organization Name should not be empty";
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(
                              height: 16,
                            ),
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
                              decoration: InputDecoration(
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Phone Number",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: ThemeColor.textPrimary,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            // TextFormField(
                            //   controller: _phoneNumberController,
                            //   keyboardType: TextInputType.phone,
                            //   style: TextStyle(
                            //       color: ThemeColor.black, fontSize: 14),
                            //   maxLength: 10,
                            //   decoration: InputDecoration(
                            //     counterText: '',
                            //     prefixIcon: Icon(
                            //       Icons.phone_outlined,
                            //       size: 18,
                            //     ),
                            //     contentPadding: EdgeInsets.all(12),
                            //     floatingLabelBehavior:
                            //         FloatingLabelBehavior.never,
                            //     hintText: "Phone Number",
                            //     hintStyle: TextStyle(
                            //         fontSize: 14, color: ThemeColor.grey_500),
                            //     border: OutlineInputBorder(
                            //         borderRadius: BorderRadius.circular(10)),
                            //     enabledBorder: OutlineInputBorder(
                            //         borderSide:
                            //             BorderSide(color: Colors.transparent),
                            //         borderRadius: BorderRadius.circular(10)),
                            //     filled: true,
                            //     fillColor: ThemeColor.white,
                            //   ),
                            //   validator: (v) {
                            //     if (v!.isEmpty) {
                            //       return "Phone Number should not be empty";
                            //     }
                            //     return null;
                            //   },
                            //   textInputAction: TextInputAction.next,
                            //   autovalidateMode:
                            //       AutovalidateMode.onUserInteraction,
                            // ),
                            IntlPhoneField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                // contentPadding: EdgeInsets.all(12),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintText: "Number Phone",
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
                              disableLengthCheck: false,
                              initialCountryCode: 'CZ',
                              showDropdownIcon: false,
                              style: TextStyle(
                                  color: ThemeColor.black, fontSize: 14),
                              flagsButtonPadding:
                                  EdgeInsets.only(left: 12, top: 1.2),
                              textInputAction: TextInputAction.next,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (phone) {
                                print(phone.completeNumber);
                              },
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
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                            ),
                          ])),
                  SizedBox(
                    height: 20,
                  ),
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
                              ]))),
                  SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                      width: double.infinity,
                      height: 44,
                      child: ElevatedButton(
                        onPressed: () async {
                          await _validateAndSubmit(model);
                          // signupController.signUp();
                          // Get.toNamed(AppRoutes.verifyOtpPage);
                        },
                        child: Text("Register",
                            style: TextStyle(color: ThemeColor.white)),
                        style: TextButton.styleFrom(
                          textStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          backgroundColor: ThemeColor.primary,
                        ),
                      )),
                ],
              ),
            ),
          ));
    });
  }
}
