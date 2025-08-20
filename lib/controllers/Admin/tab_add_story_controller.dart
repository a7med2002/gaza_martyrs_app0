import 'package:get/get.dart';

class TabAddStoryController extends GetxController {
  RxInt selectedTabIndex = 0.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
