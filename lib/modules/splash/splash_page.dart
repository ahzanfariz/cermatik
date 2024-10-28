import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:quizzie_thunder/services/main_model.dart';

import '../../theme/colors_theme.dart';

class SplashPage extends StatefulWidget {
  final MainModel model;
  SplashPage(this.model);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  String _token = "";

  startTime() async {
    // return Timer(Duration(seconds: 10), () {
    if (_token == "") {
      Navigator.of(context).pushReplacementNamed('/welcome');
    } else {
      Navigator.of(context).pushReplacementNamed('/dashboard');
    }
    // else
    //   {Navigator.of(context).pushReplacementNamed('/home')}
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.model.checkUid().then((data) {
    //   setState(() {
    //     _token = data['token'];
    //     // _phone = data['phone'];
    //   });
    //   print("Token onboard: $_token");

    //   // startTime();
    // });
    //
  }

  @override
  Widget build(BuildContext context) {
    // SplashController splashController = Get.find<SplashController>();
    return Scaffold(
        backgroundColor: ThemeColor.primary,
        body: FlutterSplashScreen.fadeIn(
          backgroundColor: ThemeColor.primary,
          onInit: () {},
          animationDuration: Duration(seconds: 3),
          duration: Duration(seconds: 3),
          // useImmersiveMode: true,
          // setStateTimer: Duration(seconds: 4),
          // duration: Duration(seconds: 4),
          // asyncNavigationCallback: () async {
          //   await widget.model.checkUid().then((data) {
          //     setState(() {
          //       _token = data['token'];
          //       // _phone = data['phone'];
          //     });
          //     // startTime();

          //     print("Token onboard: $_token");
          //   });
          // },
          // nextScreen: _token == "" ? WelcomePage() : DashboardPage(),
          onEnd: () {
            debugPrint("On End");
          },
          childWidget: Stack(
            children: [
              Image.asset(
                "assets/images/splash_bg.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            "assets/images/cermatik.jpeg",
                            width: 150,
                            height: 150,
                          )),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        "CERMATIK",
                        style: TextStyle(
                            fontSize: 32,
                            color: ThemeColor.white,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "",
                        style: TextStyle(
                            fontSize: 16,
                            color: ThemeColor.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.bottomCenter,
                        child:
                            // Obx(() =>
                            Text("cermatik.cz",
                                // "App version v${splashController.appVersion.value}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: ThemeColor.white,
                                  fontSize: 12,
                                ))),
                    // ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              )
            ],
          ),
          onAnimationEnd: () {
            widget.model.checkUid().then((data) {
              setState(() {
                _token = data['token'];
                // _phone = data['phone'];
              });
              print("Token onboard: $_token");

              startTime();
            });
          },
          // nextScreen:
        ));
  }
}
