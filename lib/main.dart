import 'package:flutter/material.dart'; // Existing Flutter import
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart'; // Import for Parse SDK
import 'auth_screen.dart'; // Import the AuthScreen
import 'task_list_screen.dart'; // Import the task list screen (to be created later)

void main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Parse server with your Back4App credentials
  await Parse().initialize(
    'K1OvTA97e0huY3LjVwW6JF053CfpO9H30D0ujQWS', // Replace with your Back4App App ID
    'https://parseapi.back4app.com', // Back4App API URL
    clientKey: '0ijE8tQO6yNH3qlnp4CPXmPEc0B7qDLnElQSvpUv', // Replace with your Back4App Client Key
    autoSendSessionId: true, // Optional: Automatically handle session IDs
  );

  runApp(MyApp()); // Run the main app
}

// Existing Flutter app code
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(), // Set AuthScreen as the initial route
        '/tasks': (context) => TaskListScreen(), // Placeholder for task list screen
      },
    );
  }
}
