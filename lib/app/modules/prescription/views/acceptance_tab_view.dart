import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_acceptance.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';

class AcceptanceTabView extends StatefulWidget {
  const AcceptanceTabView({
    super.key,
  });

  @override
  State<AcceptanceTabView> createState() => _AcceptanceTabViewState();
}

class _AcceptanceTabViewState extends State<AcceptanceTabView> {
  PrescriptionRepository prescriptionRepository = PrescriptionRepository();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FutureBuilder<List<PrescriptionModel>>(
            future: fetchPrescription(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final prescription = snapshot.data![index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomExpansiontileAcceptance(
                        prescriptionModel: prescription,
                      ),
                    );
                  },
                  itemCount: snapshot.data!.length,
                );
              } else {
                return Center(
                  child: Text('No data found'),
                );
              }
            },
          ),
        )
      ],
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
