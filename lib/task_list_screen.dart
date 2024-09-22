import 'package:flutter/material.dart';
import 'task_service.dart'; // Import TaskService
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';


class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final TaskService _taskService = TaskService();
  List<ParseObject> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks(); // Load tasks when the screen is initialized
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskService.fetchTasks();
    setState(() {
      _tasks = tasks; // This should now be an empty list if no tasks exist
    });
  }

  Future<void> _addTask() async {
    final title = await _showAddTaskDialog();
    if (title != null) {
      await _taskService.addTask(title, DateTime.now().add(Duration(days: 7))); // Set a default due date
      _loadTasks(); // Refresh the task list
    }
  }

  Future<String?> _showAddTaskDialog() async {
    String? taskTitle;
    await showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: 'Task Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                taskTitle = controller.text;
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
    return taskTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addTask, // Add task button
          ),
        ],
      ),
      body: _tasks.isEmpty
          ? Center(child: Text('No tasks available.'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                final task = _tasks[index];
                return ListTile(
                  title: Text(task.get<String>('title') ?? 'Untitled'),
                  subtitle: Text(task.get<DateTime>('dueDate')?.toString() ?? 'No Due Date'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      await _taskService.deleteTask(task);
                      _loadTasks(); // Refresh the task list
                    },
                  ),
                );
              },
            ),
    );
  }
}
