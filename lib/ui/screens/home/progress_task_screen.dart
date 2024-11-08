import 'package:flutter/material.dart';

import '../../../data/models/list_task/list_task_data.dart';
import '../../../data/models/list_task/list_task_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskInProgress = true;
  List<ListTaskData> _progressTaskList = [];

  @override
  void initState() {
    super.initState();
    _getProgressTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getProgressTaskList();
      },
      child: Visibility(
        visible: !_getProgressTaskInProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _progressTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskCard(
                listTaskData: _progressTaskList[index],
                onRefreshList: _getProgressTaskList,
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

  void _getProgressTaskList() async {
    _progressTaskList.clear();
    _getProgressTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getProgressTask);

    _getProgressTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final ListTaskModel listTaskModel =
      ListTaskModel.fromJson(response.responseData);
      _progressTaskList = listTaskModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
