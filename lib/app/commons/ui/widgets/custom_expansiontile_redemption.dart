import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/prescription_model.dart';

class CustomExpantiontileRedemption extends StatefulWidget {
  PrescriptionModel? prescriptionModel;
  CustomExpantiontileRedemption({super.key, this.prescriptionModel});

  @override
  State<CustomExpantiontileRedemption> createState() =>
      _CustomExpantiontileRedemptionState();
}

class _CustomExpantiontileRedemptionState
    extends State<CustomExpantiontileRedemption>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
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
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.prescriptionModel!.cart != null
        ? widget.prescriptionModel!.cartItems
        : [];
    DateTime parsedDate =
        DateTime.parse(widget.prescriptionModel!.transactionDate!);
    String formattedTransactionDate =
        DateFormat('MM/dd/yyyy hh:mm a').format(parsedDate);

    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ExpansionTile(
                  onExpansionChanged: (value) => setState(() {
                    _isExpanded = value;
                    if (_isExpanded) {
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
                    formattedTransactionDate,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.teal),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Prescription Number #${widget.prescriptionModel!.prescriptionCode}",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color: Colors.teal.shade800,
                                fontWeight: FontWeight.bold),
                      ),
                      Text("Pt. ${widget.prescriptionModel!.patient}",
                          style:
                              Theme.of(context).textTheme.labelMedium!.copyWith(
                                    color: const Color.fromARGB(255, 1, 67, 59),
                                  )),
                    ],
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade100),
                    child: Text(
                      widget.prescriptionModel!.isPaid == true
                          ? 'Closed'
                          : 'Open',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Products",
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: items!.length,
                              itemBuilder: (context, index) {
                                final item = items[index] as CartItemModel;

                                return SummaryText(
                                  leftText: item.productLabel,
                                  rightText: item.totalPrice,
                                );
                              }),
                        ],
                      ),
                    ),
                    SummaryText(
                      leftText: 'Patient Name',
                      rightText: widget.prescriptionModel!.patient,
                      leftStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SummaryText(
                        leftText: 'Age',
                        rightText: widget.prescriptionModel!.customer!.age!
                            .toString()),
                    SizedBox(height: 10),
                    SummaryText(
                      leftText: 'Doctor',
                      rightText: widget.prescriptionModel!.doctorName,
                      leftStyle: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SummaryText(
                      leftText: 'Subtotal',
                      rightText: widget.prescriptionModel!.subtotalFormatted,
                    ),
                    SummaryText(
                      leftText: 'Tax (10%)',
                      rightText: widget.prescriptionModel!.taxFormatted,
                    ),
                    SizedBox(height: 10)
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: SummaryText(
                      leftText: "Nominal",
                      leftStyle: TextStyle(
                        color: Colors.teal.shade800,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      rightText: widget.prescriptionModel!.grandtotalFormatted,
                      rightStyle: TextStyle(
                          color: Colors.teal.shade800,
                          fontSize: 13,
                          fontWeight: FontWeight.bold)),
                )
              ],
            ),
          ),
          Positioned(
              bottom: -15,
              child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 0.5).animate(
                    CurvedAnimation(
                        parent: _controller, curve: Curves.elasticInOut)),
                child: InkWell(
                  onTap: () {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _expansionTileController.expand();
                      ExpansionTileController.of(context).expand();
                    } else {
                      _expansionTileController.collapse();
                      ExpansionTileController.of(context).collapse();
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
                    )),
                  ),
                ),
              ))
        ]);
  }
}
