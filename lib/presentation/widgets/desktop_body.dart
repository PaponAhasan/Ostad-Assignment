import 'package:flutter/material.dart';

import '../utils/style.dart';

class DesktopBody extends StatelessWidget {
  const DesktopBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 70, 32, 32),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            flex: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                    "In this course we will go over the basic of using Flutter Web for development. "
                        "Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals and more. "),
              ],
            ),
          ),
          const Flexible(
            fit:  FlexFit.tight,
            flex: 20,
            child: SizedBox(
              width: 32,
            ),
          ),
          Flexible(
            flex: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: buttonStyle(),
              child: const Text('Join course'),
            ),
          )
        ],
      ),
    );
  }
}
