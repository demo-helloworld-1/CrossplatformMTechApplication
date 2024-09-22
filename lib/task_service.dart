import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class TaskService {
  // Method to add a new task
  Future<ParseObject?> addTask(String title, DateTime dueDate) async {
    final task = ParseObject('Task')
      ..set('title', title)
      ..set('dueDate', dueDate)
      ..set('status', false); // Default status is incomplete

    final response = await task.save();

    if (response.success) {
      return response.result as ParseObject;
    } else {
      print('Add Task Error: ${response.error?.message}');
      return null;
    }
  }

  // Method to fetch all tasks
Future<List<ParseObject>> fetchTasks() async {
  final QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Task'));
  final response = await query.query();

  if (response.success) {
    return response.results as List<ParseObject> ?? []; // Ensure it returns an empty list if null
  } else {
    print('Fetch Tasks Error: ${response.error?.message}');
    return []; // Return an empty list on error
  }
}


  // Method to delete a task
  Future<bool> deleteTask(ParseObject task) async {
    final response = await task.delete();

    if (response.success) {
      return true;
    } else {
      print('Delete Task Error: ${response.error?.message}');
      return false;
    }
  }
}
