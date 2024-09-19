import 'package:flutter/material.dart';

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
    hintText: hintText,
    fillColor: Colors.white,
    filled: true,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 1.0,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Colors.green,
        width: 1.0,
      ),
    ),
  );
}

ButtonStyle appButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    shape: const StadiumBorder(),
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    textStyle: const TextStyle(fontSize: 16.0),
    elevation: 4.0,
    shadowColor: Colors.green,
    fixedSize: const Size.fromWidth(double.maxFinite),
    minimumSize: const Size.fromHeight(48.0),
  );
}