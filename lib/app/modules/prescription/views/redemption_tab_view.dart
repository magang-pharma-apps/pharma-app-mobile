import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_acceptance.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_redemption.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';

class RedemptionTabView extends StatefulWidget {
  const RedemptionTabView({
    super.key,
  });

  @override
  State<RedemptionTabView> createState() => _RedemptionTabViewState();
}

class _RedemptionTabViewState extends State<RedemptionTabView> {
  PrescriptionRepository prescriptionRepository = PrescriptionRepository();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FutureBuilder<List<PrescriptionModel>>(
              future: fetchRedemptions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final redemption = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: CustomExpantiontileRedemption(
                          prescriptionModel: redemption,
                        ),
                      );
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const Center(
                    child: Text('No data found'),
                  );
                }
              }),
        )
      ],
    );
  }

  Future<List<PrescriptionModel>> fetchRedemptions() async {
    try {
      return prescriptionRepository.getRedemptions();
    } catch (e) {
      throw Exception('Failed to fetch redemptions $e');
    }
  }
}
