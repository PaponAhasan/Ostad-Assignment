class ListTaskData {
  String? id;
  String? title;
  String? description;
  String? status;
  String? email;
  String? createdDate;

  ListTaskData({
    this.id,
    this.title,
    this.description,
    this.status,
    this.email,
    this.createdDate,
  });

  ListTaskData.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
    email = json['email'];
    createdDate = json['createdDate'];
  }

  ListTaskData copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? email,
    String? createdDate,
  }) =>
      ListTaskData(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        email: email ?? this.email,
        createdDate: createdDate ?? this.createdDate,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['status'] = status;
    map['email'] = email;
    map['createdDate'] = createdDate;
    return map;
  }
}
