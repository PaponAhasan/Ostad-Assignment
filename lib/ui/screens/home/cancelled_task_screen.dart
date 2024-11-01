import 'package:flutter/material.dart';

import '../../../data/models/list_task/list_task_data.dart';
import '../../../data/models/list_task/list_task_model.dart';
import '../../../data/models/network_response.dart';
import '../../../data/services/network_caller.dart';
import '../../../data/util/urls.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/snack_bar_message.dart';
import '../../widgets/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskInProgress = false;
  List<ListTaskData> _cancelledTaskList = [];

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        _getCancelledTaskList();
      },
      child: Visibility(
        visible: !_getCancelledTaskInProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: ListView.separated(
          itemCount: _cancelledTaskList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskCard(
                listTaskData: _cancelledTaskList[index],
                onRefreshList: _getCancelledTaskList,
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

  void _getCancelledTaskList() async {
    _cancelledTaskList.clear();
    _getCancelledTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
    await NetworkCaller.getRequest(url: Urls.getCancelledTask);

    _getCancelledTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final ListTaskModel listTaskModel =
      ListTaskModel.fromJson(response.responseData);
      _cancelledTaskList = listTaskModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
