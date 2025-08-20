import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gaza_martyer_app/controllers/User/auth_controller.dart';
import 'package:gaza_martyer_app/screens/Admin/Components/side_bar_item.dart';
import 'package:get/get.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.put(AuthController());
    return Container(
      width: 220,
      color: Colors.white,
      child: ListView(
        children: [
          SizedBox(
            height: 100,
            child: Center(
              child: Text(
                "GAZA Martyer",
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Revalia",
                    color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ),
          SideBarItem(
              title: "Dashboard".tr,
              svgPath: "assets/svgs/Category.svg",
              index: 0),
          SideBarItem(
              title: "Stories".tr, svgPath: "assets/svgs/note.svg", index: 1),
          SideBarItem(
              title: "Req. Stories".tr,
              svgPath: "assets/svgs/direct-notification.svg",
              index: 2),
          SideBarItem(
              title: "Add Story".tr,
              svgPath: "assets/svgs/note-favorite.svg",
              index: 3),
          SideBarItem(
              title: "Report".tr, svgPath: "assets/svgs/flag.svg", index: 4),
          SideBarItem(
              title: "Users".tr, svgPath: "assets/svgs/person.svg", index: 5),
          SideBarItem(
              title: "Statistics".tr,
              svgPath: "assets/svgs/Graph.svg",
              index: 6),
          SideBarItem(
              title: "Static Pages".tr,
              svgPath: "assets/svgs/box.svg",
              index: 7),
          Container(
            height: 60,
            child: Center(
              child: ListTile(
                onTap: () {
                  authController.auth.signOut();
                  Get.offAllNamed('/adminLogin');
                },
                leading: SvgPicture.asset("assets/svgs/Logout.svg"),
                title: Text("logout".tr,
                    style: TextStyle(fontSize: 20, color: Colors.red)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
