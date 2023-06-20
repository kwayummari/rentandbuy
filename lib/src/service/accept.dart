import 'package:flutter/material.dart';

import '../api/api.dart';

class acceptService {
  Api api = Api();
  Future accept(BuildContext context, String id, String endPoint) async {
    Map<String, dynamic> data = {
      'id': id,
    };

    final response = await api.post(endPoint, data);
    return response;
  }
}
