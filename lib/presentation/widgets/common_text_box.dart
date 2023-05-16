import 'package:flutter/material.dart';

import '../../common/constants/common_constants.dart';
import 'common_text_field.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_text_styles.dart';

class CommonTextBox extends StatefulWidget {
  const CommonTextBox({
    Key? key,
    required this.controller,
    this.textInputAction,
    this.startIcon,
    this.labelStyle,
    this.inputTextStyle,
    this.labelText,
    this.backgroundColor,
    this.obscureText = false,
    this.autoFocus = false,
    this.contentPadding,
    this.enableCopy,
    this.enablePaste,
    this.enableSelectAll,
  }) : super(key: key);

  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool autoFocus;
  final Color? backgroundColor;
  final String? labelText;
  final Widget? startIcon;
  final TextStyle? labelStyle;
  final TextStyle? inputTextStyle;
  final EdgeInsetsGeometry? contentPadding;
  final bool? enableCopy;
  final bool? enablePaste;
  final bool? enableSelectAll;

  @override
  State<CommonTextBox> createState() => _CommonTextBoxState();
}

class _CommonTextBoxState extends State<CommonTextBox> {
  final _focusNode = FocusNode();

  var _borderColor = ColorsRes.borderGray;
  var _borderWidth = CommonConstants.borderWidth;

  var _paddingContainer = EdgeInsets.zero;
  var _contentPadding = const EdgeInsets.all(DimensRes.sp16);

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        // Set border when text field change focus
        _borderColor =
            _focusNode.hasFocus ? ColorsRes.primary : ColorsRes.borderGray;
        _borderWidth = _focusNode.hasFocus
            ? CommonConstants.borderFocusWidth
            : CommonConstants.borderWidth;

        // Set padding when text field change focus and text change
        if (_focusNode.hasFocus || widget.controller.text.isNotEmpty) {
          _paddingContainer = const EdgeInsets.only(
            left: DimensRes.sp16,
            right: DimensRes.sp16,
            top: DimensRes.sp16,
          );
          _contentPadding = const EdgeInsets.only(top: DimensRes.sp16);
        } else {
          _contentPadding = const EdgeInsets.all(DimensRes.sp16);
          _paddingContainer = EdgeInsets.zero;
        }
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: _paddingContainer,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(
          color: _borderColor,
          width: _borderWidth,
        ),
        borderRadius: BorderRadius.circular(DimensRes.sp8),
      ),
      child: CommonTextField(
        focusNode: _focusNode,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        contentPadding: _contentPadding,
        controller: widget.controller,
        startIcon: widget.startIcon,
        autoFocus: widget.autoFocus,
        obscureText: widget.obscureText,
        borderColor: ColorsRes.transparent,
        borderFocusColor: ColorsRes.transparent,
        backgroundColor: widget.backgroundColor ?? ColorsRes.transparent,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        inputTextStyle: widget.inputTextStyle ??
            CommonTextStyles.medium.copyWith(color: Colors.black),
        enableCopy: widget.enableCopy,
        enablePaste: widget.enablePaste,
        enableSelectAll: widget.enableSelectAll,
      ),
    );
  }
}
