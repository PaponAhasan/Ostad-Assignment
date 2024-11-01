import 'package:task_manager/data/models/task_status/task_status_count_data.dart';

class TaskStatusCountModel {
  String? status;
  List<TaskStatusCountData>? taskStatusCountList;

  TaskStatusCountModel({
    this.status,
    this.taskStatusCountList,
  });

  TaskStatusCountModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      taskStatusCountList = [];
      json['data'].forEach((v) {
        taskStatusCountList?.add(TaskStatusCountData.fromJson(v));
      });
    }
  }

  TaskStatusCountModel copyWith({
    String? status,
    List<TaskStatusCountData>? taskStatusCountList,
  }) =>
      TaskStatusCountModel(
        status: status ?? this.status,
        taskStatusCountList: taskStatusCountList ?? this.taskStatusCountList,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (taskStatusCountList != null) {
      map['data'] = taskStatusCountList?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
