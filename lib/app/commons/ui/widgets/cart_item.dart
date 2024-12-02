import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_prescription.dart';
import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
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
  VoidCallback? onRemove;
  CartItem({super.key, this.cartItemModel, this.onQtyChange, this.onRemove});

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
        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity(horizontal: -4, vertical: -4),
          // isThreeLine: true,
          contentPadding: EdgeInsets.only(left: 5),
          leading: Container(
              width: 50,
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
                .bodyMedium!
                .copyWith(color: Colors.black),
          ),
          subtitle: SizedBox(
            width: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    FormatRupiah.format(
                        widget.cartItemModel!.product!.sellingPrice!),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.teal, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                NotePrescription(
                  onChanged: (value) {
                    widget.cartItemModel!.note = value;
                  },
                ),
              ],
            ),
          ),
          trailing: SizedBox(
            width: 170,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _reduceQuantity();
                      widget.onQtyChange!();
                    },
                    icon: Icon(
                      HugeIcons.strokeRoundedMinusSign,
                      size: 16,
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
                    icon: Icon(
                      HugeIcons.strokeRoundedPlusSign,
                      size: 16,
                    )),
                IconButton(
                  onPressed: () {
                    widget.onRemove!();
                  },
                  icon: Icon(
                    HugeIcons.strokeRoundedDelete01,
                    size: 16,
                    color: Colors.red,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
