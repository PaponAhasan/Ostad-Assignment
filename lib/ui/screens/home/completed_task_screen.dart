import 'package:flutter/material.dart';

import '../../../data/models/list_task/list_task_data.dart';
import '../../../data/models/list_task/list_task_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getCompletedTaskInProgress = false;
  List<ListTaskData> _completedTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCompletedTaskList();
      },
      child: Visibility(
        visible: !_getCompletedTaskInProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _completedTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskCard(
                listTaskData: _completedTaskList[index],
                onRefreshList: _getCompletedTaskList,
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 8,
            );
          },
        ),
      ),
    );
  }

  void _getCompletedTaskList() async {
    _completedTaskList.clear();
    _getCompletedTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getCompletedTask);

    _getCompletedTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final ListTaskModel listTaskModel =
      ListTaskModel.fromJson(response.responseData);
      _completedTaskList = listTaskModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
