import 'package:task_manager/data/models/login_model/user_model.dart';

class LoginModel {
  LoginModel({
    this.status,
    this.userData,
    this.token,
  });

  LoginModel.fromJson(dynamic json) {
    status = json['status'];
    userData = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }

  String? status;
  UserModel? userData;
  String? token;

  LoginModel copyWith({
    String? status,
    UserModel? userData,
    String? token,
  }) =>
      LoginModel(
        status: status ?? this.status,
        userData: userData ?? this.userData,
        token: token ?? this.token,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (userData != null) {
      map['data'] = userData?.toJson();
    }
    map['token'] = token;
    return map;
  }
}