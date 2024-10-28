import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class ProductView extends StatefulWidget {
  ProductModel? productModel = ProductModel();
  ProductView({super.key, this.productModel});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductRepository productRepository = ProductRepository();

  // void getProduct() {
  //   final response = productRepository.getProduct();
  //   products = response.map((data) {
  //     return ProductModel.fromJson(data);
  //   }).toList();
  // }

  // @override
  // initState() {
  //   super.initState();
  //   getProduct();
  // }

  // List<ProductModel> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            CustomAppBar(appBarTitle: 'All Products'),
            SearchWidget(),
            SizedBox(height: 5),
            Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: fetchProduct(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return GridView.builder(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height / 3),
                        itemBuilder: (context, index) {
                          final products = snapshot.data![index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailView()),
                                );
                              },
                              child: CardProduct(productModel: products));
                        });
                  } else {
                    return const Center(child: Text('No data found!'));
                  }
                },
              ),
            )
          ],
        ),
      ),
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
