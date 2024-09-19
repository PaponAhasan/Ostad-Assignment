import 'package:ecommerce_admin/screens/product_list_screen.dart';
import 'package:flutter/material.dart';

class CurdApp extends StatelessWidget {
  const CurdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}
