import 'package:get/get.dart';
import 'package:task_26/model/profile_model.dart';
import 'package:task_26/service/profile_service.dart';

class ProfileController extends GetxController {
  final ProfileService _profileService = ProfileService();

  /// store the profile data to this to show in the ui
  Rxn<ProfileModel> profileData = Rxn(null);
  RxBool isLoading = RxBool(false);

  /// here i use to give the demo 1 to fetch otherwise i can give the profileId from the ui screen then get the profile for the specific profileId
  Future<void> getProfileDetails() async {
    isLoading.value = true;

    final response = await _profileService.fetchProfileDetails(1);
    if (response != null) {
      isLoading.value = false;
      profileData.value = response;
    } else {
      isLoading.value = false;
      Get.snackbar('Error fetching data', 'Please try again');
    }
  }

  @override
  void onInit() {
    getProfileDetails();
    super.onInit();
  }
}
