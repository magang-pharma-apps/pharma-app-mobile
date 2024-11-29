import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';


class ProductView extends StatefulWidget {
  ProductModel? productModel = ProductModel();
  ProductView({super.key, this.productModel});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final cartController = Get.put(CartController());

  ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        title:
            Text('All Products', style: Theme.of(context).textTheme.labelLarge),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Icon(HugeIcons.strokeRoundedShoppingCart01),
              ))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            SearchWidget(),
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
                            crossAxisCount: 2,
                            mainAxisExtent:
                                MediaQuery.of(context).size.height / 3),
                        itemBuilder: (context, index) {
                          final product = snapshot.data![index];
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailView(
                                            productModel: product,
                                          )),
                                );
                              },
                              child: CardProduct(
                                productModel: product,
                                onAddToCart: () {
                                  cartController.addItemToCart(CartItemModel(
                                    product: product,
                                    quantity: 1,
                                    note: '',
                                  ));
                                },
                              ));
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
