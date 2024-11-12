import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/unit_model.dart';
import 'package:medpia_mobile/app/modules/master/views/master_unit_edit.dart';
import 'package:medpia_mobile/app/repositories/unit_repository.dart';

class MasterUnitList extends StatefulWidget {
  const MasterUnitList({super.key});

  @override
  State<MasterUnitList> createState() => _MasterUnitListState();
}

class _MasterUnitListState extends State<MasterUnitList> {
  final unitRepository = UnitRepository();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        InkWell(
          onTap: () {},
          child: Center(
            child: Column(
              children: [
                Icon(
                  HugeIcons.strokeRoundedAddSquare,
                  color: Colors.grey.shade700,
                ),
                Text('Create Unit',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Master Unit',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: FutureBuilder<List<UnitModel>>(
          future: fetchUnits(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final unit = snapshot.data![index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: ListTile(
                      visualDensity: VisualDensity(vertical: -4),
                      title: Text(
                        '${unit.name!}',
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      subtitle: Text(
                        '${unit.description}',
                        maxLines: 1,
                      ),
                      onTap: () {
                        Get.to(MasterUnitEdit());
                      },
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                title: Text(
                                  unit.name!,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.to(MasterUnitEdit());
                                    },
                                    child: Text('Edit'),
                                  ),
                                  CupertinoActionSheetAction(
                                    onPressed: () {},
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            });
                      },
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('No data found!'));
            }
          }),
    );
  }

  Future<List<UnitModel>> fetchUnits() async {
    try {
      return unitRepository.getUnits();
    } catch (e) {
      // print('Error: $e');
      throw Exception('Failed to load units $e');
    }
  }
}
