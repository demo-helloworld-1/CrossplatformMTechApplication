import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:quick_task/Screens/Authentication/login.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const String appId = 'K1OvTA97e0huY3LjVwW6JF053CfpO9H30D0ujQWS';
  const String clientKey = '0ijE8tQO6yNH3qlnp4CPXmPEc0B7qDLnElQSvpUv';
  const parseServerUrl = 'https://parseapi.back4app.com';

  
  await Parse().initialize(
    appId,
    parseServerUrl, 
    clientKey: clientKey, 
    autoSendSessionId: true, 
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginPage(),
    );
  }
}