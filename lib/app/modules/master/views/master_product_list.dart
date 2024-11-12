import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/master/views/master_product_edit.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class MasterProductList extends StatefulWidget {
  MasterProductList({super.key});

  @override
  State<MasterProductList> createState() => _MasterProductListState();
}

class _MasterProductListState extends State<MasterProductList> {
  final productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {},
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedMedicine01,
                  color: Colors.grey.shade700,
                ),
                Text('Create New Medicine',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Medicine List',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: FutureBuilder<List<ProductModel>>(
          future: fetchProduct(),
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
                  final product = snapshot.data![index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text(product.name!,
                          style: Theme.of(context).textTheme.labelSmall),
                      subtitle: Text(
                          'Expired on ${DateFormat('yyyy-MM-dd').format(DateTime.parse(product.expiryDate!))}'),
                      trailing: Text(
                        '${product.stockQuantity} ${product.unit!.name}',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      onTap: () {
                        Get.to(MasterProductEdit());
                      },
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                title: Text(
                                  product.name!,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.to(MasterProductEdit());
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

  Future<List<ProductModel>> fetchProduct() async {
    try {
      return productRepository.getProducts();
    } catch (e) {
      throw Exception('Failed to load product $e');
    }
  }
}
