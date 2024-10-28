import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:quizzie_thunder/modules/faq/faq_page.dart';
import 'package:quizzie_thunder/modules/privacy_policy/privacy_policy_page.dart';
import 'package:quizzie_thunder/modules/terms_conditions/terms_conditions_page.dart';
import 'package:quizzie_thunder/modules/udpate_password/update_password_page.dart';
import 'package:quizzie_thunder/modules/update_profile/update_profile_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';
import 'package:share_plus/share_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Timer? _timer;

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
              "Settings",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColor.black),
            ),
            backgroundColor: Colors.transparent,
            centerTitle: false,
            elevation: 0,
          ),
          backgroundColor: ThemeColor.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ACCOUNT",
                      style: TextStyle(
                          color: ThemeColor.grey_500,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(UpdateProfilePage(model));
                    },
                    child: settingsInfoContainer(
                        Icons.person_outline_rounded,
                        "Update Profile",
                        "Update first name, last name, avatar etc"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(UpdatePasswordPage());
                    },
                    child: settingsInfoContainer(Icons.lock_outline_rounded,
                        "Change Password", "Update your password"),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                    onTap: () {
                      Share.share(
                          'Download Cermatik in PlayStore\nhttps://play.google.com/store/apps/details?id=cermatik.cz\n\n"Smart exam preparation. Easy and efficient."',
                          subject: 'Download Cermatik');
                    },
                    child: settingsInfoContainer(Icons.share, "Share",
                        "Tell your friends about Cermatik"),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text("OTHER",
                      style: TextStyle(
                          color: ThemeColor.grey_500,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(PrivacyPolicyPage());
                      },
                      child: settingsInfoContainer(Icons.info, "Privacy Policy",
                          "read more our privacy policy")),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(TermsConditionsPage());
                      },
                      child: settingsInfoContainer(
                          Icons.info,
                          "Terms & Conditions",
                          "checkout our terms and conditions")),
                  SizedBox(
                    height: 12,
                  ),
                  InkWell(
                      onTap: () {
                        Get.to(FAQPage());
                      },
                      child: settingsInfoContainer(Icons.question_mark_rounded,
                          "FAQ", "Most frequently asked questions")),
                  SizedBox(
                    height: 44,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () async {
                        _timer?.cancel();
                        await EasyLoading.show(
                            maskType: EasyLoadingMaskType.custom);

                        await model.logOut().then((_) async {
                          model.clearUser();
                          model.clearAllCategory();
                          model.clearAverageScore();
                          model.clearSubscriptionProduct();
                          model.clearMySubscriptions();

                          Navigator.pushNamedAndRemoveUntil(context, "/welcome",
                              (Route<dynamic> route) => false);
                        });
                        //
                        _timer?.cancel();
                        await EasyLoading.dismiss();

                        // model.setIndexBottomNav(0);
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(
                            color: ThemeColor.lightRed,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  Container settingsInfoContainer(
      IconData icon, String title, String subTitle) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ThemeColor.lighterPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: ThemeColor.white,
                radius: 18,
                child: Icon(
                  icon,
                  color: ThemeColor.primaryDark,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16, color: ThemeColor.black),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(
                        fontSize: 12, color: ThemeColor.textSecondary),
                  ),
                ],
              )
            ],
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: ThemeColor.darkGrey,
            size: 16,
          ),
        ],
      ),
    );
  }
}
