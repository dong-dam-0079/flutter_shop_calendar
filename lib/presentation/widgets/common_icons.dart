import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';

class CommonAssetIcon extends StatelessWidget {
  const CommonAssetIcon({
    Key? key,
    required this.iconPath,
    this.height = DimensRes.sp20,
    this.width = DimensRes.sp20,
    this.iconColor = ColorsRes.darkGray,
    required this.isSvg,
  }) : super(key: key);

  final String iconPath;
  final double? height;
  final double? width;
  final Color? iconColor;
  final bool isSvg;

  @override
  Widget build(BuildContext context) {
    return isSvg
        ? SvgPicture.asset(
            iconPath,
            height: height,
            width: width,
            color: iconColor,
          )
        : Image.asset(
            iconPath,
            height: height,
            width: width,
            color: iconColor,
          );
  }
}
