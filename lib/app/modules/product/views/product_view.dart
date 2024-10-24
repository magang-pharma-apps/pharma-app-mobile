import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  ProductRepository productRepository = ProductRepository();

  void getProduct() {
    final response = productRepository.getProduct();
    products = response.map((data) {
      return ProductModel.fromJson(data);
    }).toList();
  }

  @override
  initState() {
    super.initState();
    getProduct();
  }

  List<ProductModel> products = [];
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
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisExtent: MediaQuery.of(context).size.height / 3),
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetailView()),
                          );
                        },
                        child: CardProduct(
                            productModel: products.elementAt(index)));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
