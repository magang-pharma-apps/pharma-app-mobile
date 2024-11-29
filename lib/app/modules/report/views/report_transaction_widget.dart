import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_line_widget.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/summary_text.dart';
import 'package:medpia_mobile/app/models/cart_model.dart';

class ReportTransactionWidget extends StatefulWidget {
  CartModel? cartModel;
  ReportTransactionWidget({super.key, this.cartModel});

  @override
  State<ReportTransactionWidget> createState() =>
      _ReportTransactionWidgetState();
}

class _ReportTransactionWidgetState extends State<ReportTransactionWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  final ExpansionTileController _expansionTileController =
      ExpansionTileController();

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Column(
            children: [
              ExpansionTile(
                enabled: false,
                showTrailingIcon: false,
                onExpansionChanged: (value) => setState(() {
                  _isExpanded = value;
                  if (_isExpanded) {
                    _animationController.forward();
                  } else {
                    _animationController.reverse();
                  }
                }),
                controller: _expansionTileController,
                collapsedBackgroundColor: Colors.white,
                backgroundColor: Colors.white,
                clipBehavior: Clip.none,
                collapsedShape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                tilePadding: EdgeInsets.only(left: 15, right: 15),
                childrenPadding: EdgeInsets.zero,
                title: SummaryText(
                  padding: EdgeInsets.zero,
                  leftText: widget.cartModel!.formattedDate,
                  leftStyle: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                  rightText: widget.cartModel!.transactionType!,
                  rightStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                      color: widget.cartModel!.transactionType! == 'Generic'
                          ? Colors.blue.shade800
                          : Colors.green.shade800),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.cartModel!.createdPayment,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.grey.shade800),
                    ),
                    CustomLineWidget(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 60,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey.shade300, width: 0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Image.network(widget.cartModel!.productImage),
                      ),
                      title: Text(
                        widget.cartModel!.transactionCode!,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: Colors.grey.shade800),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            visualDensity:
                                VisualDensity(vertical: -4, horizontal: -4),
                            dense: true,
                            contentPadding: EdgeInsets.zero,
                            titleTextStyle: Get.textTheme.labelSmall!
                                .copyWith(overflow: TextOverflow.clip),
                            title: Text(
                              widget.cartModel!.productName,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                    overflow: TextOverflow.ellipsis,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Text(widget.cartModel!.productQty,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      overflow: TextOverflow.ellipsis,
                                    )),
                          ),
                          Text(
                            widget.cartModel!.itemNote.isEmpty
                                ? ''
                                : 'Dosage: ${widget.cartModel!.itemNote}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.cartModel!.items!.length - 1,
                      itemBuilder: (context, index) {
                        final item = widget.cartModel!.items![index + 1];
                        return ListTile(
                          contentPadding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 15),
                          leading: Container(
                            width: 60,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.grey.shade300, width: 0.5),
                                borderRadius: BorderRadius.circular(5)),
                            child:
                                Image.network(item.product!.productImageUrl!),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SummaryText(
                                padding: EdgeInsets.zero,
                                leftText:
                                    '(${item.product!.productCode!}) ${item.product!.name!}',
                                leftStyle: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(overflow: TextOverflow.ellipsis),
                                rightText:
                                    '${item.productPrice}   x${item.quantity.toString()}', // '1x',
                                rightStyle:
                                    Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                item.note!.isEmpty
                                    ? ''
                                    : 'Dosage: ${item.note!}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.grey.shade600),
                              ),
                            ],
                          ),
                        );
                      }),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      widget.cartModel!.subtotalFormatted,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'PPN (10%): ${widget.cartModel!.taxFormatted}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                            'Total ${widget.cartModel!.items!.length} Products: '),
                        Text(widget.cartModel!.grandtotalFormatted,
                            style: Theme.of(context).textTheme.labelSmall)
                      ],
                    ),
                    Visibility(
                        visible:
                            widget.cartModel!.note!.isNotEmpty ? true : false,
                        child: Text(
                          'NOTE: ${widget.cartModel!.note!}',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(color: Colors.grey.shade600),
                        )),
                    Visibility(
                      visible:
                          widget.cartModel!.items!.length > 1 && !_isExpanded
                              ? true
                              : false,
                      child: InkWell(
                          onTap: () {
                            _isExpanded = !_isExpanded;
                            if (_isExpanded) {
                              _expansionTileController.expand();
                            } else {
                              _expansionTileController.collapse();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'See All',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(color: Colors.teal[800]),
                                ),
                                Icon(Icons.keyboard_arrow_down_rounded,
                                    size: 20, color: Colors.teal[600])
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
