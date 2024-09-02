import 'package:flutter/material.dart';

import '../utils/style.dart';

class TabletBody extends StatelessWidget {
  const TabletBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          children: [
            Text(
              "FLUTTER WEB.",
              style: textStyle(),
            ),
            Text(
              "THE BASICS",
              style: textStyle(),
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
                textAlign: TextAlign.center,
                style: textStyle2(),
                "In this course we will go over the basic of using Flutter Web for development. "
                    "Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals and more. "),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {},
              style: buttonStyle(),
              child: const Text('Join course'),
            )
          ],
        ),
      ),
    );
  }
}