import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/note_prescription.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

Image getImagebyDrugClass(String drugClass) {
  switch (drugClass) {
    case 'W':
      return Image.asset('assets/images/obt.png', width: 10);
    case 'G':
      return Image.asset('assets/images/ok.png', width: 10);
    default:
      return Image.asset('assets/images/ob.png', width: 10);
  }
}

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
                      image: AssetImage(widget.productModel!.image!))),
              child: getImagebyDrugClass(widget.productModel!.drugClass!)),
          title: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            widget.productModel!.name!,
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
                    "Rp ${widget.productModel!.sellingPrice}",
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
                    },
                    icon: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        HugeIcons.strokeRoundedMinusSign,
                        size: 12,
                      ),
                    )),
                Text(
                  "${quantity}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                IconButton(
                    autofocus: true,
                    onPressed: () {
                      _addQuantity();
                    },
                    icon: CircleAvatar(
                      radius: 12,
                      child: Icon(
                        HugeIcons.strokeRoundedPlusSign,
                        size: 12,
                      ),
                    )),
                IconButton(
                  onPressed: () {},
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
