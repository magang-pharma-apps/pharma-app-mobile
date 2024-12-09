import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_adjust_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_card_stock_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';

class CardStockWidget extends GetView<StockController> {
  const CardStockWidget({
    super.key,
  });

  @override
  get controller => Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    controller.getInventories(query: {'inventoryType': 'In'});

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
      child: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Card Stock Summary",
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
                leftText: DateFormat('EEEE, d MMM yyyy').format(DateTime.now()),
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
                    ChartCardStockWidget(
                        title: '${controller.products.length} drugs',
                        subTitle: 'Available Stock'),
                    ChartCardStockWidget(
                      title: '${controller.stockOutList.length} drugs',
                      subTitle: 'Out of Stock',
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
                  CardAdjustStockWidget(
                      title:
                          '${controller.stockInList.length.toString()} drugs',
                      subtitle: 'Stock In'),
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
                            "Drug Expiry",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                          ),
                          Icon(
                            HugeIcons.strokeRoundedClock04,
                            color: Colors.yellow.shade50,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
