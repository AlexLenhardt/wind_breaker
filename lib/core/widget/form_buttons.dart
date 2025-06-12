import 'package:flutter/material.dart';

Widget formButton(Function() onPressed, String buttonText) {
  return TextButton(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all<Color>(
        const Color.fromARGB(90, 154, 210, 218),
      ),
      textStyle: WidgetStatePropertyAll(TextStyle(fontSize: 15)),
    ),
    onPressed: onPressed,
    child: Text(buttonText, style: TextStyle(color: Colors.black)),
  );
}
