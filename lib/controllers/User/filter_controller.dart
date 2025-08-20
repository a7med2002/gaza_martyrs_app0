import 'package:gaza_martyer_app/controllers/User/my_search_controller.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterController extends GetxController {
  var selectedGender = <String>[].obs;
  var selectedAgeRange = SfRangeValues(12, 100).obs;

  RxList<String> selectedCities = <String>[].obs;
  var selectedJobs = <String>[].obs;

  var selectedMonth = ''.obs;
  var selectedYear = ''.obs;

  void applyFilter() {
    final mySearchController = Get.find<MySearchController>();
    mySearchController.isFilterApplied.value = true;
    mySearchController.isDone.value = true;
    mySearchController.filterStories();
    Get.back();
    print(selectedGender.toList());
    print(selectedAgeRange.value);
    print(selectedCities.toList());
    print(selectedJobs.toList());
    print(selectedMonth.value);
    print(selectedYear.value);
  }

  void clearAll() {
    selectedGender.clear();
    selectedAgeRange.value = SfRangeValues(17, 33);
    selectedCities.clear();
    selectedJobs.clear();
    selectedMonth.value = '';
    selectedYear.value = '';
  }
}
