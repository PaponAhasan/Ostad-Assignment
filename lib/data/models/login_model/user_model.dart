class UserModel {
  String? id;
  String? email;
  String? firstName;
  String? lastName;
  String? mobile;
  String? photo;
  String? createdDate;

  UserModel({
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.mobile,
    this.photo,
    this.createdDate,
  });

  String get fullName => "${firstName ?? ''} ${lastName ?? ''}".trim();

  UserModel.fromJson(dynamic json) {
    id = json['_id'];
    email = json['email'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    mobile = json['mobile'];
    photo = json['photo'];
    createdDate = json['createdDate'];
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    String? mobile,
    String? photo,
    String? createdDate,
  }) =>
      UserModel(
        id: id ?? this.id,
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        mobile: mobile ?? this.mobile,
        photo: photo ?? this.photo,
        createdDate: createdDate ?? this.createdDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['email'] = email;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['mobile'] = mobile;
    map['photo'] = photo;
    map['createdDate'] = createdDate;
    return map;
  }
}
