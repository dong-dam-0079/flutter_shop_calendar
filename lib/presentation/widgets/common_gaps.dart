import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../common/res/colors.dart';

@singleton
class Gaps {
  /// Blank space between items in row
  static const hGap2 = SizedBox(width: 2);
  static const hGap4 = SizedBox(width: 4);
  static const hGap5 = SizedBox(width: 5);
  static const hGap6 = SizedBox(width: 6);
  static const hGap8 = SizedBox(width: 8);
  static const hGap10 = SizedBox(width: 10);
  static const hGap12 = SizedBox(width: 12);
  static const hGap15 = SizedBox(width: 15);
  static const hGap16 = SizedBox(width: 16);
  static const hGap18 = SizedBox(width: 18);
  static const hGap22 = SizedBox(width: 22);
  static const hGap24 = SizedBox(width: 24);
  static const hGap32 = SizedBox(width: 32);
  static const hGap40 = SizedBox(width: 40);
  static const hGap50 = SizedBox(width: 50);
  static const hGap80 = SizedBox(width: 80);

  /// Blank space between items in column
  static const vGap2 = SizedBox(height: 2);
  static const vGap4 = SizedBox(height: 4);
  static const vGap5 = SizedBox(height: 5);
  static const vGap6 = SizedBox(height: 6);
  static const vGap8 = SizedBox(height: 8);
  static const vGap10 = SizedBox(height: 10);
  static const vGap12 = SizedBox(height: 12);
  static const vGap15 = SizedBox(height: 15);
  static const vGap16 = SizedBox(height: 16);
  static const vGap20 = SizedBox(height: 20);
  static const vGap22 = SizedBox(height: 22);
  static const vGap24 = SizedBox(height: 24);
  static const vGap26 = SizedBox(height: 26);
  static const vGap30 = SizedBox(height: 30);
  static const vGap32 = SizedBox(height: 32);
  static const vGap40 = SizedBox(height: 40);
  static const vGap44 = SizedBox(height: 44);
  static const vGap46 = SizedBox(height: 46);
  static const vGap50 = SizedBox(height: 50);
  static const vGap55 = SizedBox(height: 55);
  static const vGap60 = SizedBox(height: 60);
  static const vGap70 = SizedBox(height: 70);
  static const vGap80 = SizedBox(height: 80);
  static const vGap100 = SizedBox(height: 100);
  static const vGap200 = SizedBox(height: 200);

  /// Vertical line
  static const vLine = SizedBox(
    height: 1,
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(color: ColorsRes.borderList),
    ),
  );

  /// Vertical line
  static const vLineSmall = SizedBox(
    height: 1,
    width: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(color: ColorsRes.borderGray),
    ),
  );

  /// Horizontal line
  static const hLine = SizedBox(
    width: 1,
    height: double.infinity,
    child: DecoratedBox(
      decoration: BoxDecoration(color: ColorsRes.borderList),
    ),
  );

  SizedBox vLineDecor(
          [double height = 1.5, Color color = ColorsRes.borderGray]) =>
      SizedBox(
        height: height,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(color: color),
        ),
      );

  static const Divider line = Divider();
  static const empty = SizedBox.shrink();
}
