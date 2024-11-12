import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/search_widget.dart';
import 'package:medpia_mobile/app/modules/report/views/transaction_tab_view.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView>
    with SingleTickerProviderStateMixin {
  late final tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text(
          'Report',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        centerTitle: true,
        bottom: TabBar(
            controller: tabBarController,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            unselectedLabelColor: Colors.black,
            labelColor: Colors.deepPurple,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedTransaction,
                      size: 20,
                    ),
                    Text(' Transactions')
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      HugeIcons.strokeRoundedLayers01,
                      size: 20,
                    ),
                    Text(' Stock')
                  ],
                ),
              )
            ]),
      ),
      body: TabBarView(controller: tabBarController, children: [
        TransactionTabView(),
        Text('ReportView is working'),
      ]),
    );
  }
}
