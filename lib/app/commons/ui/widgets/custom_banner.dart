import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/modules/product/views/product_view.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Order Medicine",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                Spacer(),
                Text(
                    "Upload Prescription and tell us what you need. We do the rest",
                    style: Theme.of(context).textTheme.bodySmall),
                Spacer(),
                Text(
                  "Save Upto 60% off",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.teal.shade800),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductView()));
                    },
                    child: Text(
                      "Order Now",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: Colors.white),
                    ))
              ],
            ),
          ),
          Expanded(
            child: Image.asset('assets/images/pharm-banner.png'),
          )
        ],
      ),
    );
  }
}
