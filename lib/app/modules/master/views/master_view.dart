import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/master/views/master_category_list.dart';
import 'package:medpia_mobile/app/modules/master/views/master_customer_list.dart';
import 'package:medpia_mobile/app/modules/master/views/master_doctor_list.dart';
import 'package:medpia_mobile/app/modules/master/views/master_product_list.dart';
import 'package:medpia_mobile/app/modules/master/views/master_unit_list.dart';

class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Manage Master',
              style: Theme.of(context).textTheme.labelLarge),
        ),
        body: ListView(
          children: [
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
                Get.to(MasterProductList());
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
                Get.to(MasterUnitList());
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
                Get.to(MasterCategoryList());
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
                Get.to(MasterDoctorList());
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
                Get.to(MasterCustomerList());
              },
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 15,
                color: Colors.grey,
              ),
            ),
            ListTile(
              leading: const Icon(
                HugeIcons.strokeRoundedUser,
                color: Colors.lightBlue,
              ),
              title: Text(
                'Users',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              onTap: () {},
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
