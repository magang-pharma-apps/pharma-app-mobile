import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/product_model.dart';
import 'package:medpia_mobile/app/modules/cart/controllers/cart_controller.dart';
import 'package:medpia_mobile/app/repositories/product_repository.dart';

Image getImagebyDrugClass(String drugClass) {
  switch (drugClass) {
    case 'Obat Bebas Terbatas':
      return Image.asset('assets/images/obt.png', width: 20);
    case 'Obat Keras':
      return Image.asset('assets/images/ok.png', width: 20);
    default:
      return Image.asset('assets/images/ob.png', width: 20);
  }
}

class CardProduct extends StatefulWidget {
  ProductModel? productModel;
  VoidCallback? onAddToCart;
  CardProduct({super.key, this.productModel, this.onAddToCart});

  @override
  State<CardProduct> createState() => _CardProductState();
}

class _CardProductState extends State<CardProduct> {
  // ProductRepository productRepository = ProductRepository();

  // void getProduct() async {
  //   final response = await productRepository.getProducts();
  //   setState(() {
  //     products = response;
  //   });
  // }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   getProduct();
  // }

  // List<ProductModel> products = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 7, left: 7, bottom: 5),
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
                  height: 500,
                  width: double.maxFinite,
                  clipBehavior: Clip.hardEdge,
                  alignment: Alignment.topRight,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              widget.productModel!.productImageUrl!,
                              scale: 500))),
                  child: getImagebyDrugClass(widget.productModel!.drugClass!))),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            widget.productModel!.name!,
            style: Theme.of(context).textTheme.titleSmall!.copyWith(height: 2),
          ),
          Text(
            widget.productModel!.description!,
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
              Text("Rp ${widget.productModel!.sellingPrice!}",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.teal.shade800,
                      fontWeight: FontWeight.bold,
                      height: 3)),
              Spacer(),
              Text("(${widget.productModel!.stockQuantity!})",
                  style: Theme.of(context).textTheme.bodySmall)
            ],
          ),
          ElevatedButton(
              onPressed: () {
                widget.onAddToCart!();
              },
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
