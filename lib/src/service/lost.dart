import 'package:cers/src/api/api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

class lostService {
  static String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  Api api = Api();

  Future lost(BuildContext context, String endPoint) async {
    final response = await api.get(context, endPoint);
    return response;
  }
}
