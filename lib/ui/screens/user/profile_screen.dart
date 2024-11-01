import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/ui/widgets/tm_app_bar.dart';

import '../../../data/models/login_model/user_model.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/snack_bar_message.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserModel? userdata;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _inProcessing = false;

  XFile? _selectedPhoto;

  @override
  void initState() {
    super.initState();
    _setUserData();
  }

  void _setUserData() async {
    userdata = AuthController.userData;
    _emailController.text = userdata?.email ?? '';
    _firstNameController.text = userdata?.firstName ?? '';
    _lastNameController.text = userdata?.lastName ?? '';
    _mobileNumberController.text = userdata?.mobile ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TMAppBar(isProfileScreen: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildPhotoSection,
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _emailController,
                  enabled: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _mobileNumberController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Visibility(
                  visible: !_inProcessing,
                  replacement: const CenterCircularProgressIndicator(),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _updateProfile();
                        }
                      },
                      child: const Icon(Icons.arrow_circle_right_outlined)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _buildPhotoSection => GestureDetector(
        onTap: _pickPhoto,
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 100,
                height: 50,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: const Text(
                  "Photo",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
              ),
              const SizedBox(width: 8),
              Text(_getSelectedPhotoName()),
            ],
          ),
        ),
      );

  Future<void> _pickPhoto() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? pickedImage =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedPhoto = pickedImage;
      });
    }
  }

  String _getSelectedPhotoName() {
    if (_selectedPhoto != null) {
      return _selectedPhoto!.name;
    }
    return 'Selected photo';
  }

  void _updateProfile() async {
    _inProcessing = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      'firstName': _firstNameController.text.trim(),
      'lastName': _lastNameController.text.trim(),
      'mobile': _mobileNumberController.text.trim(),
      'email': _emailController.text.trim(),
    };

    if (_passwordController.text.isNotEmpty) {
      requestBody['password'] = _passwordController.text;
    }

    if (_selectedPhoto != null) {
      List<int> imageBytes = await _selectedPhoto!.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      requestBody['photo'] = base64Image;
    }

    NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.updateProfile,
      body: requestBody,
    );
    _inProcessing = false;
    setState(() {});
    if (response.isSuccess) {
      UserModel userModel = UserModel.fromJson(requestBody);
      await AuthController.saveUserData(userModel);
      showSnackBarMessage(context, "Profile updated successfully");
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileNumberController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
