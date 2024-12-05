import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/report/views/report_view.dart';
import 'package:medpia_mobile/app/modules/home/views/home_view.dart';
import 'package:medpia_mobile/app/modules/master/views/master_view.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_view.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_menu.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_view.dart';

class CoreView extends GetView<CoreController> {
  const CoreView({super.key});

  @override
  get controller => Get.put(CoreController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          HomeView(),
          ReportView(),
          PrescriptionView(),
          // StockView(),
          StockMenu(),
          MasterView(),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          selectedFontSize: 12,
          unselectedFontSize: 10,
          currentIndex: controller.currentPage.value,
          onTap: (value) {
            controller.currentPage.value = value;
            controller.pageController.jumpToPage(value);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(HugeIcons.strokeRoundedHome09),
            ),
            BottomNavigationBarItem(
                label: 'Report',
                icon: Icon(HugeIcons.strokeRoundedAnalyticsUp)),
            BottomNavigationBarItem(
                label: 'Prescription',
                icon: Icon(HugeIcons.strokeRoundedInvoice01)),
            BottomNavigationBarItem(
                label: 'Stock',
                icon: Icon(HugeIcons.strokeRoundedPackageMoving)),
            BottomNavigationBarItem(
                label: 'Master',
                icon: Icon(HugeIcons.strokeRoundedDashboardCircleSettings)),
          ],
        );
      }),
    );
  }
}

class CoreController extends GetxController {
  RxInt currentPage = 0.obs;
  RxList pages = [
    HomeView(),
    ReportView(),
    PrescriptionView(),
    StockView(),
    MasterView(),
  ].obs;
  late PageController pageController =
      PageController(initialPage: currentPage.value);
}
