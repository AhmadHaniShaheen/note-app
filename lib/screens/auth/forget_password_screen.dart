
import 'package:flutter/material.dart';
import 'package:secand_in_firebase/firebase/fb_auth_controller.dart';
import 'package:secand_in_firebase/models/firebase_response.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();

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
              'Forget Password? ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Enter to your email',
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
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                preformForgetPassword();
              },
              child: Text('SEND CODE'),
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }

  void preformForgetPassword() {
    if (checkData()) {
      _forgetPassword();
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
    if (_emailEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter your email', error: true);
    return false;
  }

  void _forgetPassword() async {
    FirebaseResponse firebaseResponse=await FbAuthController().sendPasswordAndRestEmail(email: _emailEditingController.text);
    if(firebaseResponse.success){
    showSnackBar(message: firebaseResponse.message);
    Navigator.pop(context);
    }
  }
}
