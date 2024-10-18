import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_app_bar.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/modules/cart/views/cart_screen.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        persistentFooterButtons: [
          ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Text('Add To Cart')
                ],
              ))
        ],
        body: CustomScrollView(slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
                  },
                  icon: Icon(HugeIcons.strokeRoundedShoppingCart01))
            ],
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 350.0,
            flexibleSpace: const FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              centerTitle: true,
              background: Image(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/images/Amoxicillin.jpg")),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.shade300, width: 0.3)),
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'KODE00201',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[500]),
                            ),
                            SizedBox(width: 5),
                          ],
                        ),
                        Text("Amoxicillin Capsules 250 mg",
                            style: Theme.of(context).textTheme.displaySmall),
                        Text("Rp 120000",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                    color: Colors.teal.shade800,
                                    fontWeight: FontWeight.bold,
                                    height: 2)),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 90,
                              padding: EdgeInsets.symmetric(vertical: 3),
                              decoration: BoxDecoration(
                                  color: Colors.amber.shade200,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                'Antibiotics',
                                style: TextStyle(
                                    fontSize: 11, color: Colors.teal.shade800),
                              ),
                            ),
                            Spacer(),
                            Text("In stock (10)",
                                style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.shade300, width: 0.5),
                        )),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Product Details',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.only(top: 10),
                                    alignment: Alignment.center,
                                    height: 500,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(5),
                                            right: Radius.circular(5))),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Product Details",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CustomLineWidget(),
                                        ListTile(
                                          title: Text("Date Expired"),
                                          trailing: Text("15 September 2025"),
                                        ),
                                        ListTile(
                                          title: Text("Available Stock"),
                                          trailing: Text('10'),
                                        ),
                                        ListTile(
                                          title: Text("Units"),
                                          trailing: Text('STRIP'),
                                        ),
                                        ListTile(
                                          title: Text("Drug Class"),
                                          trailing: Text('Obat Bebas Terbatas'),
                                        ),
                                        Spacer(),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.9,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("Oke"))),
                                        SizedBox(height: 5)
                                      ],
                                    ),
                                  );
                                });
                          },
                          icon: Icon(HugeIcons.strokeRoundedArrowRight01)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Colors.grey.shade300, width: 0.5)),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, height: 3),
                        ),
                        Text(
                          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Curabitur pretium tincidunt lacus. Nulla gravida orci a odio. Nullam varius, turpis et commodo pharetra.',
                          style: TextStyle(color: Colors.grey.shade700),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
