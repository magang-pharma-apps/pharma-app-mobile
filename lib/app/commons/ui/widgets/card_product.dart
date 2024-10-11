import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

class CardProduct extends StatelessWidget {
  ProductModel? productModel;
  CardProduct({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 0.5),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
                clipBehavior: Clip.hardEdge,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  productModel!.image!,
                  fit: BoxFit.cover,
                )),
          ),
          Text(
            productModel!.name!,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 2),
          ),
          Text(
            productModel!.description!,
            overflow: TextOverflow.fade,
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
              Text("Rp ${productModel!.sellingPrice}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                      height: 3)),
              Spacer(),
              Text("(${productModel!.quantity})",
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text(
                "+ Add to Chart",
                style: Theme.of(context).textTheme.labelSmall!,
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.teal),
                overlayColor: Colors.tealAccent.shade400,
                elevation: 2,
              ))
        ],
      ),
    );
  }
}
