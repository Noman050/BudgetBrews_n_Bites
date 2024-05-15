// ignore_for_file: file_names

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:foodies/constants/colors.dart';
import 'package:foodies/models/screenRoutes.dart';
import 'package:permission_handler/permission_handler.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  State<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  void initState() {
    super.initState();
    _requestPermission(Permission.storage);
  }

  Future<void> selectFile() async {
    await FilePicker.platform.pickFiles(
      type: FileType.any,
    );
  }

  Future<bool> _requestPermission(Permission permission) async {
    AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
    if (build.version.sdkInt >= 30) {
      var re = await Permission.manageExternalStorage.request();
      if (re.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      if (await permission.isGranted) {
        return true;
      } else {
        var result = await permission.request();
        if (result.isGranted) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget selectListTile(
        String title, IconData icn, VoidCallback tapHandler, Color clr) {
      return ListTile(
        leading: Icon(
          icn,
          size: 20,
          color: whiteColor,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 19,
            color: whiteColor,
          ),
        ),
        onTap: tapHandler,
      );
    }

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topRight: Radius.circular(80),
        bottomRight: Radius.circular(80),
      ),
      child: Drawer(
        backgroundColor: bgColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 180,
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              alignment: Alignment.centerLeft,
              color: bgColor,
              child: Image.asset(
                "assets/images/splash.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            selectListTile('Meals', Icons.restaurant, () {
              Navigator.of(context)
                  .pushReplacementNamed(ScreenRoutes.recipeScreen);
            }, buttonColor),
            selectListTile('Filters', Icons.filter_alt, () {
              Navigator.of(context).pushNamed(ScreenRoutes.filterScreen);
            }, buttonColor),
            selectListTile('Files', Icons.file_open_sharp, () async {
              if (await _requestPermission(Permission.storage) == true) {
                selectFile();
              } else {
                _requestPermission(Permission.storage);
              }
            }, buttonColor),
            selectListTile('Settings', Icons.settings, () {}, buttonColor),
          ],
        ),
      ),
    );
  }
}
