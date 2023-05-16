import 'package:flutter/material.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';

class CommonTextStyles {
  static const primary = TextStyle(
    color: ColorsRes.primary,
    fontSize: DimensRes.sp16,
  );

  static const large = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp24,
    fontWeight: FontWeight.w400,
  );

  static const large20 = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp20,
    fontWeight: FontWeight.w400,
  );

  static const medium = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp14,
    fontWeight: FontWeight.w400,
  );

  static const mediumBold = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp14,
    fontWeight: FontWeight.w700,
  );

  static const small = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp12,
    fontWeight: FontWeight.w400,
  );

  static const smallExtra = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp10,
    fontWeight: FontWeight.w400,
  );

  static const smallExtraX = TextStyle(
    color: ColorsRes.black,
    fontSize: DimensRes.sp8,
    fontWeight: FontWeight.w400,
  );
}
