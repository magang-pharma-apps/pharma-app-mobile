import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_card_label_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/modal_inventory_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_widget.dart';

class StockView extends StatelessWidget {
  const StockView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) => ModalInventoryWidget());
        },
        child: Icon(
          HugeIcons.strokeRoundedPlusSign,
          size: 20,
          color: Colors.white,
        ),
        backgroundColor: Colors.teal.shade900,
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Stock Inventories',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: 15),
        children: [
          SizedBox(
            height: 40,
            child: ListTile(
              dense: true,
              contentPadding: EdgeInsets.all(0),
              title: Text('History Stock Inventories',
                  style: Theme.of(context).textTheme.labelSmall),
              trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    HugeIcons.strokeRoundedSorting05,
                    size: 20,
                  )),
            ),
          ),
          StockWidget(),
          StockWidget(),
          Container(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCardLabelWidget(
                  textLabel: 'STOCK OUT',
                  textLabelColor: Color(0xFFB43F3F),
                  bgLabelColor: Color(0xFFFFE6E6),
                  backgroundColor: Color(0xff740938),
                ),
                SizedBox(
                  height: 40,
                  child: ListTile(
                      contentPadding:
                          EdgeInsets.only(top: 5, right: 15, left: 15),
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
                  rightText: '-10',
                  rightStyle: Theme.of(context).textTheme.labelSmall!,
                ),
                SummaryText(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  leftText: 'Amoxilin ',
                  leftStyle: Theme.of(context).textTheme.bodyMedium,
                  rightText: '-10',
                  rightStyle: Theme.of(context).textTheme.labelSmall!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
