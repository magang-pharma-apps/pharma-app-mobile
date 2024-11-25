import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_adjust_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_card_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';

class CardStockWidget extends StatelessWidget {
  const CardStockWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white70,
        boxShadow: [
          BoxShadow(
              color: Colors.blueGrey.withOpacity(0.2),
              blurRadius: 5,
              offset: Offset(0, 3))
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Card Stock",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Icon(
                HugeIcons.strokeRoundedLayers02,
                size: 20,
              )
            ],
          ),
          SummaryText(
            padding: EdgeInsets.zero,
            leftText: 'Monday, 18 Nov 2024',
            leftStyle: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade700),
          ),
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ChartCardStockWidget(title: '20', subTitle: 'In Stock'),
                ChartCardStockWidget(
                  title: '100',
                  subTitle: 'Out Stock',
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      begin: Alignment(0, -1),
                      end: Alignment(1, 1),
                      colors: [Color(4294867711), Color(4289206210)],
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CardAdjustStockWidget(),
              InkWell(
                onTap: () {},
                splashColor: Colors.black,
                child: Container(
                  height: 50,
                  width: 207,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(top: 5, left: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: const Color.fromARGB(255, 139, 122, 96)
                              .withOpacity(0.2),
                          blurRadius: 5,
                          offset: Offset(0, 7))
                    ],
                    gradient: LinearGradient(
                      begin: Alignment(1, -1),
                      end: Alignment(-1, 1),
                      colors: [Color(4294495335), Color(4294602006)],
                      stops: null,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "View Analytics  ",
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            ),
                      ),
                      Icon(
                        Icons.align_horizontal_left_sharp,
                        color: Colors.cyan.shade600,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
