import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_acceptance.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/acceptance_tab_view.dart';
import 'package:medpia_mobile/app/modules/prescription/views/prescription_form.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_tab_view.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';

class PrescriptionScreen extends StatefulWidget {
  const PrescriptionScreen({super.key});

  @override
  State<PrescriptionScreen> createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {
  PrescriptionRepository prescriptionRepository = PrescriptionRepository();


  
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
                onTap: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ListTile(
                                      title: const Text(
                                        'Prescription Redemption',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: IconButton(
                                          icon: Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }),
                                    )),
                                const CustomLineWidget(),
                                ListTile(
                                  title: const Text('Pilih Resep :'),
                                  subtitle: TextFormField(
                                    decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                          },
                                        ),
                                        hintText:
                                            'Search by Prescription Number',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: Colors.black))),
                                  ),
                                ),
                                
                                ElevatedButton(
                                  child: const Text('Redeem Prescription'),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
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

  Future<List<PrescriptionModel>> fetchPrescription() async {
    try {
      return prescriptionRepository.getPrescriptions();
    } catch (e) {
      throw Exception("Error load prescriotion data $e");
    }
  }
}
