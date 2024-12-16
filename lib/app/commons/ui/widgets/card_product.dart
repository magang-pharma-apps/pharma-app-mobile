import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/utils/format_rupiah.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

Image getImagebyDrugClass(String drugClass) {
  switch (drugClass) {
    case 'Obat Bebas Terbatas':
      return Image.asset('assets/images/obt.png', width: 15);
    case 'Obat Keras':
      return Image.asset('assets/images/ok.png', width: 15);
    default:
      return Image.asset('assets/images/ob.png', width: 15);
  }
}

class CardProduct extends StatefulWidget {
  final GlobalKey? widgetKey;
  final int? index;
  final void Function(GlobalKey)? onClick;

  ProductModel? productModel;
  VoidCallback? onAddToCart;
  CardProduct(
      {super.key,
      this.widgetKey,
      this.productModel,
      this.onAddToCart,
      this.index,
      this.onClick});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 3, left: 3, bottom: 5),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            padding: EdgeInsets.all(5),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Container(
                    key: widget.widgetKey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        widget.productModel!.productImageUrl!,
                        fit: BoxFit.cover,
                        scale: 100,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: getImagebyDrugClass(widget.productModel!.drugClass!),
                ),
              ],
            ),
          )),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            widget.productModel!.name!,
            style: Theme.of(context).textTheme.labelSmall!.copyWith(height: 2),
          ),
          Text(
            widget.productModel!.category!.name!,
            overflow: TextOverflow.ellipsis,
            textHeightBehavior:
                TextHeightBehavior(applyHeightToLastDescent: true),
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey.shade700),
          ),
          Row(
            children: [
              Text(FormatRupiah.format(widget.productModel!.sellingPrice!),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                      height: 3)),
              Spacer(),
              Text("(${widget.productModel!.stockQuantity!})",
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
          ElevatedButton(
              onPressed: widget.productModel!.stockQuantity != 0
                  ? () {
                      widget.onClick!(widget.widgetKey!);
                      widget.onAddToCart!();
                    }
                  : null,
              child: Text(
                "Add to Cart",
              ),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                foregroundColor: Colors.teal,
                disabledBackgroundColor: Colors.grey.shade300,
                disabledForegroundColor: Colors.grey,
                side: BorderSide(color: widget.productModel!.stockQuantity != 0 ? Colors.teal : Colors.grey.shade300),
                
                overlayColor: Colors.tealAccent.shade400,
                elevation: 0,
              ))
        ],
      ),
    );
  }
}
