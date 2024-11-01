import 'package:task_manager/data/models/list_task/list_task_data.dart';

class ListTaskModel {
  String? status;
  List<ListTaskData>? taskList;

  ListTaskModel({
    this.status,
    this.taskList,
  });

  ListTaskModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      taskList = [];
      json['data'].forEach((v) {
        taskList?.add(ListTaskData.fromJson(v));
      });
    }
  }

  ListTaskModel copyWith({
    String? status,
    List<ListTaskData>? taskList,
  }) =>
      ListTaskModel(
        status: status ?? this.status,
        taskList: taskList ?? this.taskList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (taskList != null) {
      map['data'] = taskList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
