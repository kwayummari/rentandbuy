import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/api.dart';

class addInquiry {
  Api api = Api();
  Future add(
    BuildContext context,
    String itemId,
    String ownerEmail,
  ) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email = sharedPreferences.get('email');
    Map<String, dynamic> data = {
      'itemId': itemId.toString(),
      'renterEmail': email.toString(),
      'ownerEmail': ownerEmail.toString()
    };
    final response = await api.post('renting/create.php', data);
    return response;
  }
}
