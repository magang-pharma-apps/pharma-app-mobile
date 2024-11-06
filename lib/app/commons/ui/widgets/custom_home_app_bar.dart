import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: ThemeManager.onPrimaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(
                    'https://th.bing.com/th/id/OIP.2r9PsOkVBHqy4XP3BEUhaQHaHs?rs=1&pid=ImgDetMain'),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome Back!",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: ThemeManager.tealColor)),
                  InkWell(
                      onTap: () {},
                      child: Text(
                        "${GetStorage().read('username').toString().split(' ').map((word) => word[0].toUpperCase() + word.substring(1)).join(' ')}",
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall!
                            .copyWith(color: Colors.teal.shade500),
                      ))
                ],
              ),
            ],
          ),
        ),
        Spacer(),
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
          icon: Icon(HugeIcons.strokeRoundedShoppingCart01),
          color: Colors.grey.shade800,
          iconSize: 25.0,
        )
      ],
    );
  }
}
