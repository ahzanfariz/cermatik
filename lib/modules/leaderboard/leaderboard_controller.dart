// import 'package:get/get.dart';

// import '../../apis/leaderboard_api.dart';
// import '../../models/leaderboard_screen_response_model.dart';

// class LeaderboardController extends GetxController {
//   LeaderboardApi leaderboardApi = LeaderboardApi();

//   var selectedTabIndex = 0.obs;
//   var isLoading = false.obs;

//   LeaderboardScreenResponseModel? leaderboardScreenResponseModel;

//   @override
//   void onInit() {
//     getLeaderboardScreenDetails();
//     super.onInit();
//   }

//   void getLeaderboardScreenDetails() async {
//     isLoading.value = true;
//     var response = await leaderboardApi.getLeaderboardScreenDetails();
//     if (response.code == 200) {
//       leaderboardScreenResponseModel = response;
//       isLoading.value = false;
//     } else {
//       isLoading.value = false;
//       //AppUtils.showSnackBar("${response.message}",title: "", status: MessageStatus.ERROR);
//     }
//   }
// }
