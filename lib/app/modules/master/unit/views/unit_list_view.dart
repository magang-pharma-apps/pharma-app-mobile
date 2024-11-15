import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_confirm_modal.dart';
import 'package:medpia_mobile/app/modules/master/unit/controllers/unit_list_controller.dart';
import 'package:medpia_mobile/app/modules/master/unit/views/unit_edit_view.dart';
import 'package:medpia_mobile/app/modules/master/unit/views/unit_form_view.dart';

class UnitListView extends GetView<UnitListController> {
  UnitListView({super.key});

  @override
  get controller => Get.put(UnitListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(() => const UnitFormView())?.then((result) {
              if (result == true) {
                controller.getUnits();
              }
            });
          },
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedFirstAidKit,
                  color: Colors.grey.shade700,
                ),
                Text('Create New Unit',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      appBar: AppBar(
        title: Text('Master Unit List'),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: controller.units.length,
              itemBuilder: (context, index) {
                final unit = controller.units[index];
                return ListTile(
                  shape: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(unit.name!),
                  subtitle: Text(unit.description!),
                  onTap: () {
                    Get.to(() => const UnitEditView());
                  },
                  onLongPress: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text(
                              unit.name!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Get.to(const UnitEditView());
                                },
                                child: Text('Edit'),
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
                                              "Delete ${unit.name} permanent from unit?",
                                          buttonText: "Delete",
                                          imageAssetName:
                                              "assets/images/delete-confirm.jpg",
                                          onPressed: () {
                                            controller.deleteUnit(unit.id!);
                                          },
                                        );
                                      });
                                },
                                child: Text('Delete'),
                              ),
                            ],
                          );
                        });
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
