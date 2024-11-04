import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/repositories/customer_repository.dart';
import 'package:medpia_mobile/app/repositories/doctor_repository.dart';
import 'package:medpia_mobile/app/repositories/prescription_repository.dart';

class PrescriptionForm extends StatefulWidget {
  VoidCallback? onPrescriptionAdded;
  PrescriptionForm({super.key, this.onPrescriptionAdded});

  @override
  State<PrescriptionForm> createState() => _PrescriptionFormState();
}

class _PrescriptionFormState extends State<PrescriptionForm> {
  PrescriptionRepository prescriptionRepository = PrescriptionRepository();
  CustomerRepository customerRepository = CustomerRepository();
  DoctorRepository doctorRepository = DoctorRepository();
  bool isRedeem = false;

  CustomerModel? selectedCustomer;
  DoctorModel? selectedDoctor;
  String? prescription;
  String? prescriptionCode =
      'PRE${Random().nextInt(max(1000, 9999)).toString()}';

  List<CustomerModel> customers = [];
  List<DoctorModel> doctors = [];

  @override
  void initState() {
    super.initState();
    getCustomers();
    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM/dd/yyyy hh:mm:ss a').format(now);

    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            createPrescription();
          },
          child: const Text('Save Prescription'),
        ),
      ],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: const Text('Prescription Form'),
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
                title: Text(
                  "Fill Prescription Detail",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: const Text(
                    "Fill in required fields to fill prescription request"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController()..text = formattedDate,
                decoration: const InputDecoration(
                    labelText: 'Prescription Date',
                    suffixIcon: Icon(
                      HugeIcons.strokeRoundedCalendar01,
                      color: Colors.black,
                    )),
                readOnly: true,
                onTap: () {},
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: prescriptionCode,
                decoration: const InputDecoration(
                  labelText: 'Prescription Code',
                ),
                readOnly: true,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<CustomerModel>(
                decoration: const InputDecoration(
                  labelText: 'Choose Customer',
                ),
                value: selectedCustomer,
                style: const TextStyle(color: Colors.black),
                items: customers.map((CustomerModel customer) {
                  // print('customer: $customer');
                  return DropdownMenuItem<CustomerModel>(
                    value: customer,
                    child: Text(customer.name!),
                  );
                }).toList(),
                onChanged: (CustomerModel? value) {
                  selectedCustomer = value;
                },
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<DoctorModel>(
                decoration: const InputDecoration(
                  labelText: 'Select Doctor',
                ),
                value: selectedDoctor,
                style: const TextStyle(color: Colors.black),
                items: doctors.map((DoctorModel doctor) {
                  return DropdownMenuItem<DoctorModel>(
                    value: doctor,
                    child: Text(doctor.name!),
                  );
                }).toList(),
                onChanged: (DoctorModel? value) {
                  selectedDoctor = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  prescription = value;
                },
                maxLines: 5,
                decoration: const InputDecoration(
                    labelText: 'Prescription',
                    hintFadeDuration: Duration(seconds: 1),
                    alignLabelWithHint: true,
                    hintText: 'Write prescription here',
                    constraints: BoxConstraints(maxHeight: 150)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                title: const Text(
                  'Directly redeem this prescription?',
                  style: TextStyle(fontSize: 14),
                ),
                trailing: Switch(
                  value: isRedeem,
                  onChanged: (value) {
                    setState(() {
                      isRedeem = value;
                    });
                  },
                ),
              )
            ],
          )),
    );
  }

  void getCustomers() async {
    final response = await customerRepository.getCustomers();
    setState(() {
      customers = response;
    });
  }

  void getDoctors() async {
    final response = await doctorRepository.getDoctors();
    setState(() {
      doctors = response;
    });
  }

  void createPrescription() async {
    await prescriptionRepository.createPrescription({
      'prescriptionCode': prescriptionCode,
      'prescriptions': prescription,
      'prescriptionDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
      'doctorId': selectedDoctor!.id,
      'customerId': selectedCustomer!.id,
      'isRedeem': isRedeem,
    }).then((value) {
      Navigator.pop(context, true);
      CustomSnackbar.showSnackbar(context,
          title: 'Success!',
          message: 'Prescription created successfully',
          contentType: ContentType.success);
    }).catchError((e) {
      CustomSnackbar.showSnackbar(context,
          title: 'Failed!',
          message: 'Failed to create prescription',
          contentType: ContentType.failure);
    });
  }
}
