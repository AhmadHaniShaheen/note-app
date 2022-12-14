import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_auth_controller.dart';
import 'package:secand_in_firebase/firebase/fb_notifications.dart';
import 'package:secand_in_firebase/utills/helpers.dart';

import '../../models/firebase_response.dart';

class LoginScreen extends StatefulWidget with Helper{
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with FbNotifications{
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();
    manageNotificationAction();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 33),
        child: ListView(
          children: [
            const Text(
              'Login Screen',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Enter to your account',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _emailEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _passwordEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                preformLogin();
              },
              child: const Text('LOGIN'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Don\'t have an account? '),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/register_screen');
                    },
                    child: Text('Register Now'))
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/forget_password_screen');
                    },
                    child: Text('forget password?')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void preformLogin() {
    if (checkData()) {
      _login();
    }
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required Data', error: true);
    return false;
  }

  void  _login() async {
    FirebaseResponse firebaseResponse=await FbAuthController().signIn(email: _emailEditingController.text, password: _passwordEditingController.text);
    showSnackBar(message: firebaseResponse.success? 'Login In Success':firebaseResponse.message,error: !firebaseResponse.success);
    if(firebaseResponse.success){
      Navigator.pushReplacementNamed(context, '/notes_screen');
    }
  }
}
