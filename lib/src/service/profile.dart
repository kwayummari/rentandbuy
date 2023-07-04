import 'package:cers/src/api/api.dart';
import 'package:flutter/material.dart';

class profileService {
  Api api = Api();
  Future profile(BuildContext context, String id) async {
    Map<String, dynamic> data = {
      'id': id.toString(),
    };
    final response = await api.post('profile/get.php', data);
    List datas = response;
    return datas;
  }
}