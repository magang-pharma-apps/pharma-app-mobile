import 'dart:math';

import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/card_product.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';
import 'package:medpia_mobile/app/modules/product/controllers/product_controller.dart';
import 'package:medpia_mobile/app/modules/product/views/product_detail_view.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

class ProductView extends GetView<ProductController> {
  ProductView({super.key});

  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();

  late Function(GlobalKey) runAddToCartAnimation;

  final cartController = Get.put(CartController());
  @override
  get controller => Get.put(ProductController());

  ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartController.cartKey,
      height: 15,
      width: 15,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
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
          forceMaterialTransparency: false,
          elevation: 0,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('All Products',
              style: Theme.of(context).textTheme.labelLarge),
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
                      key: cartController.cartKey,
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
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              SearchWidget(),
              Expanded(child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.builder(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      itemCount: controller.productList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisExtent:
                              MediaQuery.of(context).size.height / 3),
                      itemBuilder: (context, index) {
                        final product = controller.productList[index];
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
                              widgetKey: GlobalKey(),
                              onClick: itemClick,
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
                }
              }))
            ],
          ),
        ),
      ),
    );
  }

  void itemClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartController.cartKey.currentState!
        .runCartAnimation((cartController.cart.value.items!.length).toString());
  }

  Future<List<ProductModel>> fetchProduct() async {
    try {
      return productRepository.getProducts();
    } catch (e) {
      throw Exception('Failed to load product $e');
    }
  }
}
