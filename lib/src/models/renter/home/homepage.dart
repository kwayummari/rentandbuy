import 'dart:io';
import 'package:cers/src/service/inquiry.dart';
import 'package:cers/src/service/lost.dart';
import 'package:cers/src/widgets/app_button.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:cers/src/widgets/app_snackbar.dart';
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

  Future addInquirys(id, ownerEmail) async {
    final addInquiry _foundService = await addInquiry();
    final response = await _foundService.add(context, id, ownerEmail);
    AppSnackbar(
      isError: response.toString() == 'success' ? false : true,
      response: response.toString(),
    ).show(context);
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
                          txt: 'UserX',
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
                        AppButton(
                            onPress: () => addInquirys(
                                found[index]['id'].toString(),
                                found[index]['email']),
                            label: 'Make Inquiry',
                            borderRadius: 5,
                            textColor: AppConst.secondary,
                            bcolor: AppConst.primary),
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
