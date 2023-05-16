import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_button.dart';
import 'common_gaps.dart';
import 'common_snack_bar.dart';
import 'common_text_styles.dart';

Future<dynamic> showCommonBottomSheets(
  Widget bottomSheet, {
  Color? backgroundColor,
  double? elevation,
  bool persistent = true,
  ShapeBorder? shape,
  Clip? clipBehavior,
  Color? barrierColor,
  bool? ignoreSafeArea,
  bool isScrollControlled = false,
  bool useRootNavigator = false,
  bool isDismissible = true,
  bool enableDrag = true,
  bool physicDismissible = true,
}) async {
  return Get.bottomSheet(
    WillPopScope(
      onWillPop: () => Future.value(physicDismissible),
      child: bottomSheet,
    ),
    backgroundColor: backgroundColor,
    elevation: elevation,
    persistent: persistent,
    shape: shape,
    clipBehavior: clipBehavior,
    barrierColor: barrierColor,
    ignoreSafeArea: ignoreSafeArea,
    isScrollControlled: isScrollControlled,
    useRootNavigator: useRootNavigator,
    isDismissible: isDismissible,
    enableDrag: enableDrag,
  );
}

class CommonBottomSheet extends StatefulWidget {
  const CommonBottomSheet({
    Key? key,
    required this.title,
    required this.textButton,
    required this.message,
    required this.onButtonPress,
    required this.onCloseButtonPress,
    this.onDismiss,
    this.paddingFirstButton,
    this.paddingSecondButton,
  }) : super(key: key);

  final String title;
  final String message;
  final String textButton;
  final Function()? onButtonPress;
  final Function() onCloseButtonPress;
  final Function()? onDismiss;
  final EdgeInsetsGeometry? paddingFirstButton;
  final EdgeInsetsGeometry? paddingSecondButton;

  @override
  State<CommonBottomSheet> createState() => _CommonBottomSheetState();
}

class _CommonBottomSheetState extends State<CommonBottomSheet> {
  bool visibleSnackBar = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          visibleSnackBar = false;
        });
      }
    });
  }

  Widget _buildFirstButton() {
    final firstButton = CommonButton(
      padding: widget.paddingSecondButton ??
          const EdgeInsets.symmetric(
            vertical: DimensRes.sp16,
            horizontal: DimensRes.sp20,
          ),
      borderSide: const BorderSide(color: ColorsRes.primary),
      textStyle: CommonTextStyles.mediumBold.copyWith(
        color: ColorsRes.primary,
      ),
      backgroundColor: Colors.transparent,
      onPressed: widget.onCloseButtonPress,
      title: 'close',
    );

    return Expanded(child: firstButton);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: visibleSnackBar,
            child: CommonSnackBar(
              isError: false,
              title: widget.title,
            ),
          ),
          Gaps.vGap24,
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(DimensRes.sp8),
                topRight: Radius.circular(DimensRes.sp8),
              ),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: DimensRes.sp16,
                bottom: DimensRes.sp60,
                right: DimensRes.sp48,
                left: DimensRes.sp48,
              ),
              child: Column(
                children: [
                  Gaps.vGap24,
                  Text(
                    widget.message,
                    style: CommonTextStyles.mediumBold,
                    textAlign: TextAlign.center,
                  ),
                  Gaps.vGap24,
                  Row(
                    children: [
                      _buildFirstButton(),
                      if (widget.onButtonPress != null) Gaps.hGap12,
                      if (widget.onButtonPress != null)
                        Expanded(
                          child: CommonButton(
                            onPressed: widget.onButtonPress!,
                            title: 'Open',
                            padding: widget.paddingFirstButton ??
                                const EdgeInsets.symmetric(
                                  vertical: DimensRes.sp16,
                                  horizontal: DimensRes.sp20,
                                ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
