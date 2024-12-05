import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';

class ProductDetailView extends StatefulWidget {
  ProductModel? productModel;
  VoidCallback? onAddToCart;

  ProductDetailView({super.key, this.productModel, this.onAddToCart});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  final GlobalKey widgetKey = GlobalKey();

  late Function(GlobalKey) runAddToCartAnimation;

  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    DateTime parsedExpiryDate =
        DateTime.parse(widget.productModel!.expiryDate!);
    String formattedExpiryDate =
        DateFormat('yyyy/MM/dd').format(parsedExpiryDate);
    return AddToCartAnimation(
      cartKey: cartController.cartKeyDetail,
      height: 15,
      width: 15,
      opacity: 1,
      dragAnimation: const DragToCartAnimationOptions(
        curve: Curves.ease,
        duration: Duration(milliseconds: 250),
        rotation: false,
      ),
      jumpAnimation: const JumpAnimationOptions(
        active: false,
      ),
      createAddToCartAnimation: (runAddToCartAnimation) {
        // You can run the animation by addToCartAnimationMethod, just pass trough the the global key of  the image as parameter
        this.runAddToCartAnimation = runAddToCartAnimation;
      },
      child: Scaffold(
          persistentFooterButtons: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.only(top: 5),
                    side: BorderSide(color: Colors.transparent)),
                onPressed: () {
                  itemClick(widgetKey);
                  cartController.addItemToCart(CartItemModel(
                      product: widget.productModel, quantity: 1, note: ''));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 17,
                    ),
                    Text(
                      'Add To Cart',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white),
                    )
                  ],
                ))
          ],
          body: CustomScrollView(slivers: [
            SliverAppBar(
              actions: [
                Obx(() {
                  return IconButton(
                    padding: EdgeInsets.only(right: 8),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CartScreen()));
                    },
                    icon: Stack(
                      children: [
                        AddToCartIcon(
                          key: cartController.cartKeyDetail,
                          icon:
                              const Icon(HugeIcons.strokeRoundedShoppingCart01),
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
              backgroundColor: Colors.white,
              pinned: true,
              expandedHeight: 300.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                centerTitle: true,
                background: Container(
                  key: widgetKey,
                  child: Image(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(widget.productModel!.productImageUrl!)),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.grey.shade300, width: 0.3)),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget.productModel!.productCode!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[500]),
                              ),
                              SizedBox(width: 5),
                            ],
                          ),
                          Text(widget.productModel!.name!,
                              style: Theme.of(context).textTheme.labelMedium),
                          Text(
                              FormatRupiah.format(
                                  widget.productModel!.sellingPrice!),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: Colors.teal.shade800,
                                      fontWeight: FontWeight.bold,
                                      height: 2)),
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 90,
                                padding: EdgeInsets.symmetric(vertical: 3),
                                decoration: BoxDecoration(
                                    color: Colors.amber.shade200,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  widget.productModel!.category!.name!,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.teal.shade800),
                                ),
                              ),
                              Spacer(),
                              Text(
                                  "In stock (${widget.productModel!.stockQuantity!})",
                                  style:
                                      Theme.of(context).textTheme.bodyMedium),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.grey.shade300, width: 0.5),
                          )),
                      child: ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          'Product Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                        trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: EdgeInsets.only(top: 10),
                                      alignment: Alignment.center,
                                      height: 300,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(5),
                                              right: Radius.circular(5))),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Details",
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          CustomLineWidget(),
                                          ListTile(
                                            titleTextStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            title: Text("Date Expired"),
                                            trailing: Text(formattedExpiryDate),
                                          ),
                                          ListTile(
                                            titleTextStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            title: Text("Available Stock"),
                                            trailing: Text(widget
                                                .productModel!.stockQuantity!
                                                .toString()),
                                          ),
                                          ListTile(
                                            titleTextStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            title: Text("Units"),
                                            trailing: Text(widget
                                                .productModel!.unit!.name!),
                                          ),
                                          ListTile(
                                            titleTextStyle: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            title: Text("Drug Class"),
                                            trailing: Text(widget
                                                .productModel!.drugClass!),
                                          ),
                                          Spacer(),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.9,
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text("Oke"))),
                                          SizedBox(height: 5)
                                        ],
                                      ),
                                    );
                                  });
                            },
                            icon: Icon(HugeIcons.strokeRoundedArrowRight01)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Colors.grey.shade300, width: 0.5)),
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Description",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, height: 3),
                          ),
                          Text(
                            widget.productModel!.description!,
                            style: TextStyle(color: Colors.grey.shade700),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ])),
    );
  }

  void itemClick(GlobalKey widgetKey) async {
    await runAddToCartAnimation(widgetKey);
    await cartController.cartKeyDetail.currentState!
        .runCartAnimation((cartController.cart.value.items!.length).toString());
  }
}
