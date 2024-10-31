import 'package:flutter/material.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';

class CustomExpantiontileRedemption extends StatefulWidget {
  CustomExpantiontileRedemption({super.key});

  @override
  State<CustomExpantiontileRedemption> createState() => _CustomExpantiontileRedemptionState();
}

class _CustomExpantiontileRedemptionState extends State<CustomExpantiontileRedemption>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();

  @override
  void dispose() {  
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                ExpansionTile(
                  onExpansionChanged: (value) => setState(() {
                    _isExpanded = value;
                    if (_isExpanded) {
                      _controller.forward();
                    } else {
                      _controller.reverse();
                    }
                  }),
                  controller: _expansionTileController,
                  collapsedBackgroundColor: Colors.white,
                  backgroundColor: Colors.white,
                  clipBehavior: Clip.none,
                  collapsedShape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10))),
                  tilePadding: EdgeInsets.only(left: 15),
                  childrenPadding: EdgeInsets.zero,
                  title: Text(
                    '15 Mei 2024',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.teal),

                  ),
                  
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Name/Recipe: #RECIPE R03I20",
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                                color: Colors.teal.shade800,
                                fontWeight: FontWeight.bold),
                      ),
                      
                    ],
                  ),
                  trailing: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green.shade100),
                    child: Text(
                      'Open',
                      style: TextStyle(
                          color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        "Products",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1 STRIP Amoxicilline 350 mg",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.grey.shade700),
                          ),
                          Text(
                            "1 STRIP Paracetaml 350 mg",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.grey.shade700),
                          ),
                          Text(
                            "1 STRIP Diabetasol 100mg",
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(color: Colors.grey.shade700),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Nama Pasien',
                              style: Theme.of(context).textTheme.labelLarge),
                          Text('Usia',
                              style: Theme.of(context).textTheme.labelLarge),
                        ],
                      ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Subagyo',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            '24',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Doctor",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      trailing: Text(
                        "Dr. Susilo",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border:
                          Border.all(color: Colors.grey.shade300, width: 0.5),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: ListTile(
                    visualDensity:
                        VisualDensity(horizontal: -4.0, vertical: -4.0),
                    contentPadding: EdgeInsets.symmetric(horizontal: 5),
                    title: Text('Price',
                        style: TextStyle(
                            color: Colors.teal.shade800,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    trailing: Text(
                      "Rp.15000",
                      style: TextStyle(
                          color: Colors.teal.shade800,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
              bottom: -15,
              child: RotationTransition(
                turns: Tween<double>(begin: 0, end: 0.5).animate(
                    CurvedAnimation(
                        parent: _controller, curve: Curves.elasticInOut)),
                child: InkWell(
                  onTap: () {
                    _isExpanded = !_isExpanded;
                    if (_isExpanded) {
                      _expansionTileController.expand();
                      ExpansionTileController.of(context).expand();
                    } else {
                      _expansionTileController.collapse();
                      ExpansionTileController.of(context).collapse();
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 15,
                    child: Center(
                        child: Icon(
                      Icons.expand_more,
                      color: Colors.white,
                      size: 25,
                    )),
                  ),
                ),
              ))
        ]);
  }
}
