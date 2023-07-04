import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:cers/routes/route-names.dart';
import 'package:cers/src/service/registration.dart';
import 'package:cers/src/widgets/app_base_screen.dart';
import 'package:cers/src/widgets/app_button.dart';
import 'package:cers/src/widgets/app_card.dart';
import 'package:cers/src/widgets/app_container.dart';
import 'package:cers/src/widgets/app_input_text.dart';
import 'package:cers/src/widgets/app_snackbar.dart';
import 'package:cers/src/widgets/app_text.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final registrationService _apiService = registrationService();
  TextEditingController fullname = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController rpassword = TextEditingController();
  var role, roleValue;
  bool dont_show_password = true;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
      bgcolor: AppConst.primary,
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              CircleAvatar(
                  backgroundColor: AppConst.secondary,
                  radius: 70,
                  child: Image.asset('assets/login.png')),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 250),
                child: AppText(
                  txt: 'SIGN UP',
                  size: 20,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppCard(
                    color: Colors.grey.shade200,
                    border: 20,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        AppContainer(
                            width: 340,
                            bottom: 24,
                            child: AppInputText(
                              textfieldcontroller: fullname,
                              icon: Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              label: 'Full Name',
                              obscure: false,
                              isemail: false,
                              fillcolor: AppConst.secondary,
                            )),
                        AppContainer(
                            width: 340,
                            bottom: 24,
                            child: AppInputText(
                              textfieldcontroller: email,
                              icon: Icon(
                                Icons.mail,
                                color: Colors.black,
                              ),
                              label: 'Email',
                              obscure: false,
                              isemail: true,
                              fillcolor: AppConst.secondary,
                            )),
                        AppContainer(
                            width: 340,
                            bottom: 0,
                            child: AppInputText(
                              textfieldcontroller: phone,
                              icon: Icon(
                                Icons.phone,
                                color: Colors.black,
                              ),
                              label: 'Phone',
                              obscure: false,
                              isemail: false,
                              fillcolor: AppConst.secondary,
                            )),
                        AppContainer(
                            width: 340,
                            bottom: 24,
                            child: AppInputText(
                              textfieldcontroller: password,
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              label: 'Password',
                              obscure: dont_show_password,
                              suffixicon: IconButton(
                                  onPressed: (() {
                                    setState(() {
                                      dont_show_password = !dont_show_password;
                                    });
                                  }),
                                  icon: Icon(Icons.remove_red_eye)),
                              isemail: false,
                              fillcolor: AppConst.secondary,
                            )),
                        AppContainer(
                            width: 340,
                            bottom: 24,
                            child: AppInputText(
                              onChange: (p0) {
                                if (p0 != password.text) {
                                  return "Passwords do not match";
                                } else {
                                  return null;
                                }
                              },
                              textfieldcontroller: rpassword,
                              icon: Icon(
                                Icons.lock,
                                color: Colors.black,
                              ),
                              label: 'Re-enter Password',
                              obscure: dont_show_password,
                              suffixicon: IconButton(
                                  onPressed: (() {
                                    setState(() {
                                      dont_show_password = !dont_show_password;
                                    });
                                  }),
                                  icon: Icon(Icons.remove_red_eye)),
                              isemail: false,
                              fillcolor: AppConst.secondary,
                            )),
                        AppContainer(
                          width: 340,
                          bottom: 24,
                          child: AppDropdownTextFormField(
                            labelText: 'Select Role',
                            onChanged: (newValue) {
                              setState(() {
                                role = newValue;
                              });
                              if (role == 'Owner') {
                                setState(() {
                                  roleValue = '0'.toString();
                                });
                              } else {
                                setState(() {
                                  roleValue = '1'.toString();
                                });
                              }
                            },
                            options: ['Select', 'Owner', 'Renter'],
                            value: role ?? 'Select',
                          ),
                        ),
                        AppContainer(
                          width: 140,
                          bottom: 24,
                          child: AppButton(
                            label: 'SIGN UP',
                            onPress: () async {
                              try {
                                final response = await _apiService.registration(
                                    context,
                                    email.text,
                                    password.text,
                                    fullname.text,
                                    phone.text);
                                AppSnackbar(
                                  isError: false,
                                  response: response.toString(),
                                ).show(
                                    context); // handle successful login response
                                if (response == 'success') {
                                  Navigator.pushNamedAndRemoveUntil(
                                      context, RouteNames.login, (_) => false);
                                }
                              } catch (e) {
                                AppSnackbar(
                                  isError: true,
                                  response: e.toString(),
                                ).show(context);
                              }
                            },
                            bcolor: AppConst.primary,
                            borderRadius: 20,
                            textColor: Colors.black,
                          ),
                        )
                      ],
                    )),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, RouteNames.login),
                child: Padding(
                  padding: const EdgeInsets.only(left: 120),
                  child: AppText(
                    size: 15,
                    txt: 'Already have an account? Login',
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
