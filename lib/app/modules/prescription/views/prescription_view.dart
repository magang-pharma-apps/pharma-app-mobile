import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/acceptance_tab_view.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_form.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_tab_view.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';

class PrescriptionView extends StatefulWidget {
  const PrescriptionView({super.key});

  @override
  State<PrescriptionView> createState() => _PrescriptionViewState();
}

class _PrescriptionViewState extends State<PrescriptionView>
    with SingleTickerProviderStateMixin {
  late final tabBarController;
  PrescriptionRepository prescriptionRepository = PrescriptionRepository();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          mini: true,
          onPressed: () {
            navigateToCreatePage();
          },
          backgroundColor: Colors.teal.shade900,
          child: const Icon(
            HugeIcons.strokeRoundedPlusSign,
            size: 20,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          titleTextStyle: TextStyle(fontSize: 16, color: Colors.black),
          title: const Text(
            "Prescriptions",
          ),
          bottom: TabBar(
              controller: tabBarController,
              labelStyle: TextStyle(fontSize: 12),
              tabs: [
                Tab(
                  text: "Prescription Acceptance",
                ),
                Tab(
                  text: "Prescription Redemption",
                )
              ]),
        ),
        body: TabBarView(controller: tabBarController, children: [
          AcceptanceTabView(tabBarContoller: tabBarController),
          RedemptionTabView()
        ]),
      ),
    );
  }

  Future<List<PrescriptionModel>> fetchPrescription() async {
    try {
      return prescriptionRepository.getPrescriptions();
    } catch (e) {
      throw Exception("Error load prescriotion data $e");
    }
  }

  Future<void> navigateToCreatePage() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => PrescriptionForm()));

    if (result == true) {
      setState(() {
        fetchPrescription();
      });
    }
  }
}
