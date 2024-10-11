import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/modules/home/views/home_view.dart';

class CoreView extends StatefulWidget {
  const CoreView({super.key});

  @override
  State<CoreView> createState() => _CoreViewState();
}

class _CoreViewState extends State<CoreView> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentPage,
        children: [
          HomeView(),
          Container(
            color: Colors.yellow,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.grey,
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(HugeIcons.strokeRoundedHome09),
          ),
          BottomNavigationBarItem(
              label: 'Perceptions',
              icon: Icon(HugeIcons.strokeRoundedInvoice01)),
          BottomNavigationBarItem(
              label: 'Order', icon: Icon(Icons.point_of_sale_outlined)),
          BottomNavigationBarItem(
              label: 'Profile', icon: Icon(HugeIcons.strokeRoundedUser))
        ],
      ),
    );
  }
}
