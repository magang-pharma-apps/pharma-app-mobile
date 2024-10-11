import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/barcode_button_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_banner.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/section_header.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  CategoryRepository categoryRepository = CategoryRepository();
  ProductRepository productRepository = ProductRepository();

  // Kita mau mengambil data dari model CategoryModel dan ProductModel ditampung
  /// kedalam list categories dan products
  void getCategory() {
    final response = categoryRepository.getCategory();
    setState(() {
      categories = response.map((data) {
        return CategoryModel.fromJson(data);
      }).toList();
    });
  }

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
    getCategory();
    getProduct();
  }

  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CustomAppBar(),
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
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...List.generate(
                    categories.length,
                    (index) {
                      final category = categories.elementAt(index);
                      return SizedBox(
                        width: 120,
                        child: CardCategory(categoryModel: category),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Divider(
              height: 20,
              color: Colors.grey.shade300,
              thickness: 1,
              indent: 20,
              endIndent: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SectionHeader(
                sectionName: "Products",
                sectionIcon: HugeIcons.strokeRoundedPackage),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 250,
            child: ListView.builder(
              itemExtent: MediaQuery.of(context).size.width / 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CardProduct(productModel: products.elementAt(index));
              },
              itemCount: 5,
            ),
          )
        ],
      ),
    );
  }
}
