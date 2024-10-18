import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizzie_thunder/modules/dashboard/dashboard_page.dart';
import 'package:quizzie_thunder/modules/home/home_page.dart';
import 'package:quizzie_thunder/modules/welcome/welcome_page.dart';
import 'package:quizzie_thunder/services/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'modules/splash/splash_page.dart';
import 'theme/colors_theme.dart';

void main() async {
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 5)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.light
    ..indicatorSize = 75.0
    ..radius = 10.0
    ..progressColor = Colors.blue
    ..indicatorColor = Colors.blue
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MainModel model = MainModel();
    return ScopedModel(
        model: model,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: true,
          title: 'Cermatik',
          theme: ThemeData(
            fontFamily: GoogleFonts.lato().fontFamily,
          ).copyWith(
              colorScheme: ThemeData()
                  .colorScheme
                  .copyWith(primary: ThemeColor.primaryDark)),
          home: SplashPage(model),
          builder: EasyLoading.init(),
          // initialBinding: SplashBinding(),
          // getPages: AppPages.pages,
          routes: {
            '/home': (BuildContext context) => HomePage(model),
            // '/onboard': (BuildContext context) => OnboardingScreen(model)
            '/welcome': (BuildContext context) => WelcomePage(),
            '/dashboard': (BuildContext context) => DashboardPage()
          },
        ));
  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}
