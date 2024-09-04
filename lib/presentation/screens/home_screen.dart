import 'package:flutter/material.dart';

import '../utils/style.dart';

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
            Flexible(
              child: ListView.builder(
                itemBuilder: (context, index) => _bagCardView(),
                itemCount: 3,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total amount:',
                  style: textStyle(
                      color: Colors.grey.shade500, size: 16, isBold: false),
                ),
                Text(
                  '124\$',
                  style: textStyle(color: Colors.black, size: 16, isBold: true),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  SnackBar snackBar = const SnackBar(
                    content:
                        Text('Congratulations! Your order has been placed.'),
                    backgroundColor: Colors.green,
                    showCloseIcon: true,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                style: buttonStyle(),
                child: const Text('CHECK OUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bagCardView() {
    return SizedBox(
      height: 120,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           Row(
             children: [
               Image.asset(
                 'images/ic_shirt.jpg',
                 fit: BoxFit.cover,
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Text(
                     "Pull Over",
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
                         "Black",
                         style: textStyle(
                             color: Colors.black, size: 12, isBold: false),
                       ),
                       const SizedBox(width: 12,),
                       Text(
                         "Size: ",
                         style: textStyle(
                             color: Colors.grey.shade500, size: 12, isBold: false),
                       ),
                       Text(
                         "L",
                         style: textStyle(
                             color: Colors.black, size: 12, isBold: false),
                       ),
                     ],
                   ),
                   Row(
                     children: [
                       Material(
                         elevation: .5, // Set the elevation to add a shadow effect
                         shape: const CircleBorder(), // Ensure the shape remains circular
                         color: Colors.transparent, // Set to transparent if you want the circle's background to control the color
                         child: CircleAvatar(
                           backgroundColor: Colors.white, // Background color of the circle
                           child: IconButton(
                             color: Colors.grey,
                             onPressed: () {},
                             icon: const Icon(
                               Icons.remove,
                             ),
                           ),
                         ),
                       ),
                       const Padding(
                         padding: EdgeInsets.symmetric(horizontal: 12.0),
                         child: Text('1'),
                       ),
                       Material(
                         elevation: .5, // Set the elevation to add a shadow effect
                         shape: const CircleBorder(), // Ensure the shape remains circular
                         color: Colors.transparent, // Set to transparent if you want the circle's background to control the color
                         child: CircleAvatar(
                           backgroundColor: Colors.white, // Background color of the circle
                           child: IconButton(
                             color: Colors.grey,
                             onPressed: () {},
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
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      color: Colors.grey,
                      Icons.more_vert,
                    ),
                  ),
                  Text(
                    "51\$",
                    style: textStyle(color: Colors.black, size: 16, isBold: true),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// ListTile(
// title: Text("Title"),
// subtitle: Text("Sub Title"),
// trailing: Column(
// mainAxisSize: MainAxisSize.max,
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// IconButton(
// onPressed: () {},
// icon: const Icon(
// Icons.more_vert,
// ),
// ),
// Text("51\$", style: textStyle(color: Colors.black, size: 16, isBold: true),),
// ],
// ),
// leading: Image.asset(
// 'images/ic_shirt.jpg',
// fit: BoxFit.cover,
// ),
// ),
}
