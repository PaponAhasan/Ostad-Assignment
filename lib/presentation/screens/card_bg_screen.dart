import 'package:flutter/material.dart';

import '../models/bag_data.dart';
import '../utils/style.dart';

class CardBgScreen extends StatefulWidget {
  const CardBgScreen({super.key});

  @override
  State<CardBgScreen> createState() => _CardBgScreenState();
}

class _CardBgScreenState extends State<CardBgScreen> {
  int counter = 0;

  void _incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void _decrementCounter() {
    if (counter == 0) return;
    counter--;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView.builder(
        itemBuilder: (context, index) {
          BagData bagData = bagDataList[index];

          return SizedBox(
            height: 120,
            child: Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        bagData.image,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            bagData.name,
                            style: textStyle(
                                color: Colors.black, size: 18, isBold: true),
                          ),
                          Row(
                            children: [
                              Text(
                                "Color: ",
                                style: textStyle(
                                    color: Colors.grey.shade500,
                                    size: 12,
                                    isBold: false),
                              ),
                              Text(
                                bagData.color,
                                style: textStyle(
                                    color: Colors.black,
                                    size: 12,
                                    isBold: false),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(
                                "Size: ",
                                style: textStyle(
                                    color: Colors.grey.shade500,
                                    size: 12,
                                    isBold: false),
                              ),
                              Text(
                                bagData.size,
                                style: textStyle(
                                    color: Colors.black,
                                    size: 12,
                                    isBold: false),
                              ),
                            ],
                          ),
                          Row(
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
                                    onPressed: () => _decrementCounter(),
                                    icon: const Icon(
                                      Icons.remove,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  counter.toString(),
                                  style: textStyle(
                                      color: Colors.black,
                                      size: 14,
                                      isBold: true),
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
                                    onPressed: () => _incrementCounter(),
                                    icon: const Icon(
                                      Icons.add,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Column(
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
                        Text(
                          "${double.tryParse(bagData.price)?.toStringAsFixed(2) ?? '0.00'}\$",
                          style: textStyle(
                              color: Colors.black, size: 16, isBold: true),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: bagDataList.length,
      ),
    );
  }
}
