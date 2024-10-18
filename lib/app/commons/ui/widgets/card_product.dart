import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/product_model.dart';

Image getImagebyDrugClass(String drugClass) {
  switch (drugClass) {
    case 'W':
      return Image.asset('assets/images/obt.png', width: 20);
    case 'G':
      return Image.asset('assets/images/ok.png', width: 20);
    default:
      return Image.asset('assets/images/ob.png', width: 20);
  }
}

class CardProduct extends StatelessWidget {
  ProductModel? productModel;
  CardProduct({super.key, this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7, left: 7, bottom: 15),
      padding: EdgeInsets.all(10),
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
                  height: 300,
                  width: double.maxFinite,
                  clipBehavior: Clip.antiAlias,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(productModel!.image!))),
                  child: getImagebyDrugClass(productModel!.drugClass!))),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            productModel!.name!,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 2),
          ),
          Text(
            productModel!.description!,
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
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontSize: 12),
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
