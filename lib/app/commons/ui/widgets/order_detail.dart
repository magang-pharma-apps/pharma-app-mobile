import 'package:flutter/material.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          child: Text("Order Info",
              textHeightBehavior: TextHeightBehavior(
                  applyHeightToLastDescent: true,
                  applyHeightToFirstAscent: true),
              style: Theme.of(context).textTheme.displaySmall),
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sub Total",
                style: Theme.of(context).textTheme.bodyMedium,
                textHeightBehavior: TextHeightBehavior(
                    applyHeightToLastDescent: true,
                    applyHeightToFirstAscent: true),
              ),
              Text("Rp 50.000", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "PPN 10%",
                style: Theme.of(context).textTheme.bodyMedium,
                textHeightBehavior: TextHeightBehavior(
                    applyHeightToLastDescent: true,
                    applyHeightToFirstAscent: true),
              ),
              Text("Rp 5.000", style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
        ),
        SizedBox(
          height: 20,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
                textHeightBehavior: TextHeightBehavior(
                    applyHeightToLastDescent: true,
                    applyHeightToFirstAscent: true),
              ),
              Text(
                "Rp 55.000",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }
}
