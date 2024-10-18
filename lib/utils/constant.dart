class Constant {
  static const baseUrl = "https://cermatik.cheaperking.com";

  //AUTHTENTICATIONS
  static const login = "/api/auth/login";
  static const register = "/api/auth/register";
  static const otp = "/api/auth/otp";
  static const verify = "/api/auth/email/verify";
  static const resetPassword = "/api/auth/reset-password-with-email";

  //PRODUCT SUBSCRIPTION
  static const product = "/api/cermatik/product";

  //TRANSACTION
  static const subscription = "/api/cermatik/transaction";
  static const payment = "/api/pay-gopay";

  //CATEGORIES
  static const category = "/api/cermatik/category";

  // USER
  static const profile = "/api/cermatik/user";

  //SCORE
  static const average_score = "/api/cermatik/average-scores-by-user";
  static const score = "/api/cermatik/score";

  //UTILS
  static const publicAssets = "/storage/app/public/";

  //CHATS
  // static const serverUrl = "https://node-chat-hello.kitereative.com";
  // static const serverUrl = "https://node.chatnew.kitereative.com";
  static const serverUrl = "https://nodejs.hellohome.casa";
  // static const serverUrl = "https://socket-gilt.vercel.app";

  //COMPLAIN QUESTION
  static const complain_question = "/api/cermatik/complaint-question";
}
