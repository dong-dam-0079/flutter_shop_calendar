import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/constants/assets.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_text_styles.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField({
    Key? key,
    required this.controller,
    this.focusNode,
    this.maxLength = 100,
    this.cursorColor,
    this.autoFocus = false,
    this.keyboardType = TextInputType.text,
    this.hintText,
    this.startIcon,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderFocusColor,
    this.borderFocusWidth = 1.0,
    this.backgroundColor,
    this.errorText,
    this.errorStyle,
    this.minLines = 1,
    this.inputTextStyle,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.enable,
    this.textInputAction,
    this.isShowBorder = true,
    this.obscureText = false,
    this.autoValidateMode,
    this.validator,
    this.inputFormatters,
    this.expands = false,
    this.contentPadding,
    this.maxLines = 1,
    this.onChanged,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.autofillHints,
    this.suffix,
    this.enableCopy,
    this.enablePaste,
    this.enableSelectAll,
    this.borderRadius,
  }) : super(key: key);

  final FocusNode? focusNode;
  final bool autoFocus;
  final AutovalidateMode? autoValidateMode;
  final Iterable<String>? autofillHints;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final Color? borderFocusColor;
  final double borderFocusWidth;
  final Color? cursorColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller;
  final bool? enable;
  final TextStyle? errorStyle;
  final String? errorText;
  final bool expands;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? inputTextStyle;
  final bool isShowBorder;
  final TextInputType? keyboardType;
  final int maxLength;
  final int? maxLines;
  final int? minLines;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final Widget? startIcon;
  final Widget? suffix;
  final TextAlign textAlign;
  final TextAlignVertical? textAlignVertical;
  final TextInputAction? textInputAction;
  final FormFieldValidator<String>? validator;
  final bool? enableCopy;
  final bool? enablePaste;
  final bool? enableSelectAll;
  final BorderRadius? borderRadius;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _borderRadius = BorderRadius.circular(DimensRes.sp8);
  bool _isShowDelete = false;
  bool _passwordVisible = false;
  bool _isShowPasswordIcon = false;

  @override
  void dispose() {
    widget.controller.removeListener(isEmpty);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void isEmpty() {
    bool isNotEmpty = widget.controller.text.isNotEmpty;

    /// State is not the same as refreshing, avoid repeating unnecessary setState
    if (isNotEmpty != _isShowDelete) {
      setState(() {
        _isShowDelete = isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      toolbarOptions: ToolbarOptions(
        copy: widget.enableCopy ?? false,
        paste: widget.enablePaste ?? false,
        selectAll: widget.enableSelectAll ?? false,
      ),
      focusNode: widget.focusNode,
      expands: widget.expands,
      autofillHints: widget.autofillHints,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.center,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      style: widget.inputTextStyle ??
          CommonTextStyles.medium.copyWith(color: Colors.black),
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      enabled: widget.enable ?? true,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      cursorColor: widget.cursorColor ?? ColorsRes.primary,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.backgroundColor,
        contentPadding:
            widget.contentPadding ?? const EdgeInsets.all(DimensRes.sp12),
        hintStyle: widget.hintStyle ??
            CommonTextStyles.medium.copyWith(
              color: ColorsRes.textDisable,
            ),
        isDense: true,
        hintText: widget.hintText,
        errorText: widget.errorText,
        errorStyle: widget.errorStyle ??
            CommonTextStyles.medium.copyWith(
              color: Colors.redAccent,
              height: 1.2,
            ),
        errorMaxLines: 3,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle ??
            CommonTextStyles.medium.copyWith(
              color: ColorsRes.textDisable,
            ),
        floatingLabelStyle: CommonTextStyles.primary.copyWith(
          fontSize: DimensRes.sp16,
        ),
        prefixIcon: widget.startIcon,
        counterText: '',
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: widget.borderFocusWidth,
          ),
          borderRadius: widget.borderRadius ?? _borderRadius,
        ),
        focusedBorder: widget.isShowBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderFocusColor ?? ColorsRes.primary,
                  width: widget.borderFocusWidth,
                ),
                borderRadius: widget.borderRadius ?? _borderRadius,
              )
            : InputBorder.none,
        enabledBorder: widget.isShowBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? ColorsRes.borderGray,
                  width: widget.borderWidth,
                ),
                borderRadius: widget.borderRadius ?? _borderRadius,
              )
            : InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: widget.borderWidth,
          ),
          borderRadius: widget.borderRadius ?? _borderRadius,
        ),
        disabledBorder: widget.isShowBorder
            ? OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.borderColor ?? Colors.grey,
                  width: widget.borderWidth,
                ),
                borderRadius: widget.borderRadius ?? _borderRadius,
              )
            : InputBorder.none,
        suffixIcon: widget.obscureText && _isShowPasswordIcon
            ? InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    _passwordVisible
                        ? Assets.icVisibleOff
                        : Assets.icVisibleOn,
                    width: DimensRes.sp15,
                    height: DimensRes.sp15,
                    color: ColorsRes.primary.withOpacity(0.5),
                  ),
                ),
                onTap: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : widget.suffix,
      ),
      obscureText: widget.obscureText ? !_passwordVisible : widget.obscureText,
      validator: widget.validator,
      autovalidateMode: widget.autoValidateMode,
      onChanged: (value) {
        setState(() {
          _isShowPasswordIcon = value.isEmpty ? false : widget.obscureText;
          if (widget.onChanged != null) {
            widget.onChanged!(value);
          }
        });
      },
    );
  }
}
