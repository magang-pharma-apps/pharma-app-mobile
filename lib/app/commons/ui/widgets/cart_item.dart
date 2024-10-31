import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_prescription.dart';
import 'package:medpia_mobile/app/models/cart_item_model.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

Image getImagebyDrugClass(String drugClass) {
  switch (drugClass) {
    case 'Obat Bebas Terbatas':
      return Image.asset('assets/images/obt.png', width: 10);
    case 'Obat Keras':
      return Image.asset('assets/images/ok.png', width: 10);
    default:
      return Image.asset('assets/images/ob.png', width: 10);
  }
}

class CartItem extends StatefulWidget {
  VoidCallback? onQtyChange;
  CartItemModel? cartItemModel;
  CartItem({super.key, this.cartItemModel, this.onQtyChange});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  final cartController = Get.put(CartController());

  void _addQuantity() {
    setState(() {
      if (widget.cartItemModel!.quantity != null) {
        widget.cartItemModel!.quantity = widget.cartItemModel!.quantity! + 1;
      }
    });
  }

  void _reduceQuantity() {
    setState(() {
      if (widget.cartItemModel!.quantity != null &&
          widget.cartItemModel!.quantity! > 1) {
        widget.cartItemModel!.quantity = widget.cartItemModel!.quantity! - 1;
      } else if (widget.cartItemModel!.quantity! <= 1) {
        widget.cartItemModel!.quantity = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade100),
            borderRadius: BorderRadius.circular(10)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: ListTile(
          visualDensity: VisualDensity.standard,
          // isThreeLine: true,
          contentPadding: EdgeInsets.only(left: 10),
          leading: Container(
              width: 70,
              clipBehavior: Clip.antiAlias,
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      topLeft: Radius.circular(5)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          widget.cartItemModel!.product!.productImageUrl!))),
              child: getImagebyDrugClass(
                  widget.cartItemModel!.product!.drugClass!)),
          title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            widget.cartItemModel!.product!.name!,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: Colors.black),
          ),
          subtitle: SizedBox(
            width: 250,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "Rp ${widget.cartItemModel!.product!.sellingPrice!}",
                    style: Theme.of(context).textTheme.titleSmall),
                SizedBox(height: 5),
                NotePrescription(),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 180,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _reduceQuantity();
                      widget.onQtyChange!();
                    },
                    icon: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        HugeIcons.strokeRoundedMinusSign,
                        size: 12,
                      ),
                    )),
                Text(
                  "${widget.cartItemModel!.quantity}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    autofocus: true,
                    onPressed: () {
                      _addQuantity();
                      widget.onQtyChange!();
                    },
                    icon: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        HugeIcons.strokeRoundedPlusSign,
                        size: 12,
                      ),
                    )),
                IconButton(
                  onPressed: () {
                    cartController.removeItemFromCart(widget.cartItemModel!);
                  },
                  icon: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.red.shade50,
                      child: Icon(
                        HugeIcons.strokeRoundedDelete01,
                        size: 12,
                        color: Colors.red,
                      )),
                )
              ],
            ),
          ),
        ));
  }
}
