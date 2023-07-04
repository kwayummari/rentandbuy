import 'dart:io';

import 'package:cers/routes/route-names.dart';
import 'package:cers/src/service/lost.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:flutter/material.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  @override
  void initState() {
    super.initState();
    getLostItems();
  }

  List found = [];
  Future getLostItems() async {
    final lostService _foundService = await lostService();
    List items = await _foundService.lost(context, 'lost/get.php');
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppConst.primary,
        centerTitle: true,
        title: AppText(
          txt: 'All Equipments',
          size: 15,
          color: AppConst.secondary,
        ),
        actions: [
          IconButton(
              onPressed: () => Navigator.pushNamed(context, RouteNames.add),
              icon: Icon(Icons.add_a_photo, color: Colors.white))
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
                        SizedBox(
                          width: 10,
                        )
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
