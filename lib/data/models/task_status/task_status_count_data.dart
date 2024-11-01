class TaskStatusCountData {
  String? id;
  int? sum;

  TaskStatusCountData({
    this.id,
    this.sum,
  });

  TaskStatusCountData.fromJson(dynamic json) {
    id = json['_id'];
    sum = json['sum'];
  }

  TaskStatusCountData copyWith({
    String? id,
    int? sum,
  }) =>
      TaskStatusCountData(
        id: id ?? this.id,
        sum: sum ?? this.sum,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['sum'] = sum;
    return map;
  }
}