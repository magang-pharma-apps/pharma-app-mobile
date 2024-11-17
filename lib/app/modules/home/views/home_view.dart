import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/barcode_button_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_home_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_banner.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/section_header.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/category/views/category_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryRepository categoryRepository = CategoryRepository();
  ProductRepository productRepository = ProductRepository();
  final cartController = Get.put(CartController());

  // void getProduct() {
  //   final response = productRepository.getProduct();
  //   setState(() {
  //     products = response.map((data) {
  //       return ProductModel.fromJson(data);
  //     }).toList();
  //   });
  // }

  @override
  initState() {
    super.initState();
    // getCategory();
    // getProduct();
  }

  // List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CustomHomeAppBar(),
                SizedBox(height: 15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: SearchWidget()),
                    SizedBox(width: 10),
                    BarcodeButtonWidget(),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  height: 150,
                  child: CarouselView(
                    onTap: (value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductView()));
                    },
                    shrinkExtent: 0.7,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    elevation: 0,
                    children: [
                      CustomBanner(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductView()))),
                      CustomBanner(),
                    ],
                    itemExtent: MediaQuery.of(context).size.width,
                  ),
                ),
                SizedBox(height: 15),
                SectionHeader(
                  sectionName: "Category",
                  sectionIcon: HugeIcons.strokeRoundedGridView,
                  viewAllPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryView()));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<CategoryModel>>(
                future: fetchCategory(),
                builder: (context, snapshot) {
                  // print(snapshot);
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return SizedBox(
                      child: ListView.separated(
                        padding: EdgeInsets.only(left: 10),
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 10),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final category = snapshot.data![index];
                          return CardCategory(categoryModel: category);
                        },
                        itemCount: snapshot.data!.length,
                      ),
                    );
                  } else {
                    return const Center(child: Text('No data found!'));
                  }
                  // Ensure a widget is always returned
                },
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: SectionHeader(
                viewAllPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProductView()));
                },
                sectionName: "Products",
                sectionIcon: HugeIcons.strokeRoundedPackage),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 260,
            child: FutureBuilder<List<ProductModel>>(
                future: fetchProduct(),
                builder: (context, snapshot) {
                  // print(snapshot);
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // print(snapshot);

                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return ListView.builder(
                      itemExtent: MediaQuery.of(context).size.width / 2.5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        // Text('${product.name}');
                        return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductDetailView(
                                            productModel: product,
                                          )));
                            },
                            child: CardProduct(
                                productModel: product,
                                onAddToCart: () {
                                  cartController.addItemToCart(CartItemModel(
                                      product: product, quantity: 1, note: ''));
                                }));
                      },
                      itemCount: 5,
                    );
                  } else {
                    return const Center(child: Text('No data found!'));
                  }
                }),
          )
        ],
      ),
    );
  }

  Future<List<CategoryModel>> fetchCategory() async {
    try {
      return categoryRepository.getCategories();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load category $e');
    }
  }

  Future<List<ProductModel>> fetchProduct() async {
    try {
      return productRepository.getProducts();
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load product $e');
    }
  }
}
