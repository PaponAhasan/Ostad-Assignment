import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Drawer(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /* Header */
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                color: const Color.fromARGB(255, 27, 221, 150),
                // Sets the header color
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'SKILL UP NOW',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'TAP HERE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              /* List Items */
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.05,
                  horizontal: screenHeight * 0.02, // Added horizontal padding
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.movie_filter_outlined),
                      title: const Text(
                        'Episodes',
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    ListTile(
                      leading: const Icon(Icons.message),
                      title: const Text(
                        'About',
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
