import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/doctor/controllers/doctor_list_controller.dart';
import 'package:medpia_mobile/app/modules/master/doctor/views/doctor_edit_view.dart';
import 'package:medpia_mobile/app/modules/master/doctor/views/doctor_form_view.dart';

class DoctorListView extends GetView<DoctorListController> {
  const DoctorListView({super.key});

  @override
  get controller => Get.put(DoctorListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {
            Get.to(const DoctorFormView())?.then((value) {
              if (value != null && value) {
                controller.getDoctors();
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
                Text('Create Doctor',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Master Doctor',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            itemCount: controller.doctors.length,
            itemBuilder: (context, index) {
              final doctor = controller.doctors[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: Colors.blueGrey.shade100, width: 0.5),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(left: 10),
                  visualDensity: VisualDensity.compact,
                  leading: CircleAvatar(
                    backgroundColor: Colors.blueGrey.shade50,
                    foregroundColor: Colors.blue.shade800,
                    child: Icon(
                      HugeIcons.strokeRoundedDoctor02,
                    ),
                  ),
                  title: Text(doctor.name!),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${doctor.specialization}',
                        maxLines: 1,
                      ),
                      Text('Phone Number: ${doctor.phoneNumber}', maxLines: 1),
                      Text('Email: ${doctor.email}', maxLines: 1),
                    ],
                  ),
                  onTap: () {
                    Get.to(DoctorEditView());
                  },
                  onLongPress: () {
                    showCupertinoModalPopup(
                        context: context,
                        builder: (context) {
                          return CupertinoActionSheet(
                            title: Text(
                              doctor.name!,
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            actions: [
                              CupertinoActionSheetAction(
                                onPressed: () {
                                  Get.to(DoctorEditView());
                                },
                                child: Text('Edit'),
                              ),
                              CupertinoActionSheetAction(
                                onPressed: () {},
                                child: Text('Delete'),
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
