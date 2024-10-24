import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/home/add_new_task_screen.dart';

import '../../widgets/task_card.dart';
import '../../widgets/task_summary_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildSummarySection(),
          Expanded(
            child: ListView.separated(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TaskCard(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: 8,
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onTabAddFAB,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildSummarySection() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            TaskSummaryCard(
              title: 'New Task',
              count: 9,
            ),
            TaskSummaryCard(
              title: 'In Progress',
              count: 0,
            ),
            TaskSummaryCard(
              title: 'Completed',
              count: 0,
            ),
            TaskSummaryCard(
              title: 'Cancelled',
              count: 0,
            ),
          ],
        ),
      ),
    );
  }

  void _onTabAddFAB() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewTaskScreen(),
      ),
    );
  }
}
