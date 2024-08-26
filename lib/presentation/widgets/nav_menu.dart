import 'package:flutter/material.dart';

class NavMenu extends StatelessWidget {
  const NavMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            /* Header */
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              color: const Color.fromARGB(255, 27, 221, 150),
              // Sets the header color
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Header Header Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(width: 16),
                  Text(
                    'Header',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            /* List Items */
            const ListTile(
              leading: Icon(Icons.person),
              title: Text(
                'Profile',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Settings',
              ),
              tileColor: Colors.grey.shade300,
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}

class NavMenu2 extends StatelessWidget {
  const NavMenu2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.25,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const ListTile(
            leading: Icon(Icons.person),
            title: Text(
              'Profile',
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Settings',
            ),
            tileColor: Colors.grey.shade300,
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

