import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Customer {
  final int id;
  final String name;

  Customer({required this.id, required this.name});
}

class Doctor {
  final int id;
  final String name;

  Doctor({required this.id, required this.name});
}

class PrescriptionForm extends StatefulWidget {
  const PrescriptionForm({super.key});

  @override
  State<PrescriptionForm> createState() => _PrescriptionFormState();
}

class _PrescriptionFormState extends State<PrescriptionForm> {
  bool isRedeem = false;
  Customer? selectedCustomer;
  final List<Customer> customers = [
    Customer(id: 1, name: 'Alvi'),
    Customer(id: 2, name: 'Dinda'),
    Customer(id: 3, name: 'Liza'),
  ];

  Doctor? selectedDoctor;
  final List<Doctor> doctors = [
    Doctor(id: 1, name: 'Dr. Dwi Arumsari'),
    Doctor(id: 2, name: 'Dr. Sinta Dewi'),
    Doctor(id: 3, name: 'Dr. Rizki'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Save Prescription'),
        ),
      ],
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            HugeIcons.strokeRoundedArrowLeft01,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text('Prescription Form'),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.all(0),
                visualDensity: VisualDensity.compact,
                title: Text(
                  "Fill Prescription Detail",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                subtitle: Text(
                    "Fill in required fields to fill prescription request"),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController()..text = '2024/10/22',
                decoration: InputDecoration(
                    labelText: 'Prescription Date',
                    suffixIcon: Icon(
                      HugeIcons.strokeRoundedCalendar01,
                      color: Colors.black,
                    )),
                readOnly: true,
                onTap: () {},
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: TextEditingController(text: 'PRE1001'),
                decoration: InputDecoration(
                  labelText: 'Prescription Code',
                ),
                readOnly: true,
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Customer>(
                decoration: InputDecoration(
                  labelText: 'Choose Customer',
                ),
                value: selectedCustomer,
                style: TextStyle(color: Colors.black),
                items: customers.map((Customer customer) {
                  return DropdownMenuItem<Customer>(
                    value: customer,
                    child: Text(customer.name),
                  );
                }).toList(),
                onChanged: (Customer? value) {
                  setState(() {
                    selectedCustomer = value;
                  });
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<Doctor>(
                decoration: InputDecoration(
                  labelText: 'Select Doctor',
                ),
                value: selectedDoctor,
                style: TextStyle(color: Colors.black),
                items: doctors.map((Doctor doctor) {
                  return DropdownMenuItem<Doctor>(
                    value: doctor,
                    child: Text(doctor.name),
                  );
                }).toList(),
                onChanged: (Doctor? value) {
                  setState(() {
                    selectedDoctor = value;
                  });
                },
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                    labelText: 'Prescription',
                    hintFadeDuration: Duration(seconds: 1),
                    alignLabelWithHint: true,
                    hintText: 'Write prescription here',
                    constraints: BoxConstraints(maxHeight: 150)),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                contentPadding: EdgeInsets.all(0),
                dense: true,
                title: Text(
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
}
