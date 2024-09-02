import 'package:extend_greeting_app/presentation/widgets/desktop_body.dart';
import 'package:flutter/material.dart';

import '../utils/style.dart';
import '../widgets/mobile_body.dart';
import '../widgets/nav_menu.dart';
import '../widgets/responsive_builder.dart';
import '../widgets/tablet_body.dart';
import '../widgets/top_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      // size for mobile
      mobile: _buildMobileLayout(context),
      // size for tablet
      tablet: _buildTabletLayout(context),
      // size for Desktop
      desktop: _buildDesktopLayout(context),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.15,
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            'HUMMING \nBIRD .',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
      drawer: const NavMenu(),
      body: const SingleChildScrollView(
        child: MobileBody(),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          TopHeader(),
          Expanded(
            child: TabletBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          TopHeader(),
          DesktopBody(),
        ],
      ),
    );
  }
}
