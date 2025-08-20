import 'package:gaza_martyer_app/controllers/User/filter_controller.dart';
import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:get/get.dart';

class MySearchController extends GetxController {
  RxString searchText = ''.obs;
  RxList<MartyerModel> filteredStories = <MartyerModel>[].obs;
  RxList<MartyerModel> recentSearch = <MartyerModel>[].obs;
  RxBool isFocusSearch = false.obs;
  RxBool isDone = false.obs;

  List<MartyerModel> allStories = [];

  FilterController filterController = Get.put(FilterController());
  RxBool isFilterApplied = false.obs; // لتحديد إذا كان الفلتر مفعل

  void filterStories() {
    var result = allStories;

    // فلترة بالاسم إذا المستخدم كتب إشي
    if (searchText.value.trim().isNotEmpty) {
      final nameFilter = searchText.value.toLowerCase();
      result = result.where((story) {
        final fullName = "${story.firstName} ${story.lastName}".toLowerCase();
        return fullName.contains(nameFilter);
      }).toList();
    }

    // فلترة إضافية لو الفلتر مفعل
    if (isFilterApplied.value) {
      result = result.where((story) {
        final age =
            int.tryParse(story.martyerAge) ?? -1; // إذا العمر غير صالح -1

        final genderOk = filterController.selectedGender.isEmpty ||
            filterController.selectedGender.any((g) =>
                g.trim().toLowerCase() ==
                story.martyerGender.trim().toLowerCase());

        final ageOk = (age == -1) || // إذا العمر غير صالح نتجاوز الفلترة عليه
            (age >= filterController.selectedAgeRange.value.start &&
                age <= filterController.selectedAgeRange.value.end);

        final cityOk = filterController.selectedCities.isEmpty ||
            filterController.selectedCities.any((city) =>
                city.trim().toLowerCase() ==
                story.martyerCity.trim().toLowerCase());

        final jobOk = filterController.selectedJobs.isEmpty ||
            filterController.selectedJobs.any((job) =>
                job.trim().toLowerCase() ==
                story.jobMartyer.trim().toLowerCase());

        final monthOk = filterController.selectedMonth.value.isEmpty ||
            filterController.selectedMonth.value.trim().toLowerCase() ==
                story.monthMartyer.trim().toLowerCase();

        final yearOk = filterController.selectedYear.value.isEmpty ||
            filterController.selectedYear.value.trim().toLowerCase() ==
                story.yearMartyer.trim().toLowerCase();

        return genderOk && ageOk && cityOk && jobOk && monthOk && yearOk;
      }).toList();
    }

    filteredStories.value = result;
  }

  // void filterStories() {
  //   if (searchText.value.isEmpty) {
  //     filteredStories.clear();
  //   } else {
  //     filteredStories.value = allStories.where((story) {
  //       final fullName = "${story.firstName} ${story.lastName}";
  //       return fullName.toLowerCase().contains(searchText.value.toLowerCase());
  //     }).toList();
  //   }
  // }

  void addToRecent(MartyerModel story) {
    if (!recentSearch.any((s) => s.id == story.id)) {
      recentSearch.insert(0, story);
      if (recentSearch.length > 10) {
        recentSearch.removeLast();
      }
    }
  }

  @override
  void onInit() {
    ever(searchText, (callback) => filterStories());
    super.onInit();
  }
}
