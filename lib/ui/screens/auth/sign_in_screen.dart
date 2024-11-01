import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/models/login_model/login_model.dart';
import 'package:task_manager/data/models/login_model/user_model.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/screens/auth/sign_up_screen.dart';
import 'package:task_manager/ui/screens/home/main_bottom_nav_bar_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';
import 'forgot_password_email_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _inProcessing = false;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 82,
                ),
                Text(
                  "Get started with",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSignInForm(),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: _onTabForgotPassword,
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      _buildSignUpSection()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(hintText: "Password"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 24,
          ),
          Visibility(
            visible: !_inProcessing,
            replacement: const CenterCircularProgressIndicator(),
            child: ElevatedButton(
              onPressed: _onTabNextButton,
              child: const Icon(Icons.arrow_circle_right_outlined),
            ),
          ),
        ],
      ),
    );
  }

  void _onTabNextButton() {
    if (_formKey.currentState!.validate()) {
      _signIn();
    }
  }

  Future<void> _signIn() async {
    _inProcessing = true;
    Map<String, dynamic> requestBody = {
      "email": _emailController.text.trim(),
      "password": _passwordController.text,
    };
    setState(() {});

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.login,
      body: requestBody,
    );

    _inProcessing = false;
    setState(() {});

    if (response.isSuccess) {
      _clearTextFields();
      await _saveUserDetails(response);
      showSnackBarMessage(context, "SignIn Successful");
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => const MainBottomNavBarScreen()),
          (route) => false);
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _saveUserDetails(NetworkResponse response) async{
    LoginModel loginModel = LoginModel.fromJson(response.responseData);
    UserModel userModel = loginModel.userData!;
    await AuthController.saveAccessToken(loginModel.token!);
    await AuthController.saveUserData(userModel);
  }

  void _clearTextFields() {
    _emailController.clear();
    _passwordController.clear();
  }

  void _onTabForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ForgotPasswordEmailScreen(),
      ),
    );
  }

  Widget _buildSignUpSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        text: "Don't have an account? ",
        children: [
          TextSpan(
            text: "Sign Up",
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTabSignUp,
          )
        ],
      ),
    );
  }

  void _onTabSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
