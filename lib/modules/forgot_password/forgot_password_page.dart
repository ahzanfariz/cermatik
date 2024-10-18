import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  var forgotPasswodFormKey =
      GlobalKey<FormState>(debugLabel: '__forgotPasswodFormKey__');

  final _emailController = TextEditingController();

  var _formKey = GlobalKey<FormState>();
  Timer? _timer;

  Future _validateAndSubmit(MainModel model) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();
    //
    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    try {
      var data = {"email": _emailController.text};

      var response = await model.sendResetPassword(data);

      if (response.statusCode == 200) {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        AppUtils.showSnackBar(
            "Password Reset was successfully sent to ${_emailController.text}. Check your email",
            title: "Forgot Passoword",
            status: MessageStatus.SUCCESS);

        Navigator.of(context).pop();
      } else {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        AppUtils.showSnackBar("Email is incorrect, please try again",
            title: "Forgot Passoword", status: MessageStatus.ERROR);
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
              "Forgot Password",
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
          body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Please enter your email below form to get a new password",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              height: 1.6,
                              fontSize: 14,
                              color: ThemeColor.textPrimary),
                        ),
                        SizedBox(
                          height: 24,
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
                          style:
                              TextStyle(color: ThemeColor.black, fontSize: 14),
                          // maxLength: 10,
                          decoration: InputDecoration(
                            counterText: '',
                            prefixIcon: Icon(
                              Icons.email,
                              size: 18,
                            ),
                            contentPadding: EdgeInsets.all(12),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            hintText: "Email Address",
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
                          textInputAction: TextInputAction.send,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
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
                                // forgotPasswordController.forgotPassword();
                              },
                              child: Text("Submit",
                                  style: TextStyle(color: ThemeColor.white)),
                              style: TextButton.styleFrom(
                                textStyle: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                backgroundColor: ThemeColor.primary,
                              ),
                            )),
                      ]))));
    });
  }
}
