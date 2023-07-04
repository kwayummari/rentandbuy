import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';

class dataService {
  Api api = Api();
  static String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  Future add(
    BuildContext context,
    String caption,
    String description,
    String price,
    File? _imageFile,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.get('email');
    final uri = Uri.parse("$baseUrl/lost/create.php");
    var request = http.MultipartRequest('POST', uri);
    request.fields['caption'] = caption.toString();
    request.fields['description'] = description.toString();
    request.fields['price'] = price.toString();
    request.fields['email'] = email.toString();
    var pic = await http.MultipartFile.fromPath("image", _imageFile!.path);
    request.files.add(pic);
    var response = await request.send();
    var responseData = await http.Response.fromStream(response);
    var responseString = jsonDecode(responseData.body);
    return responseString;
  }

  Future add_without_image(
    BuildContext context,
    String caption,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.get('email');
    Map<String, dynamic> data = {
      'caption': caption.toString(),
      'email': email.toString()
    };
    final response = await api.post('lost/create_without_image.php', data);
    return response;
  }
}
