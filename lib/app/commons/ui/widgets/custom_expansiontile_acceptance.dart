import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_form.dart';

String getPrescriptionStatus(bool status) {
  switch (status) {
    case true:
      return 'Redeemed';
    default:
      return 'Unreedemed';
  }
}

class CustomExpansiontileAcceptance extends StatefulWidget {
  VoidCallback? onNavigateToRedeemPage;
  PrescriptionModel? prescriptionModel;
  CustomExpansiontileAcceptance(
      {super.key, this.onNavigateToRedeemPage, this.prescriptionModel});

  @override
  State<CustomExpansiontileAcceptance> createState() =>
      _CustomExpansiontileAcceptanceState();
}

class _CustomExpansiontileAcceptanceState
    extends State<CustomExpansiontileAcceptance>
    with SingleTickerProviderStateMixin {
  bool isExpanded = false;
  late AnimationController _controller;
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    // DateTime date =
    DateTime parsedDate =
        DateTime.parse(widget.prescriptionModel!.prescriptionDate!);
    String formattedPrescriptionDate =
        DateFormat('dd/MM/yyyy hh:mm:ss a').format(parsedDate);

    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              Builder(builder: (context) {
                return ExpansionTile(
                  onExpansionChanged: (value) => setState(() {
                    isExpanded = value;
                    if (isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  }),
                  controller: _expansionTileController,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  clipBehavior: Clip.none,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  tilePadding: EdgeInsets.only(left: 15),
                  childrenPadding: EdgeInsets.zero,
                  title: Text(
                    formattedPrescriptionDate,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.teal),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prescription Number: #${widget.prescriptionModel!.prescriptionCode!}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Colors.teal.shade800,
                                fontWeight: FontWeight.bold),
                      ),
                      Text("Pt. ${widget.prescriptionModel!.customer!.name!}",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: Colors.teal.shade900,
                                  )),
                    ],
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: widget.prescriptionModel!.isRedeem! == false
                            ? Colors.amber.shade50
                            : Colors.red.shade50),
                    child: Text(
                      getPrescriptionStatus(
                          widget.prescriptionModel!.isRedeem!),
                      style: widget.prescriptionModel!.isRedeem! == false
                          ? TextStyle(color: Colors.orange)
                          : TextStyle(color: Colors.red.shade400),
                    ),
                  ),
                  children: [
                    ListTile(
                      titleTextStyle: Theme.of(context).textTheme.labelMedium!,
                      title: Text(
                        'Prescriptions',
                      ),
                      subtitle: Text(
                        widget.prescriptionModel!.prescriptions!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.teal.shade900),
                      ),
                    ),
                    ListTile(
                      titleTextStyle: Theme.of(context).textTheme.labelMedium,
                      dense: true,
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Pasien'),
                          Text('Usia'),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            widget.prescriptionModel!.customer!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.teal.shade900),
                          ),
                          Text(
                            widget.prescriptionModel!.customer!.age!.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.teal.shade900),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      titleTextStyle: Theme.of(context).textTheme.labelMedium!,
                      title: Text(
                        "Doctor",
                      ),
                      trailing: Text(
                        widget.prescriptionModel!.doctor!.name!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(color: Colors.teal.shade900),
                      ),
                    )
                  ],
                );
              }),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: ListTile(
                  visualDensity:
                      VisualDensity(horizontal: -4.0, vertical: -4.0),
                  contentPadding: EdgeInsets.symmetric(horizontal: 5),
                  trailing: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.deepPurple,
                        visualDensity:
                            VisualDensity(horizontal: -3.0, vertical: -3),
                      ),
                      onPressed: widget.prescriptionModel!.isRedeem! == true
                          ? null
                          : () {
                              widget.onNavigateToRedeemPage!();
                            },
                      child: Text(
                        "Redeem Prescription",
                        style: TextStyle(fontSize: 11),
                      )),
                ),
              )
            ]),
          ),
          Positioned(
            bottom: -15,
            child: RotationTransition(
              turns: Tween<double>(begin: 0, end: 0.5).animate(CurvedAnimation(
                  parent: _controller, curve: Curves.elasticInOut)),
              child: InkWell(
                onTap: () {
                  if (isExpanded == true) {
                    _expansionTileController.expand();
                  } else {
                    _expansionTileController.collapse();
                  }
                },
                child: const CircleAvatar(
                  backgroundColor: Colors.teal,
                  radius: 12,
                  child: Center(
                    child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          )
        ]);
  }
}
