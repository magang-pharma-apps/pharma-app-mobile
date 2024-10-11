import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class CartItem extends StatefulWidget {
  ProductModel? productModel;
  CartItem({super.key, this.productModel});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int quantity = 1;

  void _addQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _reduceQuantity() {
    setState(() {
      if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Container(
              width: 130,
              height: 130,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 0.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Image.asset(widget.productModel!.image!,
                      fit: BoxFit.cover)),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productModel!.name!,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: Colors.black),
                    ),
                    SizedBox(height: 10),
                    Text("Rp ${widget.productModel!.sellingPrice}",
                        style: Theme.of(context).textTheme.titleSmall),
                    SizedBox(height: 30),
                    Row(
                      children: [
                        IconButton(
                            highlightColor: Colors.deepPurple.shade900,
                            onPressed: () {
                              _reduceQuantity();
                            },
                            icon: CircleAvatar(
                              child: Icon(HugeIcons.strokeRoundedMinusSign),
                            )),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "${quantity}",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                        IconButton(
                            highlightColor: Colors.deepPurple.shade900,
                            autofocus: true,
                            onPressed: () {
                              _addQuantity();
                            },
                            icon: CircleAvatar(
                              child: Icon(HugeIcons.strokeRoundedPlusSign),
                            )),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.2),
                        // Spacer(),
                        IconButton(
                          hoverColor: Colors.red.shade600,
                          onPressed: () {},
                          icon: CircleAvatar(
                              backgroundColor: Colors.red.shade50,
                              child: Icon(
                                HugeIcons.strokeRoundedDelete01,
                                color: Colors.red,
                              )),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
