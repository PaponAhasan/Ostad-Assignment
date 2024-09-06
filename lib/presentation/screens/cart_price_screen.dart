import 'package:flutter/material.dart';

import '../models/bag_data.dart';
import '../utils/style.dart';

class CartPriceScreen extends StatefulWidget {
  CartPriceScreen({super.key});

  @override
  State<CartPriceScreen> createState() => _CartPriceScreenState();
}

class _CartPriceScreenState extends State<CartPriceScreen> {

  double _onCardTotalPrice() {
    double totalPrice = 0;
    for (CartData bagData in cartDataList) {
      totalPrice += bagData.perTotalPrice ?? 0.0;
    }
    setState(() {});
    return totalPrice;
  }

  @override
  Widget build(BuildContext context) {
    String totalPrice = _onCardTotalPrice().toStringAsFixed(2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total amount:',
            style:
                textStyle(color: Colors.grey.shade500, size: 16, isBold: false),
          ),
          Text(
            '${totalPrice.toString()}\$',
            style: textStyle(color: Colors.black, size: 16, isBold: true),
          ),
        ],
      ),
    );
  }
}
