import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/data/util/urls.dart';
import 'package:task_manager/ui/screens/auth/forgot_password_otp_verify_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';

class ForgotPasswordEmailScreen extends StatefulWidget {
  const ForgotPasswordEmailScreen({super.key});

  @override
  State<ForgotPasswordEmailScreen> createState() =>
      _ForgotPasswordEmailScreenState();
}

class _ForgotPasswordEmailScreenState extends State<ForgotPasswordEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
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
                  "Your Email Address",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "A 6 digit verification pin will send to your email address",
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildForgotPasswordForm(),
                const SizedBox(
                  height: 48,
                ),
                Center(
                  child: _buildSignInSection(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm() {
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
                return "Please enter email";
              } else if (!value.contains("@")) {
                return "Please enter valid email";
              } else {
                return null;
              }
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
      _recoveryEmail();
    }
  }

  void _recoveryEmail() async {
    _inProcessing = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: '${Urls.getEmailRecovery}/${_emailController.text.trim()}',
    );

    _inProcessing = false;
    setState(() {});

    if (response.isSuccess) {
      showSnackBarMessage(
        context,
        'A 6 digit verification pin will send to your email address',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForgotPasswordOtpVerifyScreen(
            email: _emailController.text.trim(),
          ),
        ),
      );
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Widget _buildSignInSection() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        text: "Have an account? ",
        children: [
          TextSpan(
            text: "Sign In",
            style: const TextStyle(
              color: AppColors.themeColor,
            ),
            recognizer: TapGestureRecognizer()..onTap = _onTabSignIn,
          )
        ],
      ),
    );
  }

  void _onTabSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
