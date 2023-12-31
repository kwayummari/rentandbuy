// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore, prefer_const_constructors, body_might_complete_normally_nullable, prefer_if_null_operators, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, unused_label

import 'package:cers/animations/animations.dart';
import 'package:cers/src/service/inquiry.dart';
import 'package:cers/src/service/lost.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_button.dart';
import 'package:cers/src/widgets/app_image_network.dart';
import 'package:cers/src/widgets/app_snackbar.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class view extends StatefulWidget {
  var name;
  var description;
  var price;
  var image;
  var id;
  var email;
  // ignore: non_constant_identifier_names
  view({
    Key? key,
    required this.id,
    required this.email,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  }) : super(key: key);

  @override
  State<view> createState() => _viewState();
}

class _viewState extends State<view> {
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
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: FadeAnimation(
              1.2,
              widget.image == null
                  ? Image.asset('assets/noimage.jpg')
                  : appImageNetwork(endPoint: 'lost/image/${widget.image}'),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: FadeAnimation(
              1.2,
              CircleAvatar(
                backgroundColor: AppConst.black,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.28,
            child: FadeAnimation(
              1.2,
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppConst.black),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeAnimation(
                        1.3,
                        Center(
                          child: AppText(
                            txt: '${widget.name}',
                            color: AppConst.black,
                            size: 18,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      AppText(
                        txt: 'Price',
                        color: AppConst.black,
                        size: 18,
                      ),
                      Center(
                        child: FadeAnimation(
                          1.3,
                          AppText(
                            txt: '${widget.price} /hr',
                            color: AppConst.black,
                            size: 18,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Divider(
                        color: AppConst.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppText(
                        txt: 'Description',
                        color: AppConst.black,
                        size: 18,
                      ),
                      Container(
                        margin: const EdgeInsets.all(15.0),
                        padding: const EdgeInsets.all(3.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Center(
                          child: FadeAnimation(
                            1.3,
                            AppText(
                              txt: '${widget.description}',
                              color: AppConst.black,
                              size: 18,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: 340,
                        child: AppButton(
                          onPress: () => addInquirys(
                              widget.id.toString(), widget.email.toString()),
                          label: 'Rent',
                          bcolor: AppConst.primary,
                          borderRadius: 20,
                          textColor: AppConst.secondary,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
