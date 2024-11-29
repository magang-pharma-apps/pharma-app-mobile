import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_confirm_modal.dart';
import 'package:medpia_mobile/app/modules/auth/views/auth_view.dart';
import 'package:medpia_mobile/app/modules/master/category/views/category_list_view.dart';
import 'package:medpia_mobile/app/modules/master/customer/views/customer_list_view.dart';
import 'package:medpia_mobile/app/modules/master/doctor/views/doctor_list_view.dart';
import 'package:medpia_mobile/app/modules/master/product/views/product_list_view.dart';
import 'package:medpia_mobile/app/modules/master/profile/controllers/profile_controller.dart';
import 'package:medpia_mobile/app/modules/master/unit/views/unit_list_view.dart';

class MasterView extends GetView<ProfileController> {
  const MasterView({super.key});

  @override
  get controller => Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Manage Master',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(fontSize: 16)),
          actions: [
            IconButton(
              padding: EdgeInsets.symmetric(horizontal: 25),
              onPressed: () {
                showModalBottomSheet(
                    constraints: BoxConstraints(minHeight: 250, maxHeight: 250),
                    context: context,
                    builder: (context) {
                      return CustomConfirmModal(
                        customTitle: 'Are you sure want to logout?',
                        imageAssetName: "assets/images/logout.jpg",
                        buttonText: "Log Out",
                        onPressed: () {
                          Get.to(() => const AuthView());

                          GetStorage().remove('token');
                          GetStorage().remove('username');
                          GetStorage().write('isLogin', false);
                        },
                      );
                    });
              },
              icon: const Icon(
                HugeIcons.strokeRoundedLogout01,
                color: Colors.teal,
              ),
            )
          ],
        ),
        body: ListView(
          children: [
            ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage("assets/images/user.png"),
                ),
                title: Text(
                  controller.profile.value.username ?? 'John Doe',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                subtitle: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.profile.value.email ?? 'johndoe@mail.com',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey.shade700),
                        ),
                        Text(
                          "Role as ${controller.profile.value.role ?? 'role'}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.grey.shade700),
                        ),
                      ],
                    );
                })),
            ListTile(
              leading: const Icon(
                HugeIcons.strokeRoundedMedicineBottle01,
                color: Colors.blueGrey,
              ),
              title: Text(
                'Products',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.to(ProductListView());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: const Icon(
                HugeIcons.strokeRoundedMedicine02,
                color: Colors.deepOrange,
              ),
              title: Text(
                'Units',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.to(UnitListView());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: const Icon(
                HugeIcons.strokeRoundedFirstAidKit,
                color: Colors.deepPurple,
              ),
              title: Text(
                'Categories',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.to(CategoryListView());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: Icon(
                HugeIcons.strokeRoundedDoctor03,
                color: Colors.blue.shade700,
              ),
              title: Text(
                'Doctors',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.to(const DoctorListView());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: const Icon(
                HugeIcons.strokeRoundedPatient,
                color: Colors.green,
              ),
              title: Text(
                'Patients',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {
                Get.to(CustomerListView());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
          ],
        ));
  }
}
