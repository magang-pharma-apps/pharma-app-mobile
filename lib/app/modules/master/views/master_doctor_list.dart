import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/modules/master/views/master_doctor_edit.dart';
import 'package:medpia_mobile/app/repositories/doctor_repository.dart';

class MasterDoctorList extends StatefulWidget {
  const MasterDoctorList({super.key});

  @override
  State<MasterDoctorList> createState() => _MasterDoctorListState();
}

class _MasterDoctorListState extends State<MasterDoctorList> {
  final doctorRepository = DoctorRepository();
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
                  HugeIcons.strokeRoundedUserAdd01,
                  color: Colors.grey.shade700,
                ),
                Text('Create Doctor',
                    style: Theme.of(context).textTheme.bodySmall)
              ],
            ),
          ),
        )
      ],
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Master Doctor',
          style: Theme.of(context).textTheme.labelLarge,
        ),
      ),
      body: FutureBuilder<List<DoctorModel>>(
          future: fetchDoctors(),
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
                  final doctor = snapshot.data![index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Colors.blueGrey.shade100, width: 0.5),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.only(left: 10),
                      visualDensity: VisualDensity.compact,
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueGrey.shade50,
                        foregroundColor: Colors.blue.shade800,
                        child: Icon(
                          HugeIcons.strokeRoundedDoctor02,
                        ),
                      ),
                      title: Text(doctor.name!),
                      subtitle: Text(
                        '${doctor.specialization}',
                        maxLines: 2,
                      ),
                      onTap: () {
                        Get.to(MasterDoctorEdit());
                      },
                      onLongPress: () {
                        showCupertinoModalPopup(
                            context: context,
                            builder: (context) {
                              return CupertinoActionSheet(
                                title: Text(
                                  doctor.name!,
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                actions: [
                                  CupertinoActionSheetAction(
                                    onPressed: () {
                                      Get.to(MasterDoctorEdit());
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

  Future<List<DoctorModel>> fetchDoctors() async {
    try {
      return doctorRepository.getDoctors();
    } catch (e) {
      // print('Error: $e');
      throw Exception('Failed to load doctors $e');
    }
  }
}
