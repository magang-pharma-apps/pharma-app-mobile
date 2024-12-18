import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medpia_mobile/app/modules/report/controllers/report_controller.dart';
import 'package:medpia_mobile/app/modules/report/views/report_transaction_widget.dart';

class TransactionTabView extends GetView<ReportController> {
  const TransactionTabView({super.key});

  @override
  get controller => Get.put(ReportController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return ListView.builder(
          itemBuilder: (context, index) {
            // print('count : ${controller.transactionList.length}');
            final transaction = controller.transactionList[index];
            return ReportTransactionWidget(
              cartModel: transaction,
            );
          },
          itemCount: controller.transactionList.length,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          shrinkWrap: true,
        );
      }
    });
  }
}
