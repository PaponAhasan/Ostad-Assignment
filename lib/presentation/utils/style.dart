import 'package:flutter/material.dart';

ButtonStyle buttonStyle() => ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.red.shade500,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(24.0),
        ),
      ),
    );

TextStyle textStyle({color, size, isBold}) => TextStyle(
      fontSize: size,
      fontWeight: isBold ? FontWeight.w900 : FontWeight.w400,
      fontFamily: 'Poppins',
      color: color,
    );
