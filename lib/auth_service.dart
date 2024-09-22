import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AuthService {
  Future<ParseUser?> signUp(String username, String password, String email) async {
    final user = ParseUser(username, password, email);
    final response = await user.signUp();

    if (response.success) {
      return response.result as ParseUser;
    } else {
      print('Sign Up Error: ${response.error?.message}');
      return null;
    }
  }


  Future<ParseUser?> login(String username, String password) async {
    final user = ParseUser(username, password, null);
    final response = await user.login();

    if (response.success) {
      return user;
    } else {
      // Handle errors (e.g., response.error)
      print('Login Error: ${response.error?.message}');
      return null;
    }
  }

Future<void> logout() async {
  final currentUser = await ParseUser.currentUser();
  await currentUser?.logout();
}

  Future<ParseUser?> getCurrentUser() async {
    return await ParseUser.currentUser();
  }
}

