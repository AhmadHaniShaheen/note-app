import 'package:flutter/material.dart';

class CodeTextField extends StatelessWidget {
  final FocusNode focusNodeNumber;
  final TextEditingController textController;
  final void Function(String value) onChanged;

  CodeTextField({
    required this.focusNodeNumber,
    required this.textController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: textController,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        focusNode: focusNodeNumber,
        onChanged: onChanged,
        style: TextStyle(fontSize: 25),
        decoration: const InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(color: Colors.blue, width: 1)),
        ),
      ),
    );
  }
}
