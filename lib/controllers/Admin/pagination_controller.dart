import 'package:gaza_martyer_app/models/martyer_model.dart';
import 'package:get/get.dart';

class PaginationController extends GetxController {

  final allItems = <MartyerModel>[].obs;

  // المتغيرات
  final currentPage = 1.obs;
  final itemsPerPage = 5;

  // احسب عدد الصفحات
  int get totalPages => (allItems.length / itemsPerPage).ceil();

  // العناصر التي ستُعرض حاليًا
  List<MartyerModel> get pagedItems {
    final start = (currentPage.value - 1) * itemsPerPage;
    final end = start + itemsPerPage;
    return allItems.sublist(start, end > allItems.length ? allItems.length : end);
  }

  void goToPage(int page) {
    if (page >= 1 && page <= totalPages) {
      currentPage.value = page;
    }
  }

  void nextPage() => goToPage(currentPage.value + 1);
  void prevPage() => goToPage(currentPage.value - 1);
}