import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_card_label_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';

class StockWidget extends StatelessWidget {
  const StockWidget({
    super.key,
  });

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
            textLabel: 'STOCK IN',
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
          SummaryText(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            leftText: 'Paracetamol ',
            leftStyle: Theme.of(context).textTheme.bodyMedium,
            rightText: '+10',
            rightStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          SummaryText(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            leftText: 'Amoxilin ',
            leftStyle: Theme.of(context).textTheme.bodyMedium,
            rightText: '+10',
            rightStyle: Theme.of(context).textTheme.labelSmall!,
          ),
        ],
      ),
    );
  }
}
