import 'package:get/get.dart';
import 'package:quizzie_thunder/modules/success_payment/success_payment_page.dart';

import '../modules/create_new_password/create_new_password_binding.dart';
import '../modules/create_new_password/create_new_password_page.dart';
import '../modules/quizzes/quizzes_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    // GetPage(
    //   name: AppRoutes.splashPage,
    //   page: () => SplashPage(),
    //   binding: SplashBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.welcomePage,
    //   page: () => WelcomePage(),
    //   binding: WelcomeBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.signInPage,
    //   page: () => SigninPage(),
    //   binding: SigninBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.forgotPasswordPage,
    //   page: () => ForgotPasswordPage(),
    //   binding: ForgotPasswordBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.createNewPasswordPage,
    //   page: () => CreateNewPasswordPage(),
    //   binding: CreateNewPasswordBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.updatePasswordPage,
    //   page: () => UpdatePasswordPage(),
    //   binding: UpdatePasswordBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.signUpPage,
    //   page: () => SignupPage(),
    //   binding: SignupBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.verifyOtpPage,
    //   page: () => VerifyOtpPage(),
    //   binding: VerifyOtpBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.dashboardPage,
    //   page: () => DashboardPage(),
    //   binding: DashboardBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.settingsPage,
    //   page: () => SettingsPage(),
    //   binding: SettingsBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.quizzesPage,
    //   page: () => QuizzesPage(),
    //   binding: QuizzesBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.updateProfilePage,
    //   page: () => UpdateProfilePage(),
    //   binding: UpdateProfileBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.quizDetailPage,
    //   page: () => QuizDetailPage(),
    //   binding: QuizDetailBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.quizResultPage,
    //   page: () => QuizResultPage(),
    //   binding: QuizResultBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.quizQuestionPage,
    //   page: () => QuizQuestionPage(),
    //   binding: QuizQuestionBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.discoverPage,
    //   page: () => DiscoverPage(),
    //   binding: DiscoverBinding(),
    // ),
    // GetPage(
    //   name: AppRoutes.privacyPolicyPage,
    //   page: () => PrivacyPolicyPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.termsConditionsPage,
    //   page: () => TermsConditionsPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.faqPage,
    //   page: () => FAQPage(),
    // ),
    // GetPage(
    //   name: AppRoutes.subsPage,
    //   page: () => SubscriptionPage(),
    // ),
    GetPage(
      name: AppRoutes.successPayment,
      page: () => SuccessPaymentPage(),
    ),
  ];
}
