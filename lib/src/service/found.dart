import 'package:cers/src/api/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class foundService {
  static String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  Api api = Api();

  Future found(BuildContext context, String endPoint) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.get('email');
    Map<String, dynamic> data = {
      'email': email,
    };

    final response = await api.post(endPoint, data);
    return response;
  }
  
}
