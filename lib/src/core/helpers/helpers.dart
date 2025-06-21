import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_base/src/config/language/languages.dart';
import 'package:flutter_base/src/config/res/app_sizes.dart';
import 'package:flutter_base/src/config/res/color_manager.dart';
import 'package:flutter_base/src/core/extensions/padding_extension.dart';
import 'package:flutter_base/src/core/widgets/custom_loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../config/language/locale_keys.g.dart';
import '../navigation/navigator.dart';

class Helpers {
  static Future<File?> getImage() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File imageFile = File(image.path);
      return imageFile;
    }
    return null;
  }

  static Future<List<File>> getImages() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> result = await picker.pickMultiImage();
    if (result.isNotEmpty) {
      List<File> files = result.map((e) => File(e.path)).toList();
      return files;
    } else {
      return [];
    }
  }

  static void changeStatusbarColor({
    required Color statusBarColor,
    Brightness? statusBarIconBrightness,
  }) {
    return SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.dark,
        systemNavigationBarColor: AppColors.main,
      ),
    );
  }

  static Future<File?> getImageFromCameraOrDevice() async {
    final ImagePicker picker = ImagePicker();
    File? image;
    await showModalBottomSheet(
        context: Go.navigatorKey.currentContext!,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(LocaleKeys.photoLibrary),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: Text(LocaleKeys.camera),
                  onTap: () async {
                    final currentImage =
                        await picker.pickImage(source: ImageSource.camera);
                    if (currentImage != null) {
                      image = File(currentImage.path);
                    }
                    Go.back();
                  },
                ),
              ],
            ).paddingAll(AppPadding.pH10),
          );
        });
    return image;
  }

  static void shareApp(url) {
    CustomLoading.showFullScreenLoading();
    Share.share(url).whenComplete(() {
      CustomLoading.hideFullScreenLoading();
    });
  }

  static String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else {
      return 'android';
    }
  }

  static String showByLang({
    required String ar,
    required String en,
  }) {
    if (Languages.currentLanguage.languageCode == "ar") {
      return ar;
    } else {
      return en;
    }
  }
}
