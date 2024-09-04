import 'package:flutter/material.dart';

import '../utils/style.dart';
import 'card_bg_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
          ),
          child: Text(
            'My Bag',
            style: textStyle(color: Colors.black, size: 30, isBold: true),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CardBgScreen(),
            _buildOnPrice(),
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

  Widget _buildOnPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Total amount:',
          style:
              textStyle(color: Colors.grey.shade500, size: 16, isBold: false),
        ),
        Text(
          '124\$',
          style: textStyle(color: Colors.black, size: 16, isBold: true),
        ),
      ],
    );
  }
}
