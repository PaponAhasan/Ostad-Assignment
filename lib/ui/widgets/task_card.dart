import 'package:flutter/material.dart';
import 'package:task_manager/ui/widgets/snack_bar_message.dart';

import '../../data/models/list_task/list_task_data.dart';
import '../../data/models/network_response.dart';
import '../../data/services/network_caller.dart';
import '../../data/util/urls.dart';
import '../utils/app_colors.dart';
import 'center_circular_progress_indicator.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.listTaskData,
    required this.onRefreshList,
  });

  final ListTaskData listTaskData;
  final VoidCallback onRefreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  String _selectedStatus = "";
  bool _changeStatusInProgress = false;
  bool _deleteInProgress = false;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.listTaskData.status!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.listTaskData.title ?? '',
                style: Theme.of(context).textTheme.titleMedium),
            Text(widget.listTaskData.description ?? ''),
            Text('Date: ${widget.listTaskData.createdDate}'),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildTaskStatus(),
                Wrap(
                  // wrap
                  children: [
                    Visibility(
                      visible: !_changeStatusInProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapEditButton,
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                    Visibility(
                      visible: !_deleteInProgress,
                      replacement: const CenterCircularProgressIndicator(),
                      child: IconButton(
                        onPressed: _onTapDeleteButton,
                        icon: const Icon(Icons.delete),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onTapEditButton() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ['New', 'Progress', 'Completed', 'Cancelled'].map((e) {
            return ListTile(
              onTap: () {
                _changeTaskStatus(e);
                Navigator.of(context).pop();
              },
              title: Text(e),
              selected: e == _selectedStatus,
              trailing: e == _selectedStatus ? const Icon(Icons.check) : null,
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //   },
          //   child: const Text('Okay'),
          // ),
        ],
      ),
    );
  }

  Widget _buildTaskStatus() {
    return Chip(
      label: Text(
        _selectedStatus,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      side: const BorderSide(
        color: AppColors.themeColor,
      ),
    );
  }

  Future<void> _onTapDeleteButton() async {
    _deleteInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteTask(
        taskId: widget.listTaskData.id!,
      ),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
      showSnackBarMessage(context, "Task Deleted");
    } else {
      _deleteInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }

  Future<void> _changeTaskStatus(String status) async {
    _changeStatusInProgress = true;
    setState(() {});

    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.changeTaskStatus(
        taskId: widget.listTaskData.id!,
        status: status,
      ),
    );

    if (response.isSuccess) {
      widget.onRefreshList();
    } else {
      _changeStatusInProgress = false;
      setState(() {});
      showSnackBarMessage(context, response.errorMessage, true);
    }
  }
}
