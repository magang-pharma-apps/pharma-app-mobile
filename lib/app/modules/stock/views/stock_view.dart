import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/modal_inventory_widget.dart';
import 'package:medpia_mobile/app/modules/stock/controllers/stock_controller.dart';
import 'package:medpia_mobile/app/modules/stock/views/stock_widget.dart';

class StockView extends GetView<StockController> {
  const StockView({super.key});

  @override
  get controller => Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => ModalInventoryWidget());
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
        forceMaterialTransparency: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          titlePadding: EdgeInsets.all(10),
                          title: Text('Search'),
                          content: SearchBar()
                        ));
              },
              icon: Icon(
                HugeIcons.strokeRoundedSearchArea,
                size: 20,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                HugeIcons.strokeRoundedFilter,
                size: 20,
                color: Colors.black,
              )),
        ],
        title: Text(
          'Stock Inventories',
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (controller.inventoryList.isEmpty) {
          return Center(
            child: Image.asset(
              'assets/images/20946001.jpg',
              semanticLabel: 'Stock still blank',
            ),
          );
        } else {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: controller.inventoryList.length,
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              itemBuilder: (context, index) {
                // print('iventoryList: ${controller.inventoryList.length}');
                final inventory = controller.inventoryList[index];
                return StockWidget(inventoryModel: inventory);
              });
        }
      }),
    );
  }
}
