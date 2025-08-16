import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../config/res/config_imports.dart';
import '../helpers/loading_manager.dart';

class CustomLoading {
  static Center showLoadingView() {
    return Center(
      child: SpinKitCircle(
        color: AppColors.main,
        size: AppSize.sH50,
      ),
    );
  }

  static void showFullScreenLoading() => FullScreenLoadingManager.show();

  static void hideFullScreenLoading() => FullScreenLoadingManager.hide();
}
