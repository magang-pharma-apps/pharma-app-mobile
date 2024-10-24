import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:medpia_mobile/app/commons/ui/theme.dart';
import 'package:medpia_mobile/app/core_view.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _login() async {
    final url = Uri.parse('http://192.168.1.12:3000/auth/login');
    try {
      // request ke url

      final response = await http.post(url, body: {
        "username": username.value.text,
        "password": password.value.text
      });
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CoreView()),
          );
        }
        storage.write('isLogin', true);
      }
    } catch (e) {
      print(e);
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
          Container(
            height: MediaQuery.of(context).size.height * 0.785,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
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
                        _isVisible ? Icons.visibility : Icons.visibility_off,
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
                    TextButton(onPressed: () {}, child: Text("Forget Password"))
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () {
                      _login();
                    },
                    child: const Text("Login",
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
