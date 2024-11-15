import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_confirm_modal.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/modules/master/customer/controllers/customer_list_controller.dart';
import 'package:medpia_mobile/app/modules/master/customer/views/customer_edit_view.dart';
import 'package:medpia_mobile/app/modules/master/customer/views/customer_form_view.dart';
import 'package:medpia_mobile/app/repositories/customer_repository.dart';

class CustomerListView extends GetView<CustomerListController> {
  const CustomerListView({super.key});

  @override
  get controller => Get.put(CustomerListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(const CustomerFormView())?.then((value) {
              if (value != null && value) {
                controller.getCustomers();
              }
            });
          },
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedUserAdd01,
                  color: Colors.grey.shade700,
                ),
                Text('Add Patient',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Master Customer',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              final customer = controller.customers[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border:
                      Border.all(color: Colors.blueGrey.shade100, width: 0.5),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.teal.shade50,
                    foregroundColor: Colors.teal.shade700,
                    child: Icon(
                      HugeIcons.strokeRoundedMedicalMask,
                    ),
                  ),
                  contentPadding: const EdgeInsets.only(left: 15, bottom: 5),
                  visualDensity: VisualDensity.compact,
                  title: Text(
                    '${customer.name!} (${customer.age})',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  subtitle: Text(
                    '${customer.address}',
                    maxLines: 1,
                  ),
                  onTap: () {
                    Get.to(CustomerEditView());
                  },
                  onLongPress: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text(
                              customer.name!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Get.to(CustomerEditView());
                                },
                                child: const Text('Edit'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  int count = 0;
                                  Get.until((route) {
                                    count++;
                                    return count ==
                                        2; // Stop after going back two pages
                                  });
                                  showModalBottomSheet(
                                      constraints: const BoxConstraints(
                                          minHeight: 270, maxHeight: 270),
                                      context: context,
                                      builder: (context) {
                                        return CustomConfirmModal(
                                          customTitle:
                                              "Delete ${customer.name} permanent from customer?",
                                          buttonText: "Delete",
                                          imageAssetName:
                                              "assets/images/delete-confirm.jpg",
                                          onPressed: () {
                                            controller.deleteCustomer(customer.id!);
                                          },
                                        );
                                      });
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          );
                        });
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}
