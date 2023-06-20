import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class appImageNetwork extends StatelessWidget {
  final String? endPoint;
  appImageNetwork({
    Key? key,
    required this.endPoint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
    return Image.network(baseUrl + endPoint!,);
  }
}
