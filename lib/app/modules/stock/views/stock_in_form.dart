import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

class StockInForm extends StatelessWidget {
  const StockInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(Get.width, 50),
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
              onPressed: () {},
              child: Text('Save')),
        ],
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'Stock In Form',
            style: Theme.of(context).textTheme.labelMedium,
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          height: Get.height * 0.8,
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  readOnly: true,

                  // controller: controller.expiryDateController,
                  decoration: const InputDecoration(
                      hintText: 'Select Date',
                      labelText: 'Date',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedCalendar02,
                        color: Colors.black,
                      )),
                  // onTap: controller.pickExpireDate,
                  // onChanged: (value) {
                  //   controller.expiryDate = value;
                  // },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: TextFormField(
                  decoration: const InputDecoration(
                      labelText: 'Note',
                      hintText: 'Write a note',
                      suffixIcon: Icon(
                        HugeIcons.strokeRoundedStickyNote02,
                        size: 20,
                        color: Colors.black,
                      )),
                  // onChanged: (value) {
                  //   controller.supplierName = value;
                  // },
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    decoration: const InputDecoration(
                        labelText: 'Product',
                        hintText: 'Choose Product',
                        suffixIcon: Icon(
                          HugeIcons.strokeRoundedPackageSearch,
                          size: 20,
                          color: Colors.black,
                        )),
                    // onChanged: (value) {
                    //   controller.itemName = value;
                    // },
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Add Other Product",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Colors.teal.shade700,
                                    fontWeight: FontWeight.bold)),
                        Icon(
                          Icons.add,
                          color: Colors.teal.shade700,
                          size: 20,
                        ),
                      ],
                    )),
              ),
              Center(
                  child: Image.asset('assets/images/instock.jpg',
                      height: 300, width: 300)),
            ],
          ),
        ));
  }
}
