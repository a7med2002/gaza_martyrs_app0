import 'package:flutter/material.dart';
import 'package:gaza_martyer_app/controllers/Admin/pagination_controller.dart';
import 'package:get/get.dart';

class Pagination extends StatelessWidget {
  const Pagination({super.key});

  @override
  Widget build(BuildContext context) {
    PaginationController paginationController = Get.put(PaginationController());
    return Obx(() {
      final currentPage = paginationController.currentPage.value;
      final totalPages = paginationController.totalPages;

      List<Widget> pageButtons = [];

      // ⬅️ Prev
      pageButtons.add(IconButton(
        icon: Icon(Icons.chevron_left),
        onPressed: currentPage > 1 ? paginationController.prevPage : null,
      ));

      // Always show first few pages
      for (int i = 1; i <= totalPages; i++) {
        // 1-4 + current + last
        if (i == 1 ||
            i == totalPages ||
            (i >= currentPage - 1 && i <= currentPage + 1) ||
            i <= 4) {
          pageButtons.add(
              _buildPageButton(context, i, currentPage, paginationController));
        } else if (i == 5 && currentPage < totalPages - 3) {
          pageButtons.add(Text("..."));
        } else if (i == totalPages - 1 && currentPage < totalPages - 3) {
          // skip middle pages
          continue;
        }
      }

      // ➡️ Next
      pageButtons.add(IconButton(
        icon: Icon(Icons.chevron_right),
        onPressed:
            currentPage < totalPages ? paginationController.nextPage : null,
      ));

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: pageButtons,
      );
    });
  }
}


Widget _buildPageButton(BuildContext context, int page, int currentPage,
    PaginationController controller) {
  final isActive = page == currentPage;
  return Padding(
    padding: const EdgeInsets.all(4),
    child: TextButton(
      onPressed: () => controller.goToPage(page),
      style: TextButton.styleFrom(
        backgroundColor:
            isActive ? Theme.of(context).colorScheme.primary : Colors.white,
        foregroundColor:
            isActive ? Colors.white : Theme.of(context).colorScheme.secondary,
        shape: RoundedRectangleBorder(
          side:
              BorderSide(color: Theme.of(context).colorScheme.primaryContainer),
        ),
      ),
      child: Text('$page'),
    ),
  );
}

