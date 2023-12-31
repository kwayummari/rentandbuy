import 'package:cers/routes/route-names.dart';
import 'package:cers/src/service/add_lost_data.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_base_screen.dart';
import 'package:cers/src/widgets/app_button.dart';
import 'package:cers/src/widgets/app_input_text2.dart';
import 'package:cers/src/widgets/app_snackbar.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  void openUrl() async {
    await launchUrl(Uri.parse(
        'https://www.google.com/url?sa=t&source=web&rct=j&url=https://lormis.tpf.go.tz/Registration/Create&ved=2ahUKEwi859yn06__AhX_SaQEHbchCuwQFnoECBQQAQ&usg=AOvVaw0B5dsDqucpVYXXIajEY4U8'));
  }

  final dataService _apiService = dataService();
  final _formKey = GlobalKey<FormState>();
  TextEditingController caption = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
  var category;
  File? _imageFile;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppConst.primary,
          centerTitle: true,
          title: AppText(
            txt: 'Welcome John',
            size: 15,
            color: AppConst.secondary,
          ),
          actions: [
            IconButton(
                onPressed: () => openUrl(),
                icon: Icon(Icons.link, color: Colors.white)),
            IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RouteNames.bottomNavigation),
                icon: Icon(Icons.home, color: Colors.white))
          ],
        ),
        bgcolor: AppConst.secondary,
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_imageFile != null) ...[
                  Image.file(
                    _imageFile!,
                    width: 150,
                    height: 150,
                  ),
                  SizedBox(height: 10),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    AppButton(
                        onPress: () => _pickImage(ImageSource.camera),
                        label: 'Take a Photo',
                        borderRadius: 15,
                        textColor: AppConst.secondary,
                        bcolor: AppConst.primary),
                    AppButton(
                        onPress: () => _pickImage(ImageSource.gallery),
                        label: 'Choose from Gallery',
                        borderRadius: 15,
                        textColor: AppConst.secondary,
                        bcolor: AppConst.primary),
                  ],
                ),
                AppInputText(
                    textfieldcontroller: caption,
                    isemail: false,
                    fillcolor: AppConst.secondary,
                    header: 'Caption',
                    hint: 'I have lost ---',
                    obscure: false),
                AppInputText(
                    textfieldcontroller: caption,
                    isemail: false,
                    fillcolor: AppConst.secondary,
                    header: 'Caption',
                    hint: 'Name',
                    obscure: false),
                AppInputText(
                    textfieldcontroller: description,
                    isemail: false,
                    fillcolor: AppConst.secondary,
                    header: 'Caption',
                    hint: 'Description',
                    obscure: false),
                AppInputText(
                    textfieldcontroller: price,
                    isemail: false,
                    fillcolor: AppConst.secondary,
                    header: 'Caption',
                    hint: 'Price /hr',
                    obscure: false),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 400,
                  height: 50,
                  child: AppButton(
                      onPress: () async {
                        try {
                          if (_imageFile != null) {
                            final response = await _apiService.add(
                                context,
                                caption.text.toString(),
                                description.text.toString(),
                                price.text.toString(),
                                _imageFile);
                            AppSnackbar(
                              isError: response.toString() == 'success'
                                  ? false
                                  : true,
                              response: response.toString(),
                            ).show(context);
                            if (response.toString() == 'success') {
                              if (response.toString() == 'success')
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RouteNames.bottomNavigation, (_) => false);
                            }
                          }

                          if (_imageFile == null) {
                            final response =
                                await _apiService.add_without_image(
                                    context, caption.text.toString());
                            AppSnackbar(
                              isError: response.toString() == 'success'
                                  ? false
                                  : true,
                              response: response.toString(),
                            ).show(context);
                            if (response.toString() == 'success') {
                              if (response.toString() == 'success')
                                Navigator.pushNamedAndRemoveUntil(context,
                                    RouteNames.bottomNavigation, (_) => false);
                            }
                          }
                        } catch (e) {
                          AppSnackbar(
                            isError: true,
                            response: e.toString(),
                          ).show(context);
                        }
                      },
                      label: 'Save',
                      borderRadius: 25,
                      textColor: AppConst.secondary,
                      bcolor: AppConst.primary),
                ),
              ],
            )));
  }
}
