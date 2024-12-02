import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_card_label_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';

class StockWidget extends StatelessWidget {
  InventoryModel? inventoryModel;
  StockWidget({super.key, this.inventoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey.withOpacity(0.2),
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCardLabelWidget(
            backgroundColor: inventoryModel!.inventoryType == 'In'
                ? const Color(0xFF43766C)
                : const Color(0xff740938),
            textLabel: inventoryModel!.inventoryType == 'In'
                ? 'STOCK IN'
                : 'STOCK OUT',
            textLabelColor: inventoryModel!.inventoryType == 'In'
                ? Color(0xFF47663B)
                : Color(0xFFB43F3F),
            trailingText: inventoryModel!.dateFormat,
            bgLabelColor: inventoryModel!.inventoryType == 'In'
                ? const Color(0xffE8ECD7)
                : const Color(0xFFFFE6E6),
          ),
          SizedBox(
            height: 30,
            child: ListTile(
                visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                contentPadding: EdgeInsets.only(top: 0, right: 15, left: 15),
                dense: true,
                title: Text(
                  'Items ',
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(color: Colors.grey.shade600),
                ),
                trailing: Text('Qty',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.grey.shade600))),
          ),
          Divider(
            height: 0,
            thickness: 0.4,
          ),
          ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventoryModel!.items!.length,
              itemBuilder: (context, index) {
                final item = inventoryModel!.items![index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryText(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      leftText: '${item.product?.name}',
                      leftStyle: Theme.of(context).textTheme.bodyMedium,
                      rightText: inventoryModel!.inventoryType == 'In'
                          ? '+ ${item.quantity}'
                          : '- ${item.quantity}',
                      rightStyle: Theme.of(context).textTheme.labelSmall!,
                    ),
                    Visibility(
                      visible: item.note != null && item.note!.isNotEmpty,
                      child: Text(
                        'Note: ${item.note}',
                        style: Get.textTheme.bodySmall!
                            .copyWith(color: Colors.grey.shade600),
                      ),
                    ),
                  ],
                );
              }),
          Visibility(
            visible: inventoryModel!.note != null &&
                inventoryModel!.note!.isNotEmpty,
            child: SummaryText(
              padding: const EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 15,
              ),
              leftText: 'Description ',
              leftStyle: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .copyWith(color: Colors.grey.shade600),
              // rightText: 'Rp ${item.price}',
              rightStyle: Theme.of(context).textTheme.labelSmall!,
            ),
          ),
          Visibility(
            visible: inventoryModel!.note != null &&
                inventoryModel!.note!.isNotEmpty,
            child: Divider(
              height: 0,
              thickness: 0.4,
            ),
          ),
          Visibility(
            visible: inventoryModel!.note != null &&
                inventoryModel!.note!.isNotEmpty,
            child: SummaryText(
                padding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                leftText: inventoryModel!.note,
                leftStyle: Theme.of(context).textTheme.bodyMedium!),
          ),
        ],
      ),
    );
  }
}
