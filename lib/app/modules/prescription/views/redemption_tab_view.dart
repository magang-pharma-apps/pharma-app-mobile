import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_acceptance.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_expansiontile_redemption.dart';

class RedemptionTabView extends StatelessWidget {
  const RedemptionTabView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomExpantiontileRedemption(),
              );
            },
            scrollDirection: Axis.vertical,
            itemCount: 10,
          ),
        )
      ],
    );
  }
}
