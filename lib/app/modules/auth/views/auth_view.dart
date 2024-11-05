import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/commons/ui/widgets/custom_snackbar.dart';
import 'package:medpia_mobile/app/core_view.dart';
import 'package:http/http.dart' as http;
import 'package:medpia_mobile/app/providers/auth_provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  String? _usernameErr;
  String? _passwordErr;
  bool _isChecked = false;
  bool _isVisible = false;
  bool _isLoading = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final storage = GetStorage();
  final AuthProvider authProvider = AuthProvider();

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _usernameErr = null;
      _passwordErr = null;
    });

    if (username.text.isEmpty) {
      setState(() {
        _usernameErr = 'Please enter your username';
        _isLoading = false;
      });
    }

    if (password.text.isEmpty) {
      setState(() {
        _passwordErr = 'Please enter your password';
        _isLoading = false;
      });
    } else if (password.text.length < 8) {
      setState(() {
        _passwordErr = 'Password must be at least 8 characters';
        _isLoading = false;
      });
    }

    try {
      // request ke url

      final response = await authProvider.login(username.text, password.text);
      // print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = json.decode(response.body)['accessToken'];
        // print('tokennya: $token');

        storage.write('accessToken', token); // simpan token ke storage
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CoreView()),
          );
          CustomSnackbar.showSnackbar(context,
              title: 'Success!',
              message: 'Congratulation. Successfully Login Account!',
              contentType: ContentType.success);
        }
      } else if (response.statusCode == 404 ||
          response.statusCode == 401 ||
          response.statusCode == 400 &&
              username.text.isNotEmpty &&
              password.text.isNotEmpty) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          CustomSnackbar.showSnackbar(context,
              title: 'Failed!',
              message: 'Username or password is incorrect!',
              contentType: ContentType.failure);
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error Login $e');
      CustomSnackbar.showSnackbar(context,
          title: 'Error!',
          message: 'Something went wrong!',
          contentType: ContentType.failure);
    }

    // bikin url
  }

  void _togglePassword() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  void _handleCheckbox() {
    setState(() {
      _isChecked = !_isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 100, left: 20, right: 20),
            child: Text("Go ahead and set up your account",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              "Log In to Stay in Control of Your Stock Anytime, Anywhere!",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey.shade300),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(width: 5, color: Colors.grey.shade100),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Login Account",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: username,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(30),
                      hintText: 'johndoe@mail.com',
                      prefixIcon: Icon(
                        Icons.person_outline,
                        size: 35.0,
                      ),
                      label: Text('Username or email'),
                      errorText: _usernameErr),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: password,
                  obscureText: _isVisible == false,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(30),
                      hintText: 'password',
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 35.0,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          _togglePassword();
                        },
                        child: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          size: 35.0,
                        ),
                      ),
                      label: Text('Password'),
                      errorText: _passwordErr),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isChecked,
                      onChanged: (value) {
                        _handleCheckbox();
                      },
                    ),
                    Text("Remember me",
                        style: Theme.of(context).textTheme.bodyMedium),
                    Spacer(),
                    TextButton(onPressed: () {}, child: Text("Forget Password"))
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _isLoading ? null : _login();
                    },
                    child: _isLoading
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : const Text("Login",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(minimumSize: Size(10, 60)))
              ],
            ),
          )
        ],
      ),
    );
  }
}
