import 'package:flutter/material.dart';
import '../api/api.dart';

class registrationService {
  Api api = Api();

  Future registration(BuildContext context, String email, String password,
      String fullname, String phone) async {
    Map<String, dynamic> data = {
      'email': email.toString(),
      'fullname': fullname.toString(),
      'phone': phone.toString(),
      'password': password.toString(),
    };
    final response = await api.post('auth/registration.php', data);
    print(data);
    return response;
  }
}
