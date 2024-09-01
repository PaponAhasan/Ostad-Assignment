import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/style.dart';
import '../widgets/nav_menu.dart';
import '../widgets/responsive_builder.dart';

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
          ),
        ),
      ),
      drawer: const NavMenu(),
      body: SingleChildScrollView(
        child: mainBody(),
      ),
    );
  }

  Widget _buildTabletLayout(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topHeader(context),
          Expanded(
            child: mainBody(),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          topHeader(context),
          Expanded(
            child: desktopBody(),
          ),
        ],
      ),
    );
  }

  Widget topHeader(BuildContext context) {
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
                Expanded(child: Text('HUMMING \nBIRD .')),
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

  Widget mainBody() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "FLUTTER WEB.",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const Text(
              "THE BASICS",
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
                textAlign: TextAlign.center,
                "In this course we will go over the basic of using Flutter Web for development. "
                "Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals and more. "),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () {},
              style: buttonStyle,
              child: const Text('Join course'),
            )
          ],
        ),
      ),
    );
  }

  Widget mobileBody() {
    return Text("mobile");
  }

  Widget tabletBody() {
    return Text("tablet");
  }

  Widget desktopBody() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        children: [
          const Expanded(
            flex: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "FLUTTER WEB.",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                Text(
                  "THE BASICS",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                    "In this course we will go over the basic of using Flutter Web for development. "
                    "Topics will include Responsive Layout, Deploying, Font Changes, Hover functionality, Modals and more. "),
              ],
            ),
          ),
          const Expanded(
            flex: 20,
            child: SizedBox(
              width: 32,
            ),
          ),
          Expanded(
            flex: 30,
            child: ElevatedButton(
              onPressed: () {},
              style: buttonStyle,
              child: const Text('Join course'),
            ),
          )
        ],
      ),
    );
  }

  Widget textView(){
    return Text("hello");
  }
}
