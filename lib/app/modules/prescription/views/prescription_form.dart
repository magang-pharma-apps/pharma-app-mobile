import 'dart:math';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/models/customer_model.dart';
import 'package:medpia_mobile/app/models/doctor_model.dart';
import 'package:medpia_mobile/app/modules/prescription/views/redemption_form.dart';
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
          child: Text(
            'Save Prescription',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
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
        title: Text('Prescription Form',
            style: Theme.of(context).textTheme.labelLarge),
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
                title: Text(
                  "Fill Prescription Detail",
                  style: Theme.of(context).textTheme.labelMedium,
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
                    hintText: 'Write prescription here...',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        fontWeight: FontWeight.w300),
                    constraints: BoxConstraints(maxHeight: 150)),
              ),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                visualDensity:
                    const VisualDensity(horizontal: -4.0, vertical: -4.0),
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                title: const Text(
                  'Directly redeem this prescription?',
                  style: TextStyle(fontSize: 12),
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

  // void createPrescription() async {
  //   await prescriptionRepository.createPrescription({
  //     'prescriptionCode': prescriptionCode,
  //     'prescriptions': prescription,
  //     'prescriptionDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
  //     'doctorId': selectedDoctor!.id,
  //     'customerId': selectedCustomer!.id,
  //     'isRedeem': isRedeem,
  //   }).then((value) {
  //     setState(() {
  //       Navigator.pop(context, true);
  //     });
  //     CustomSnackbar.showSnackbar(context,
  //         title: 'Success!',
  //         message: 'Prescription created successfully',
  //         contentType: ContentType.success);
  //   }).catchError((e) {
  //     CustomSnackbar.showSnackbar(context,
  //         title: 'Failed!',
  //         message: 'Failed to create prescription',
  //         contentType: ContentType.failure);
  //   });
  // }

  void createPrescription() async {
    try {
      await prescriptionRepository.createPrescription({
        'prescriptionCode': prescriptionCode,
        'prescriptions': prescription,
        'prescriptionDate': DateFormat('yyyy-MM-dd').format(DateTime.now()),
        'doctorId': selectedDoctor!.id,
        'customerId': selectedCustomer!.id,
        'isRedeem': isRedeem,
      });
      print('Value IsRedeem $isRedeem');

      if (isRedeem) {
        // If isRedeem is true, navigate to RedemptionForm and pass the result
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RedemptionForm(),
          ),
        );
      } else {
        // Otherwise, pop back and return true
        Navigator.pop(context, true);
      }

      // Show success snackbar
      CustomSnackbar.showSnackbar(
        context,
        title: 'Success!',
        message: 'Prescription created successfully',
        contentType: ContentType.success,
      );
    } catch (e) {
      // Show failure snackbar if there's an error
      CustomSnackbar.showSnackbar(
        context,
        title: 'Failed!',
        message: 'Failed to create prescription',
        contentType: ContentType.failure,
      );
    }
  }
}
