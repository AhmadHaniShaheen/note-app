import 'package:flutter/material.dart';
import 'package:secand_in_firebase/widgets/text_feild_code.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _confirmationPasswordEditingController;

  late TextEditingController _firstCodeTextController;
  late TextEditingController _secondCodeTextController;
  late TextEditingController _thirdCodeTextController;
  late TextEditingController _fourthCodeTextController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _fourthFocusNode;

  String _code = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newPasswordEditingController = TextEditingController();
    _confirmationPasswordEditingController = TextEditingController();
    _firstCodeTextController = TextEditingController();
    _secondCodeTextController = TextEditingController();
    _thirdCodeTextController = TextEditingController();
    _fourthCodeTextController = TextEditingController();
    _firstFocusNode = FocusNode();
    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _fourthFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _newPasswordEditingController.dispose();
    _confirmationPasswordEditingController.dispose();
    _firstCodeTextController.dispose();
    _secondCodeTextController.dispose();
    _thirdCodeTextController.dispose();
    _fourthCodeTextController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _fourthFocusNode.dispose();

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
              'Rest Password',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Enter the required data',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              children: [
                CodeTextField(
                  focusNodeNumber: _firstFocusNode,
                  textController: _firstCodeTextController,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                CodeTextField(
                  focusNodeNumber: _secondFocusNode,
                  textController: _secondCodeTextController,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _thirdFocusNode.requestFocus();
                    } else {
                      _firstFocusNode.requestFocus();
                    }
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                CodeTextField(
                  focusNodeNumber: _thirdFocusNode,
                  textController: _thirdCodeTextController,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      _fourthFocusNode.requestFocus();
                    } else {
                      _secondFocusNode.requestFocus();
                    }
                  },
                ),
                SizedBox(
                  width: 8,
                ),
                CodeTextField(
                  focusNodeNumber: _fourthFocusNode,
                  textController: _fourthCodeTextController,
                  onChanged: (String value) {
                    if (value.isEmpty) {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            TextField(
              controller: _newPasswordEditingController,
              keyboardType: TextInputType.text,
              obscuringCharacter: '*',
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'New Password',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _confirmationPasswordEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: const InputDecoration(
                hintText: 'Confirm Password',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                preformRestPassword();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('REST PASSWORD'),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),

    );
  }
  void preformRestPassword() {
    if (checkData() && checkCode()) {
      _RestPassword();
      showSnackBar(message: 'Now your reset your password!', error: false);
      print('true');
    }
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }

  bool checkCode() {
    _code = _firstCodeTextController.text +
        _secondCodeTextController.text +
        _thirdCodeTextController.text +
        _fourthCodeTextController.text;
    if (_code.length != 4) {
      showSnackBar(message: 'Enter your code', error: true);
      return false;
    }
    return true;
  }

  bool checkAllData() {
    if (checkData() && checkCode()) {
      print('true ture');
      return true;
    }
    return false;
  }

  bool checkData() {
    if (_newPasswordEditingController.text.isNotEmpty &&
        _newPasswordEditingController.text.isNotEmpty) {
      if (_newPasswordEditingController.text ==
          _confirmationPasswordEditingController.text) {
        return true;
      } else {
        showSnackBar(
            message: 'Confirm Password and Password is not the same',
            error: true);
        return false;
      }
    } else {
      showSnackBar(message: 'Enter required Data', error: true);
      return false;
    }
  }

  bool checkConfirmData() {
    if (_newPasswordEditingController.text ==
        _confirmationPasswordEditingController.text) {
      return true;
    }
    showSnackBar(
        message: 'Confirm Password and Password is not the same', error: true);
    return false;
  }

  void _RestPassword() async {}
}
