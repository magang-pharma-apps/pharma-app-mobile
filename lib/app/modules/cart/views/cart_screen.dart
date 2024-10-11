import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/button_note.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/cart_item.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/order_detail.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
  }

  List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("You've Added",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(color: Colors.grey.shade800)),
                    Row(
                      children: [
                        Text("3",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.green)),
                        Text(" Items",
                            style: Theme.of(context).textTheme.labelMedium)
                      ],
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Purchase Rp. 55.000",
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20)),
              ),
            ],
          ),
        )
      ],
      body: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(20),
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CartAppBar(),
                  SizedBox(height: 10),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return CartItem(
                          productModel: products.elementAt(index),
                        );
                      },
                    ),
                  ),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 0.5,
                    height: 30,
                  ),
                  ButtonNote(),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 0.5,
                    height: 30,
                  ),
                  OrderDetail(),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Transaction Number",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(color: Colors.grey.shade800)),
                            SizedBox(height: 5),
                            Text("TRX-2021-0001",
                                style: Theme.of(context).textTheme.labelMedium),
                          ],
                        ),
                        Divider(
                          color: Colors.grey.shade400,
                          thickness: 1,
                          height: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Patient Name",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color: Colors.grey.shade800),
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  hoverColor: Colors.transparent,
                                  hintText: "Enter patient name",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: Colors.grey.shade300)),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ])
          ],
        ),
      ),
    );
  }
}
