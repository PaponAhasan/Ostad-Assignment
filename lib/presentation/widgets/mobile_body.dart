import 'package:flutter/material.dart';

import '../utils/style.dart';

class MobileBody extends StatelessWidget {
  const MobileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                style: textStyle2(),
                textAlign: TextAlign.center,
                "In this course we will go over the basic of using Flutter Web for development. "
                    "Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals and more. "),
            const SizedBox(
              height: 32,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: buttonStyle(),
                child: const Text('Join course'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
