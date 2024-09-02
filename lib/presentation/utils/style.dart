import 'package:flutter/material.dart';

ButtonStyle buttonStyle() => ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  minimumSize: const Size(0, 45),
  backgroundColor: const Color.fromARGB(255, 11, 207, 135),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

TextStyle textStyle() => const TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w900,
  fontFamily: 'Poppins',
);

TextStyle textStyle2() => const TextStyle(
  fontWeight: FontWeight.w500,
  fontFamily: 'Poppins',
);

