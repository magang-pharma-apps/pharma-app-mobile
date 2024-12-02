import 'package:add_to_cart_animation/add_to_cart_animation.dart';
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
  GlobalKey<CartIconKey> cartKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCartAnimation;
  GlobalKey widgetKey = GlobalKey();

  final cartController = Get.put(CartController());
  var cartQuantityItems = 0;

  ProductRepository productRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return AddToCartAnimation(
      cartKey: cartController.cartKey,
      height: 15,
      width: 15,
      opacity: 0.85,
      dragAnimation: const DragToCartAnimationOptions(
        rotation: false,
      ),
      jumpAnimation: const JumpAnimationOptions(),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          backgroundColor: Colors.white,
          title: Text('All Products',
              style: Theme.of(context).textTheme.labelLarge),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 10),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: AddToCartIcon(
                key: cartController.cartKey,
                icon: const Icon(HugeIcons.strokeRoundedShoppingCart01),
                badgeOptions: const BadgeOptions(
                  active: true,
                  backgroundColor: Colors.orange,
                ),
              ),
            )
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
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                  onClick: itemClick,
                                  widgetKey: GlobalKey(),
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
