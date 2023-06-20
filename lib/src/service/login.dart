import 'package:flutter/material.dart';

import '../api/api.dart';

class loginService {
  Api api = Api();
  Future login(BuildContext context, String email, String password) async {
    Map<String, dynamic> data = {
      'email': email,
      'password': password,
    };

    final response = await api.post('auth/login.php', data);
    return response;
  }
}
