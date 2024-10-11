import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
            color: ThemeManager.onPrimaryContainer,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.2r9PsOkVBHqy4XP3BEUhaQHaHs?rs=1&pid=ImgDetMain'),
              ),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back!",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: ThemeManager.tealColor)),
                  TextButton(
                      clipBehavior: Clip.antiAlias,
                      onPressed: () {},
                      child: Text(
                        "John Doe",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ThemeManager.tealColor),
                      ))
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => CartScreen()));
          },
          icon: Icon(HugeIcons.strokeRoundedShoppingCart01),
          color: Colors.grey.shade800,
          iconSize: 30.0,
        )
      ],
    );
  }
}
