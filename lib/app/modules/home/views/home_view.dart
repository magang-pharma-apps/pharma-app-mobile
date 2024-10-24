import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/barcode_button_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_home_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_banner.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/section_header.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/category/views/category_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/repositories/category_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryRepository categoryRepository = CategoryRepository();
  ProductRepository productRepository = ProductRepository();

  void getProduct() {
    final response = productRepository.getProduct();
    setState(() {
      products = response.map((data) {
        return ProductModel.fromJson(data);
      }).toList();
    });
  }

  @override
  initState() {
    super.initState();
    // getCategory();
    getProduct();
  }

  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomHomeAppBar(),
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: SearchWidget()),
                    SizedBox(width: 10),
                    BarcodeButtonWidget(),
                  ],
                ),
                SizedBox(height: 30),
                Container(
                  // margin: EdgeInsets.symmetric(vertical: 10),
                  height: 200,
                  child: PageView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return CustomBanner();
                    },
                  ),
                ),
                SizedBox(height: 40),
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
              height: 150,
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<CategoryModel>>(
                future: fetchCategory(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final category = snapshot.data![index];
                        return SizedBox(
                          width: 120,
                          child: CardCategory(categoryModel: category),
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Center(child: Text('No data found!'));
                  }
                  return const SizedBox
                      .shrink(); // Ensure a widget is always returned
                },
              )),
          Divider(
              height: 20,
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 20,
              endIndent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            child: ListView.builder(
              itemExtent: MediaQuery.of(context).size.width / 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetailView()));
                    },
                    child:
                        CardProduct(productModel: products.elementAt(index)));
              },
              itemCount: 5,
            ),
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
}
