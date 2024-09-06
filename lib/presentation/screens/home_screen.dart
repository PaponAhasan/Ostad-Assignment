import 'package:flutter/material.dart';

import '../models/bag_data.dart';
import '../utils/style.dart';
import 'card_bg_screen.dart';
import 'cart_price_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void onPriceChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Text(
            'Shopping Cart',
            style: textStyle(color: Colors.black, size: 30, isBold: true),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CardBgScreen(onPriceChange : onPriceChange),
            CartPriceScreen(),
            const SizedBox(
              height: 12,
            ),
            _buildOnCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildOnCheckoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          SnackBar snackBar = const SnackBar(
            content: Text('Congratulations! Your order has been placed.'),
            backgroundColor: Colors.green,
            showCloseIcon: true,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        style: buttonStyle(),
        child: const Text('CHECK OUT'),
      ),
    );
  }
}
