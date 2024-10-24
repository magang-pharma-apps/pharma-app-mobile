import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/modules/prescription/views/acceptance_tab_view.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_form.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_tab_view.dart';

class PrescriptionList extends StatefulWidget {
  const PrescriptionList({super.key});

  @override
  State<PrescriptionList> createState() => _PrescriptionListState();
}

class _PrescriptionListState extends State<PrescriptionList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrescriptionForm()));
                },
                child: CircleAvatar(
                  backgroundColor: Colors.teal.shade900,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  radius: 20,
                ),
              ),
              SizedBox(height: 5),
              InkWell(
                onTap: () {},
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.teal.shade900,
                  child: Icon(
                    HugeIcons.strokeRoundedMedicine01,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Prescriptions",
            ),
            bottom: const TabBar(tabs: [
              Tab(
                text: "Prescription Acceptance",
              ),
              Tab(
                text: "Prescription Redemption",
              )
            ]),
          ),
          body:
              TabBarView(children: [AcceptanceTabView(), RedemptionTabView()]),
        ),
      ),
    );
  }
}
