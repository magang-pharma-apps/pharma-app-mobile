import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_adjust_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_card_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/modules/report/views/card_stock_widget.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_widget.dart';

class InventoryTabView extends StatelessWidget {
  const InventoryTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        CardStockWidget(),
        SizedBox(
          height: 40,
          child: ListTile(
            tileColor: Colors.white,
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 15),
            title: Text('Stock Flow Report',
                style: Theme.of(context).textTheme.labelSmall),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  HugeIcons.strokeRoundedSorting05,
                  size: 20,
                )),
          ),
        ),
        Divider(
          height: 0.6,
          thickness: 0.2,
        ),
        ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return const StockWidget();
          },
          itemCount: 7,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
        )
      ],
    );
  }
}
