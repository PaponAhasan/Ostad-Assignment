import 'package:flutter/material.dart';

import '../widgets/nav_menu.dart';
import '../widgets/responsive_builder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      // size for mobile
        mobile: _buildMobileLayout(),
        // size for tablet
        tablet: _buildTabletLayout(context),
        // size for Desktop
        desktop: _buildDesktopLayout(),);
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
        ),
      ),
      drawer: const NavMenu(),
      body: Text('Mobile'),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
            child: const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 30,),
                Expanded(child: Text('Tablet')),
                Text('Tablet'),
                SizedBox(width: 30,),
                Text('Tablet'),
                SizedBox(width: 30,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Text('Desktop'),
    );
  }

}

