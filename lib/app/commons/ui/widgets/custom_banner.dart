import 'package:flutter/material.dart';

class CustomBanner extends StatelessWidget {
  const CustomBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 160,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.teal.shade50,
        borderRadius: BorderRadius.circular(10),
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
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Spacer(),
                Text(
                    "Upload Prescription and tell us what you need. We do the rest"),
                Spacer(),
                Text(
                  "Save Upto 60% off",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.teal.shade800),
                ),
                SizedBox(height: 10),
                ElevatedButton(onPressed: () {}, child: Text("Order Now"))
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
