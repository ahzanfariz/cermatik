import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class UpdatePasswordPage extends StatefulWidget {
  const UpdatePasswordPage({super.key});

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final GlobalKey<FormState> updatePasswordFormKey =
      GlobalKey<FormState>(debugLabel: '__updatePasswordFormKey__');

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var _passwordInVisible = true;
  var _confirmPasswordInVisible = true;
  Timer? _timer;

  Future _validateAndSubmit(MainModel model) async {
    if (!updatePasswordFormKey.currentState!.validate()) {
      return;
    }

    _timer?.cancel();
    await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

    updatePasswordFormKey.currentState!.save();
    FocusManager.instance.primaryFocus?.unfocus();

    try {
      var data = {
        'name': model.nama,
        'email': model.email,
        'password': confirmPasswordController.text,
        'password_now': passwordController.text,
      };

      var responseData = await model.changePassword(data);
      if (responseData.data['message'] == 'true') {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        Navigator.of(context).pop();
        //
        AppUtils.showSnackBar("Password has been changed",
            title: "Success", status: MessageStatus.SUCCESS);
      } else {
        //
        _timer?.cancel();
        await EasyLoading.dismiss();
        //
        AppUtils.showSnackBar("Unable to change your password",
            title: "Failed", status: MessageStatus.ERROR);
      }
    } catch (e) {
      print(e);
      print("Unathorized");
    }
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
              "Change Password",
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                  padding: EdgeInsets.zero,
                  child: Form(
                    key: updatePasswordFormKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Your new password must be different from the previous used passwords",
                            style: TextStyle(
                                fontSize: 14, color: ThemeColor.textPrimary),
                          ),
                          SizedBox(
                            height: 24,
                          ),
                          Text(
                            "Current Password",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: passwordController,
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
                                      _passwordInVisible = !_passwordInVisible;
                                    });
                                  }),
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "Current Password",
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
                              if (v!.isEmpty || v.length < 6) {
                                return "Current Password is invalid";
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
                            "New Password",
                            style: TextStyle(
                                fontSize: 14,
                                color: ThemeColor.textPrimary,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          TextFormField(
                            controller: confirmPasswordController,
                            keyboardType: TextInputType.text,
                            obscureText: _confirmPasswordInVisible,
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
                                    _confirmPasswordInVisible
                                        ? Icons.visibility_off
                                        : Icons
                                            .visibility, //change icon based on boolean value
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmPasswordInVisible =
                                          !_confirmPasswordInVisible;
                                    });
                                  }),
                              contentPadding: EdgeInsets.all(12),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              hintText: "New Password",
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
                              if (v!.isEmpty || v.length < 6) {
                                return "New Password must have min. 6 char";
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                },
                                child: Text("Update Password",
                                    style: TextStyle(color: ThemeColor.white)),
                                style: TextButton.styleFrom(
                                  textStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12)),
                                  backgroundColor: ThemeColor.primary,
                                ),
                              )),
                          SizedBox(height: 20),
                        ]),
                  ))));
    });
  }
}
