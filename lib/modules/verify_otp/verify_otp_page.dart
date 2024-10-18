import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:quizzie_thunder/utils/app_utils.dart';
import 'package:quizzie_thunder/utils/enums/snackbar_status.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';

class VerifyOtpPage extends StatefulWidget {
  final Map otp;
  final Map user;

  VerifyOtpPage(this.user, this.otp);

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final firstOtpDigitController = TextEditingController();
  final secondOtpDigitController = TextEditingController();
  final thirdOtpDigitController = TextEditingController();
  final fourthOtpDigitController = TextEditingController();
  var errorMessage = "";

  final firstFocusNode = FocusNode();
  final secondFocusNode = FocusNode();
  final thirdFocusNode = FocusNode();
  final fourthFocusNode = FocusNode();
  late String _otpValue = "";
  Timer? _timer;
  var _startCountdown = true;
  var _countdownStartDuration = 150;

  bool _verifyOtpFieldValidation() {
    if (firstOtpDigitController.text.isEmpty ||
        secondOtpDigitController.text.isEmpty ||
        thirdOtpDigitController.text.isEmpty ||
        fourthOtpDigitController.text.isEmpty) {
      setState(() {
        errorMessage = "OTP fields should not be empty";
      });
      return false;
    } else {
      return true;
    }
  }

  void _validateAndSubmit(MainModel model) async {
    if (_verifyOtpFieldValidation()) {
      // isLoading.value = true;
      final otp = firstOtpDigitController.text +
          secondOtpDigitController.text +
          thirdOtpDigitController.text +
          fourthOtpDigitController.text;

      _timer?.cancel();
      await EasyLoading.show(maskType: EasyLoadingMaskType.custom);

      model.buildDelayed();
      FocusManager.instance.primaryFocus?.unfocus();

      Future.delayed(Duration(seconds: 2), () async {
        if (_otpValue != otp) {
          //
          _timer?.cancel();
          await EasyLoading.dismiss();
          //
          AppUtils.showSnackBar("Incorrect OTP Code. Please check again",
              status: MessageStatus.ERROR);
        } else {
          var responseVerify = await model.sendVerifiedEmail(widget.user);

          if (responseVerify['id'] != null) {
            //
            _timer?.cancel();
            await EasyLoading.dismiss();
            //
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/dashboard', (Route<dynamic> route) => false);
            //
            AppUtils.showSnackBar("Email verified successfully",
                title: "Verified", status: MessageStatus.SUCCESS);
            //
            firstOtpDigitController.clear();
            secondOtpDigitController.clear();
            thirdOtpDigitController.clear();
            fourthOtpDigitController.clear();
            //
            model.setIndexBottomNav(0);
            //
          } else {
            _timer?.cancel();
            await EasyLoading.dismiss();
            //
            AppUtils.showSnackBar("There is an error. Please check again",
                status: MessageStatus.ERROR);
          }
        }
      });
    } else {
      AppUtils.showSnackBar(errorMessage, status: MessageStatus.ERROR);
    }
  }

  @override
  void initState() {
    super.initState();

    _otpValue = widget.otp["otp"]["token"];
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
              // Obx(() => verifyOtpController.isLoading.value
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
                              "Verify your Email",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: ThemeColor.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 44,
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              text: TextSpan(
                                  style: TextStyle(height: 1.6, fontSize: 14),
                                  children: [
                                    TextSpan(
                                      text:
                                          "We have sent the OTP verification code to your",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ThemeColor.textPrimary),
                                    ),
                                    TextSpan(
                                      text: " ${widget.user['email']}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ThemeColor.primary,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextSpan(
                                        text:
                                            ". Kindly, check your inbox and enter the code below",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: ThemeColor.textPrimary)),
                                  ]),
                            ),
                            SizedBox(
                              height: 44,
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  otpInputField(
                                      firstOtpDigitController, firstFocusNode),
                                  otpInputField(secondOtpDigitController,
                                      secondFocusNode),
                                  otpInputField(
                                      thirdOtpDigitController, thirdFocusNode),
                                  otpInputField(fourthOtpDigitController,
                                      fourthFocusNode),
                                  // otpInputField(
                                  //     fifthOtpDigitController, fifthFocusNode),
                                  // otpInputField(
                                  //     sixthOtpDigitController, sixthFocusNode),
                                ]),
                            SizedBox(
                              height: 44,
                            ),
                            SizedBox(
                                width: double.infinity,
                                height: 44,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _validateAndSubmit(model);
                                    // verifyOtpController.verifyOtp();
                                  },
                                  child: Text("Confirm",
                                      style:
                                          TextStyle(color: ThemeColor.white)),
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: ThemeColor.primary,
                                  ),
                                )),
                            SizedBox(height: 12),
                            TweenAnimationBuilder<Duration>(
                                key: UniqueKey(),
                                duration:
                                    Duration(seconds: _countdownStartDuration),
                                tween: Tween(
                                    begin: Duration(
                                        seconds: _countdownStartDuration),
                                    end: Duration.zero),
                                onEnd: () {
                                  print('Timer ended');
                                  setState(() {
                                    _startCountdown = false;
                                  });
                                },
                                builder: (BuildContext context, Duration value,
                                    Widget? child) {
                                  final minutes = value.inMinutes;
                                  final seconds = value.inSeconds % 60;
                                  return Container(
                                    alignment: Alignment.center,
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: TextButton(
                                        onPressed: _startCountdown
                                            ? null
                                            : () async {
                                                //
                                                _timer?.cancel();
                                                await EasyLoading.show(
                                                    maskType:
                                                        EasyLoadingMaskType
                                                            .custom);

                                                //
                                                try {
                                                  var responseOTP =
                                                      await model.sendOTPemail(
                                                          widget.user);
                                                  if (responseOTP['otp'] !=
                                                      null) {
                                                    //
                                                    _timer?.cancel();
                                                    await EasyLoading.dismiss();
                                                    //
                                                    setState(() {
                                                      _otpValue =
                                                          responseOTP['otp']
                                                              ['token'];
                                                      _startCountdown = true;
                                                      _countdownStartDuration =
                                                          5;
                                                    });

                                                    AppUtils.showSnackBar(
                                                        "OTP Code sent, kindly check your email",
                                                        title: "Resend Code",
                                                        status: MessageStatus
                                                            .SUCCESS);
                                                    //
                                                  } else {
                                                    //
                                                    _timer?.cancel();
                                                    await EasyLoading.dismiss();

                                                    setState(() {
                                                      _startCountdown = true;
                                                      // _countdownDuration =
                                                      //     Duration(seconds: 5);
                                                    });

                                                    AppUtils.showSnackBar(
                                                        "Oops, unable to resend code lets try again",
                                                        title: "Resend Code",
                                                        status: MessageStatus
                                                            .ERROR);
                                                    //
                                                    print("error");
                                                  }
                                                } catch (e) {
                                                  print("error send otp");
                                                  print("$e");
                                                }
                                              },
                                        child: RichText(
                                          textAlign: TextAlign.justify,
                                          text: TextSpan(
                                              style: TextStyle(
                                                  height: 1.6, fontSize: 14),
                                              children: [
                                                TextSpan(
                                                  text: "Resend Code",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: !_startCountdown
                                                          ? ThemeColor.orange
                                                          : ThemeColor.grey_400,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                TextSpan(
                                                    text: !_startCountdown
                                                        ? ''
                                                        : ' ($minutes:$seconds)',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        color: ThemeColor
                                                            .grey_400)),
                                              ]),
                                        )),
                                  );
                                }),
                          ]))));
    });
  }

  Container otpInputField(
      TextEditingController controller, FocusNode focusNode) {
    return Container(
      width: 60,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        style: TextStyle(
            color: ThemeColor.black, fontSize: 25, fontWeight: FontWeight.bold),
        maxLength: 1,
        maxLines: 1,
        textAlign: TextAlign.center,
        onChanged: (value) {
          if (value.isNotEmpty) {
            focusNode
                .nextFocus(); // Move focus to the next field when a digit is entered
          }
        },
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.all(12),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: ThemeColor.white,
        ),
        textInputAction: TextInputAction.next,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      ),
    );
  }
}
