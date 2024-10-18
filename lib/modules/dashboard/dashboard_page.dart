import 'package:flutter/material.dart';
import 'package:quizzie_thunder/modules/my_tokens/my_tokens_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../theme/colors_theme.dart';
import '../home/home_page.dart';
import '../profile/profile_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(builder: (context, child, model) {
      // DashboardController dashboardController = Get.find<DashboardController>();
      return Scaffold(
        backgroundColor: ThemeColor.white,
        extendBody: true,
        body: model.selectedIndex == 0
            ? HomePage(model)
            : model.selectedIndex == 1
                ? MyTokensPage(model)
                : ProfilePage(model),
        bottomNavigationBar:
            // Obx(() =>
            ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            backgroundColor: ThemeColor.white,
            selectedFontSize: 12,
            selectedIconTheme:
                IconThemeData(color: ThemeColor.primary, size: 24),
            selectedItemColor: ThemeColor.primary,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedIconTheme:
                IconThemeData(color: ThemeColor.grey, size: 24),
            unselectedItemColor: ThemeColor.grey,
            unselectedFontSize: 12,
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.token),
                label: "My Coins",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.pie_chart_rounded),
              //   label: "Leaderboard",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: "Me",
              ),
            ],
            currentIndex: model.selectedIndex,
            onTap: (v) => model.setIndexBottomNav(v),
          ),
          // )
        ),
        bottomSheet: Container(
          height: 0,
          color: ThemeColor.white,
        ),
      );
    });
  }
}
