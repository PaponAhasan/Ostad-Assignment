import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/ui/screens/auth/reset_password_screen.dart';
import 'package:task_manager/ui/screens/auth/sign_in_screen.dart';
import 'package:task_manager/ui/utils/app_colors.dart';
import 'package:task_manager/ui/widgets/center_circular_progress_indicator.dart';

import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../widgets/screen_background.dart';
import '../../widgets/snack_bar_message.dart';

class ForgotPasswordOtpVerifyScreen extends StatefulWidget {
  const ForgotPasswordOtpVerifyScreen({super.key, required this.email});

  final String email;

  @override
  State<ForgotPasswordOtpVerifyScreen> createState() =>
      _ForgotPasswordOtpVerifyScreenState();
}

class _ForgotPasswordOtpVerifyScreenState
    extends State<ForgotPasswordOtpVerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _inProcessing = false;
  bool _isOtpVerified = false;

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
                  "Pin Verification",
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "A 6 digit verification pin has been send to your email address",
                  style: textTheme.titleSmall?.copyWith(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildForgotPasswordOtpForm(),
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

  Widget _buildForgotPasswordOtpForm() {
    return Column(
      children: [
        PinCodeTextField(
            length: 6,
            obscureText: false,
            animationType: AnimationType.fade,
            keyboardType: TextInputType.number,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
              inactiveFillColor: Colors.white,
              selectedFillColor: Colors.white,
              // activeColor: AppColors.themeColor,
              // selectedColor: AppColors.themeColor,
              // inactiveColor: AppColors.themeColor,
            ),
            animationDuration: const Duration(milliseconds: 300),
            backgroundColor: AppColors.transparentColor,
            enableActiveFill: true,
            appContext: context,
            controller: _otpController,
            /*onCompleted: (v) {
            setState(() {
              _inProcessing = true;
            });
          },*/
            onChanged: (value) {
              print(value);
              if (value.length == 6) {
                setState(() {
                  _isOtpVerified = true;
                });
              } else {
                setState(() {
                  _isOtpVerified = false;
                });
              }
            }),
        const SizedBox(
          height: 24,
        ),
        Visibility(
          visible: !_inProcessing,
          replacement: const CenterCircularProgressIndicator(),
          child: ElevatedButton(
            onPressed: _isOtpVerified ? _onTabNextButton : null,
            child: const Icon(Icons.arrow_circle_right_outlined),
          ),
        ),
      ],
    );
  }

  void _onTabNextButton() async {
    if (_otpController.text.length != 6) {
      setState(() {
        showSnackBarMessage(context, "Please enter the complete 6-digit OTP.");
      });
      return;
    }

    setState(() {
      _inProcessing = true;
    });

    final response = await NetworkCaller.getRequest(
      url: '${Urls.getVerifyOtp}/${widget.email}/${_otpController.text.trim()}',
    );

    setState(() {
      _inProcessing = false;
    });

    if (response.isSuccess) {
      showSnackBarMessage(
        context,
        'Verification Successful',
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            email: widget.email,
            otp: _otpController.text.trim(),
          ),
        ),
      );
    } else {
      showSnackBarMessage(
        context,
        response.errorMessage,
        true,
      );
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
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ),
      (route) => false,
    );
  }

  @override
  void dispose() {
    //_otpController.dispose();
    super.dispose();
  }
}
