import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/log/log.dart';
import '../../presentation/widgets/common_dialogs.dart';

mixin BaseMixin<T extends StatefulWidget> on State<T> {

  @override
  void didChangeDependencies() {
    Log.d('$T ==> didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    Log.d('$T ==> dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    Log.d('$T ==> deactivate');
    super.deactivate();
  }

  @override
  void didUpdateWidget(T oldWidget) {
    Log.d('$T ==> didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    Log.d('$T ==> initState');
    super.initState();
  }

  void showErrorDialog({
    String? message,
    String? title,
    Function()? onClick,
    bool dismissible = true,
  }) {
    showCommonDialog(
      dismissible: dismissible,
      firstButtonCallback: onClick ??
          () {
            Get.back();
          },
      firstButtonText: 'OK',
      title: title,
      message: message ?? '',
    );
  }
}
