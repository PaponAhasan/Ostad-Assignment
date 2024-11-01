import 'package:flutter/material.dart';
import 'package:task_manager/data/models/list_task/list_task_data.dart';
import 'package:task_manager/data/models/network_response.dart';
import 'package:task_manager/data/models/task_status/task_status_count_data.dart';
import 'package:task_manager/data/models/task_status/task_status_count_model.dart';
import 'package:task_manager/data/util/urls.dart';
import 'package:task_manager/ui/screens/home/add_new_task_screen.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../../data/models/list_task/list_task_model.dart';
import '../../../data/services/network_caller.dart';
import '../../widgets/center_circular_progress_indicator.dart';
import '../../widgets/task_card.dart';
import '../../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getNewTaskInProgress = false;
  List<ListTaskData> _newTaskList = [];

  bool _getTaskStatusCountInProgress = false;
  List<TaskStatusCountData> _taskStatusCount = [];

  @override
  void initState() {
    super.initState();
    _getNewTaskList();
    _getTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          _getNewTaskList();
          _getTaskStatusCount();
        },
        child: Column(
          children: [
            buildSummarySection(),
            Expanded(
              child: Visibility(
                visible: !_getNewTaskInProgress,
                replacement: const CenterCircularProgressIndicator(),
                child: ListView.separated(
                  itemCount: _newTaskList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TaskCard(
                        listTaskData: _newTaskList[index],
                        onRefreshList: () {
                          _getNewTaskList();
                          _getTaskStatusCount();
                        },
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabAddFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSummarySection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Visibility(
        visible: !_getTaskStatusCountInProgress,
        replacement: const CenterCircularProgressIndicator(),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ..._taskStatusCount.map(
                (task) => TaskSummaryCard(
                  title: task.id!,
                  count: task.sum ?? 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onTabAddFAB() async {
    final bool? shouldRefresh = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
    if (shouldRefresh ?? false) {
      _getNewTaskList();
      _getTaskStatusCount();
    }
  }

  void _getTaskStatusCount() async {
    _taskStatusCount.clear();
    _getTaskStatusCountInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.taskStatusCount);

    _getTaskStatusCountInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final TaskStatusCountModel listTaskStatusCountModel =
          TaskStatusCountModel.fromJson(response.responseData);
      _taskStatusCount = listTaskStatusCountModel.taskStatusCountList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  void _getNewTaskList() async {
    _newTaskList.clear();
    _getNewTaskInProgress = true;
    setState(() {});

    final NetworkResponse response =
        await NetworkCaller.getRequest(url: Urls.getNewTask);

    _getNewTaskInProgress = false;
    setState(() {});

    if (response.isSuccess) {
      final ListTaskModel listTaskModel =
          ListTaskModel.fromJson(response.responseData);
      _newTaskList = listTaskModel.taskList ?? [];
    } else {
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
