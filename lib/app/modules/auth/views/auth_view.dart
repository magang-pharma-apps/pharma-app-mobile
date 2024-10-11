import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/core_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isChecked = false;
  bool _isVisible = false;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final storage = GetStorage();

  void login() {
    final validUsername = "user";
    final validPassword = "123";

    if (username.text == validUsername && password.text == validPassword) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CoreView()),
      );
      storage.write('isLogin', true);
    }
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50),
                        border:
                            Border.all(width: 5, color: Colors.grey.shade100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          "Login Account",
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
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
                      ),
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
                            _isVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            size: 35.0,
                          ),
                        ),
                        label: Text('Password'),
                      ),
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
                        TextButton(
                            onPressed: () {}, child: Text("Forget Password"))
                      ],
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        child: const Text("Login",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        style:
                            ElevatedButton.styleFrom(minimumSize: Size(10, 60)))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
