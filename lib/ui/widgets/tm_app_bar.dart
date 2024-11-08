import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/data/models/login_model/user_model.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';

import '../controllers/auth_controller.dart';
import '../screens/user/profile_screen.dart';
import '../utils/app_colors.dart';

class TMAppBar extends StatefulWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreen = false,
  });

  final bool isProfileScreen;

  @override
  State<TMAppBar> createState() => _TMAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TMAppBarState extends State<TMAppBar> {

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: AuthController.userNotifier,
        builder: (context, userData, child) {
          return GestureDetector(
            onTap: () {
              if (widget.isProfileScreen) return;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileScreen()));
            },
            child: AppBar(
              backgroundColor: AppColors.themeColor,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    //backgroundImage: AssetImage('assets/images/user.jpg'),
                    backgroundImage: Image.memory(
                            base64Decode(userData?.photo ?? ''),
                            fit: BoxFit.cover).image,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userData?.fullName ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          userData?.email ?? '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      await AuthController.clearAuthDetails();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInScreen()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
