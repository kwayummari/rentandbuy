import 'package:cers/routes/route-names.dart';
import 'package:cers/src/utils/app_const.dart';
import 'package:cers/src/widgets/app_base_screen.dart';
import 'package:cers/src/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cers/src/service/profile.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var profileData;
  Future getValidationData() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final profileService profile = await profileService();
    var e = sharedPreferences.get('email');
    var r = sharedPreferences.get('role');
    final profileData = await profile.profile(context, e.toString());
    setState(() {
      email = e;
      role = r;
      this.profileData = profileData;
    });
  }

  @override
  void initState() {
    super.initState();
    getValidationData();
  }

  var email;
  var role;
  @override
  Widget build(BuildContext context) {
    return AppBaseScreen(
        bgcolor: AppConst.secondary,
        appBar: AppBar(
          centerTitle: false,
          title: AppText(
            txt: 'My Profile',
            size: 20,
            weight: FontWeight.bold,
            color: AppConst.secondary,
          ),
          automaticallyImplyLeading: true,
          backgroundColor: AppConst.primary,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: AppConst.primary,
                radius: 70,
                child: Icon(
                  Icons.person,
                  color: AppConst.black,
                  size: 100,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              txt: 'John Doe',
              size: 15,
              weight: FontWeight.bold,
              color: AppConst.secondary,
            ),
            AppText(
              txt: 'Edit profile',
              size: 15,
              color: AppConst.primary,
            ),
            SizedBox(
              height: 40,
            ),
            ListTile(
              leading: Icon(
                Icons.mail,
                color: AppConst.black,
              ),
              title: AppText(
                txt: email,
                size: 15,
                color: AppConst.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.person,
                color: AppConst.black,
              ),
              title: AppText(
                txt: profileData != null
                    ? profileData[0]['fullname']
                    : 'loading...',
                size: 15,
                color: AppConst.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.phone,
                color: AppConst.black,
              ),
              title: AppText(
                txt: profileData != null
                    ? profileData[0]['phone']
                    : 'loading...',
                size: 15,
                color: AppConst.black,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushNamedAndRemoveUntil(
                    context, RouteNames.login, (_) => false);
              },
              leading: Icon(
                Icons.logout,
                color: AppConst.black,
              ),
              title: AppText(
                txt: 'Logout',
                size: 15,
                color: AppConst.black,
              ),
            )
          ],
        ));
    // ignore: dead_code
    ;
  }
}
