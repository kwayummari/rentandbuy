// ignore_for_file: unused_local_variable
import 'package:cers/src/service/found.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class rented extends StatefulWidget {
  const rented({super.key});

  @override
  State<rented> createState() => _rentedState();
}

class _rentedState extends State<rented> {
  String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  @override
  void initState() {
    super.initState();
    getFoundItems();
  }

  List found = [];
  Future getFoundItems() async {
    final foundService _foundService = await foundService();
    List items = await _foundService.found(context, 'renting/get.php');
    setState(() {
      found = items;
    });
  }

  Future<Widget> view(id) async {
    final foundService _foundService = await foundService();
    List items = await _foundService.found(context, 'renting/getbyId.php');
    if (items.isEmpty) {
      return Image.asset('assets/noimage.jpg');
    } else {
      return appImageNetwork(endPoint: 'lost/image/${items[0]['image']}');
    }
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
          txt: 'Your Rented Items',
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
                    ListTile(
                      leading: FutureBuilder<Widget>(
                        future: view(found[index]['itemId']),
                        builder: (BuildContext context,
                            AsyncSnapshot<Widget> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator(); // Show a loading indicator while the future is executing
                          } else if (snapshot.hasError) {
                            return Icon(Icons
                                .error); // Show an error icon if the future encountered an error
                          } else {
                            return snapshot
                                .data!; // Display the widget retrieved from the future
                          }
                        },
                      ),
                      title: AppText(
                          txt: "Owner: ${found[index]['ownerEmail']}",
                          size: 15),
                      trailing: AppText(
                          txt: found[index]['status'] == '0'
                              ? 'Pending'
                              : found[index]['status'] == '1'
                                  ? 'Accepted'
                                  : 'Canceled',
                          color: found[index]['status'] == '0' ||
                                  found[index]['status'] == '1'
                              ? Colors.red
                              : Colors.black,
                          size: 15),
                    ),
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
