import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_card_label_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/models/inventory_model.dart';

class StockWidget extends StatelessWidget {
  InventoryModel? inventoryModel;
  StockWidget({super.key, this.inventoryModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
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
            textLabel: inventoryModel!.inventoryType == 'In'
                ? 'STOCK IN'
                : 'STOCK OUT',
            trailingText: inventoryModel!.dateFormat,
          ),
          SizedBox(
            height: 40,
            child: ListTile(
                contentPadding: EdgeInsets.only(top: 5, right: 15, left: 15),
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: inventoryModel!.items!.length,
              itemBuilder: (context, index) {
                final item = inventoryModel!.items![index];
                return SummaryText(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  leftText: '${item.product?.name}',
                  leftStyle: Theme.of(context).textTheme.bodyMedium,
                  rightText: '+ ${item.quantity}',
                  rightStyle: Theme.of(context).textTheme.labelSmall!,
                );
              }),
        ],
      ),
    );
  }
}
