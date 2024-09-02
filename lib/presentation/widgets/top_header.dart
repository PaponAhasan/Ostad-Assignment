import 'package:flutter/material.dart';

class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'HUMMING \nBIRD .',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Text('Episodes'),
                SizedBox(
                  width: 30,
                ),
                Text('About'),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
