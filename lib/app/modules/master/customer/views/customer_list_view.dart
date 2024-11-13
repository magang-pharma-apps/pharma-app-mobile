import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/modules/master/customer/views/customer_edit_view.dart';
import 'package:medpia_mobile/app/repositories/customer_repository.dart';

class CustomerListView extends StatefulWidget {
  const CustomerListView({super.key});

  @override
  State<CustomerListView> createState() => _CustomerListViewState();
}

class _CustomerListViewState extends State<CustomerListView> {
  final customerRepository = CustomerRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      persistentFooterButtons: [
        InkWell(
          onTap: () {},
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
      body: FutureBuilder<List<CustomerModel>>(
          future: fetchCustomers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final customer = snapshot.data![index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          color: Colors.blueGrey.shade100, width: 0.5),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.teal.shade50,
                        foregroundColor: Colors.teal.shade700,
                        child: Icon(
                          HugeIcons.strokeRoundedMedicalMask,
                        ),
                      ),
                      contentPadding:
                          const EdgeInsets.only(left: 15, bottom: 5),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.to(CustomerEditView());
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
            } else {
              return const Center(child: Text('No data found!'));
            }
          }),
    );
  }

  Future<List<CustomerModel>> fetchCustomers() async {
    try {
      return customerRepository.getCustomers();
    } catch (e) {
      // print('Error: $e');
      throw Exception('Failed to load customers $e');
    }
  }
}
