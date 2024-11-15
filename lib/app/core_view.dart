import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/cart/views/payment_success_view.dart';
import 'package:medpia_mobile/app/modules/report/views/report_view.dart';
import 'package:medpia_mobile/app/modules/home/views/home_view.dart';
import 'package:medpia_mobile/app/modules/master/views/master_view.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_view.dart';

class CoreView extends StatefulWidget {
  const CoreView({super.key});

  @override
  State<CoreView> createState() => _CoreViewState();
}

class _CoreViewState extends State<CoreView> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: const [
          HomeView(),
          ReportView(),
          PrescriptionView(),
          MasterView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(HugeIcons.strokeRoundedHome09),
          ),
          BottomNavigationBarItem(
              label: 'Report', icon: Icon(HugeIcons.strokeRoundedAnalyticsUp)),
          BottomNavigationBarItem(
              label: 'Prescription',
              icon: Icon(HugeIcons.strokeRoundedInvoice01)),
          BottomNavigationBarItem(
              label: 'Master',
              icon: Icon(HugeIcons.strokeRoundedDashboardCircleSettings)),
         
        ],
      ),
    );
  }
}
