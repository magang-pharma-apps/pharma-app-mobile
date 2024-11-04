import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class UserView extends StatefulWidget {
  const UserView({super.key});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  bool _pressEdit = false;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/images/user.png"),
                  ),
                  Text(
                    "John Doe",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    "Apoteker",
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Colors.grey.shade700),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _pressEdit ? Colors.green : Colors.teal),
                      onPressed: () {
                        setState(() {
                          _pressEdit = !_pressEdit;
                        });
                      },
                      label: Text(
                        _pressEdit ? "Save Change" : "Edit Profile",
                        style: TextStyle(fontSize: 12),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(top: 10, right: 10, left: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _pressEdit
                      ? TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "Input Name",
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)))
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "John Doe",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                  SizedBox(height: 8),
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _pressEdit
                      ? TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "Input Email",
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)))
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "johndoe@mail.com",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                  SizedBox(height: 8),
                  Text(
                    "Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _pressEdit
                      ? TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "Change Password",
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)))
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "************",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                  SizedBox(height: 8),
                  Text(
                    "Confirm Password",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  _pressEdit
                      ? TextFormField(
                          controller: _confirmPassController,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              hintText: "Confirm Password",
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey)))
                      : Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          child: Text(
                            "************",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                        ),
                  SizedBox(height: 8),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
