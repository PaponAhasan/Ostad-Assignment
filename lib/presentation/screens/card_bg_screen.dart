import 'package:flutter/material.dart';

import '../models/bag_data.dart';
import '../utils/style.dart';

class CardBgScreen extends StatefulWidget {
  final VoidCallback onPriceChange;

  const CardBgScreen({super.key, required this.onPriceChange});

  @override
  State<CardBgScreen> createState() => _CardBgScreenState();
}

class _CardBgScreenState extends State<CardBgScreen> {

  void _onTabToProductIncrement(int index) {
    cartDataList[index].perCount += 1;
    _onAddToPerProductPrice(index);
    setState(() {});
  }

  void _onTabToProductDecrement(int index) {
    if (cartDataList[index].perCount == 0) return;
    cartDataList[index].perCount -= 1;
    _onAddToPerProductPrice(index);
    setState(() {});
  }

  void _onAddToPerProductPrice(int index) {
    int perCount = cartDataList[index].perCount;
    double perPrice = cartDataList[index].price;
    cartDataList[index].perTotalPrice = perCount * perPrice;
    widget.onPriceChange(); // Trigger the callback on price change
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return SizedBox(
            height: 120,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildShoppingDetails(index),
                    _buildShoppingPrice(index)
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: cartDataList.length,
      ),
    );
  }

  Widget _buildShoppingPrice(int index) {

    CartData bagData = cartDataList[index];

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            color: Colors.grey,
            Icons.more_vert,
          ),
          padding: EdgeInsets.zero,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            "${bagData.price}\$",
            style: textStyle(color: Colors.black, size: 14, isBold: true),
          ),
        ),
      ],
    );
  }

  Widget _buildShoppingDetails(int index) {
    CartData bagData = cartDataList[index];

    return Row(
      children: [
        Image.asset(
          bagData.image,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bagData.name,
              style: textStyle(color: Colors.black, size: 18, isBold: true),
            ),
            Row(
              children: [
                Text(
                  "Color: ",
                  style: textStyle(
                      color: Colors.grey.shade500, size: 12, isBold: false),
                ),
                Text(
                  bagData.color,
                  style: textStyle(color: Colors.black, size: 12, isBold: true),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  "Size: ",
                  style: textStyle(
                      color: Colors.grey.shade500, size: 12, isBold: false),
                ),
                Text(
                  bagData.size,
                  style: textStyle(color: Colors.black, size: 12, isBold: true),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            _buildOnShoppingCounter(index)
          ],
        ),
      ],
    );
  }

  Widget _buildOnShoppingCounter(int index) {
    CartData cartData = cartDataList[index];

    return Row(
      children: [
        Material(
          elevation: .5,
          // Set the elevation to add a shadow effect
          shape: const CircleBorder(),
          // Ensure the shape remains circular
          color: Colors.transparent,
          // Set to transparent if you want the circle's background to control the color
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // Background color of the circle
            child: IconButton(
              color: Colors.grey,
              onPressed: () => _onTabToProductDecrement(index),
              icon: const Icon(
                Icons.remove,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            '${cartData.perCount}',
            style: textStyle(color: Colors.black, size: 14, isBold: true),
          ),
        ),
        Material(
          elevation: .5,
          // Set the elevation to add a shadow effect
          shape: const CircleBorder(),
          // Ensure the shape remains circular
          color: Colors.transparent,
          // Set to transparent if you want the circle's background to control the color
          child: CircleAvatar(
            backgroundColor: Colors.white,
            // Background color of the circle
            child: IconButton(
              color: Colors.grey,
              onPressed: () => _onTabToProductIncrement(index),
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
