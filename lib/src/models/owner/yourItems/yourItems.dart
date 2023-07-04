// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:cers/routes/route-names.dart';
import 'package:cers/src/service/found.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class found extends StatefulWidget {
  const found({super.key});

  @override
  State<found> createState() => _foundState();
}

class _foundState extends State<found> {
  String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  @override
  void initState() {
    super.initState();
    getFoundItems();
  }

  List found = [];
  Future getFoundItems() async {
    final foundService _foundService = await foundService();
    List items = await _foundService.found(context, 'found/get.php');
    setState(() {
      found = items;
    });
  }

  String extractUsernameFromEmail(String email) {
    int atIndex = email.indexOf("@");
    String username = email.substring(0, atIndex);
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.primary,
        centerTitle: true,
        title: AppText(
          txt: 'Your Equipments',
          size: 15,
          color: AppConst.secondary,
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, RouteNames.requets),
              icon: Icon(Icons.recent_actors, color: Colors.white))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              primary: false,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 20,
                            child: Icon(
                              Icons.person,
                              color: Color.fromARGB(255, 179, 93, 23),
                            )),
                        AppText(
                          txt: extractUsernameFromEmail(
                              found[index]['email'].toString()),
                          color: Colors.black,
                          size: 15,
                          weight: FontWeight.w500,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    found[index]['image'] == null
                        ? Image.asset('assets/noimage.jpg')
                        : appImageNetwork(
                            endPoint: 'lost/image/${found[index]['image']}'),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: Row(children: [
                        IconButton(
                            onPressed: () async {
                              final urlImage =
                                  '$baseUrl${found[index]['image']}';
                              final url = Uri.parse(urlImage);
                              final response = await http.get(url);
                              final bytes = response.bodyBytes;

                              final temp = await getTemporaryDirectory();
                              final path = '${temp.path}/image.jpg';
                              File(path).writeAsBytesSync(bytes);

                              await Share.shareXFiles([XFile(path)],
                                  text: '${found[index]['caption']}');
                            },
                            icon: Icon(
                              Icons.share_rounded,
                              color: AppConst.primary,
                            )),
                        Spacer(),
                      ]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: InkWell(
                        onTap: () => null,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.centerLeft,
                              child: AppText(
                                txt: found[index]['caption'],
                                size: 15,
                                color: Colors.black,
                              )),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                );
              },
              itemCount: found.length ?? 0,
            ),
          ),
        ],
      ),
    );
  }
}
