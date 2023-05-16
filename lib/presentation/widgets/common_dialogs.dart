import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_button.dart';
import 'common_gaps.dart';
import 'common_text_styles.dart';

Future showCommonDialog({
  String? iconImage,
  required String firstButtonText,
  required Function() firstButtonCallback,
  bool dismissible = true,
  String? title,
  String message = "message",
  String? secondButtonText,
  Function()? secondButtonCallback,
  EdgeInsetsGeometry? paddingFirstButton,
  EdgeInsetsGeometry? paddingSecondButton,
}) {
  return Get.dialog(
      WillPopScope(
        onWillPop: () async => dismissible,
        child: CommonDialog(
          iconImage: iconImage,
          title: title,
          firstButtonText: firstButtonText,
          firstButtonCallback: firstButtonCallback,
          secondButtonCallback: secondButtonCallback,
          secondButtonText: secondButtonText,
          message: message,
          paddingFirstButton: paddingFirstButton,
          paddingSecondButton: paddingSecondButton,
        ),
      ),
      barrierDismissible: dismissible);
}

Future<bool?> showCommonBooleanDialog({
  required String firstButtonText,
  required Function() firstButtonCallback,
  bool dismissible = true,
  String? title,
  String? iconImage,
  String? message,
  String? secondButtonText,
  Function()? secondButtonCallback,
  EdgeInsetsGeometry? paddingFirstButton,
  EdgeInsetsGeometry? paddingSecondButton,
  Color? colorFirstButton,
}) {
  return Get.dialog<bool>(
    barrierDismissible: dismissible,
    WillPopScope(
      onWillPop: () => Future.value(dismissible),
      child: CommonDialog(
        title: title,
        firstButtonText: firstButtonText,
        firstButtonCallback: firstButtonCallback,
        secondButtonCallback: secondButtonCallback,
        secondButtonText: secondButtonText,
        message: message,
        paddingFirstButton: paddingFirstButton,
        paddingSecondButton: paddingSecondButton,
        colorFirstButton: colorFirstButton,
      ),
    ),
  );
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({
    Key? key,
    this.title,
    this.message,
    this.iconImage,
    required this.firstButtonText,
    required this.firstButtonCallback,
    this.firstButtonColor,
    this.secondButtonText,
    this.secondButtonCallback,
    this.secondButtonColor,
    this.paddingFirstButton,
    this.paddingSecondButton,
    this.colorFirstButton,
  }) : super(key: key);

  final Function()? secondButtonCallback;
  final Function() firstButtonCallback;
  final Color? firstButtonColor;
  final String firstButtonText;
  final String? message;
  final Color? secondButtonColor;
  final String? secondButtonText;
  final String? title;
  final String? iconImage;
  final EdgeInsetsGeometry? paddingFirstButton;
  final EdgeInsetsGeometry? paddingSecondButton;
  final Color? colorFirstButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: DimensRes.sp48),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DimensRes.sp16),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRes.sp16),
          color: ColorsRes.white,
        ),
        padding: const EdgeInsets.symmetric(vertical: DimensRes.sp48, horizontal: DimensRes.sp24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (title != null)
              Column(
                children: [
                  Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: CommonTextStyles.mediumBold,
                  ),
                  Gaps.vGap16,
                ],
              ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp8),
                child: Text(message!,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CommonTextStyles.medium),
              ),
            Gaps.vGap24,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SizedBox(
                    width: context.width,
                    child: CommonButton(
                      onPressed: firstButtonCallback,
                      title: firstButtonText,
                      padding: paddingFirstButton ??
                          const EdgeInsets.symmetric(vertical: DimensRes.sp16),
                      borderRadius: DimensRes.sp48,
                      backgroundColor: colorFirstButton ?? ColorsRes.secondary,
                    ),
                  ),
                if (secondButtonText != null) Gaps.vGap12,

                if (secondButtonText != null)
                  SizedBox(
                    width: context.width,
                    child: CommonButton(
                      padding: paddingSecondButton ??
                          const EdgeInsets.symmetric(
                            vertical: DimensRes.sp16,
                            horizontal: DimensRes.sp20,
                          ),
                      borderSide: const BorderSide(color: ColorsRes.primary),
                      textStyle: CommonTextStyles.mediumBold
                          .copyWith(color: ColorsRes.primary),
                      borderRadius: DimensRes.sp48,
                      backgroundColor: Colors.transparent,
                      onPressed: secondButtonCallback!,
                      title: secondButtonText ?? '',
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
