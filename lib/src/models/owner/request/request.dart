// ignore_for_file: unused_local_variable
import 'package:cers/routes/route-names.dart';
import 'package:cers/src/service/accept.dart';
import 'package:cers/src/service/found.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:cers/src/widgets/app_snackbar.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class request extends StatefulWidget {
  const request({super.key});

  @override
  State<request> createState() => _requestState();
}

class _requestState extends State<request> {
  String baseUrl = dotenv.env['API_SERVER'] ?? 'http://noapi';
  @override
  void initState() {
    super.initState();
    getFoundItems();
  }

  List found = [];
  Future getFoundItems() async {
    final foundService _foundService = await foundService();
    List items = await _foundService.found(context, 'renting/getbyowner.php');
    setState(() {
      found = items;
    });
  }

  Future accept(id) async {
    final acceptService _foundService = await acceptService();
    final response =
        await _foundService.accept(context, id, 'renting/accept.php');
    AppSnackbar(
      isError: response.toString() == 'success' ? false : true,
      response: response.toString(),
    ).show(context);
  }

  Future cancel(id) async {
    final acceptService _foundService = await acceptService();
    final response =
        await _foundService.accept(context, id, 'renting/cancel.php');
    AppSnackbar(
      isError: response.toString() == 'success' ? false : true,
      response: response.toString(),
    ).show(context);
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
          txt: 'Your Requests Items',
          size: 15,
          color: AppConst.secondary,
        ),
        actions: [
          IconButton(
              onPressed: () =>
                  Navigator.pushNamed(context, RouteNames.bottomNavigation),
              icon: Icon(Icons.home, color: Colors.white))
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
                        trailing: found[index]['status'] != '0'
                            ? AppText(
                                txt: found[index]['status'] != '1'
                                    ? 'Accepted'
                                    : 'Canceled',
                                size: 15)
                            : Container(
                                width: 120,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () => accept(
                                            found[index]['id'].toString()),
                                        icon: Icon(
                                          Icons.mark_chat_read,
                                          color: Colors.green,
                                        )),
                                    IconButton(
                                        onPressed: () => cancel(
                                            found[index]['id'].toString()),
                                        icon: Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ))
                                  ],
                                ),
                              )),
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
