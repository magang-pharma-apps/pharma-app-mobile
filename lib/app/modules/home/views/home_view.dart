import 'dart:convert';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/barcode_button_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_category.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_banner.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/section_header.dart';
import 'package:medpia_mobile/app/commons/utils/scan_qr.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/category_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';
import 'package:medpia_mobile/app/modules/category/views/category_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';
import 'package:medpia_mobile/app/repositories/category_repository.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String barcodeResult = 'No Barcode Scanned';
  GlobalKey<CartIconKey> cartKeyHome = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;

  final TextEditingController locationController = TextEditingController();

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

  @override
  void dispose() {
    locationController.dispose();
    super.dispose();
  }

  // List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartController.cartKeyHome,
      height: 15,
      width: 15,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        duration: Duration(milliseconds: 200),
        rotation: false,
      ),
      jumpAnimation: const JumpAnimationOptions(
        duration: Duration(milliseconds: 200),
      ),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          forceMaterialTransparency: true,
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            decoration: BoxDecoration(
              color: ThemeManager.onPrimaryContainer,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                      'https://th.bing.com/th/id/OIP.2r9PsOkVBHqy4XP3BEUhaQHaHs?rs=1&pid=ImgDetMain'),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Welcome Back!",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: ThemeManager.tealColor)),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          "${GetStorage().read('username').toString().split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')}",
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(color: Colors.teal.shade500),
                        ))
                  ],
                ),
              ],
            ),
          ),
          actions: [
            Obx(() {
              return IconButton(
                padding: EdgeInsets.only(right: 8),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CartScreen()));
                },
                icon: Stack(
                  children: [
                    AddToCartIcon(
                      key: cartController.cartKeyHome,
                      icon: const Icon(HugeIcons.strokeRoundedShoppingCart01),
                      badgeOptions: const BadgeOptions(
                        active: false,
                      ),
                    ),
                    if (cartController.cartQuantityItem.value >= 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${cartController.cartQuantityItem.value}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: SearchWidget()),
                        SizedBox(width: 10),
                        BarcodeButtonWidget(
                          onPressed: () {
                            Get.to(ScanQr(setResult: setResult));
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      // margin: EdgeInsets.symmetric(vertical: 10),
                      height: 150,
                      child: CustomBanner(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductView()))),
                    ),
                    const SizedBox(height: 15),
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
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return SizedBox(
                          child: ListView.separated(
                            padding: EdgeInsets.only(left: 10),
                            separatorBuilder: (context, index) =>
                                SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final category = snapshot.data![index];
                              return CardCategory(
                                categoryModel: category,
                              );
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SectionHeader(
                    viewAllPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductView()));
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
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        final List<GlobalKey> widgetKeys = List.generate(
                          snapshot.data!.length,
                          (index) => GlobalKey(),
                        );
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
                                          builder: (context) =>
                                              ProductDetailView(
                                                productModel: product,
                                              )));
                                  // builder: (context) => MyApp()));
                                },
                                child: CardProduct(
                                    widgetKey: GlobalKey(),
                                    onClick: itemClick,
                                    productModel: product,
                                    onAddToCart: () {
                                      cartController.addItemToCart(
                                          CartItemModel(
                                              product: product,
                                              quantity: 1,
                                              note: ''));
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
        ),
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

  void itemClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartController.cartKeyHome.currentState!
        .runCartAnimation((cartController.cart.value.items!.length).toString());
  }

  void setResult(String result) {
    setState(() {
      barcodeResult = result;
      print('Result barcode: $result');
      locationController.text = result;
      print('Location controller: ${locationController.text}');
    });
  }
}
