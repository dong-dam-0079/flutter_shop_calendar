import 'package:flutter/material.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_gaps.dart';
import 'common_text_styles.dart';

class CommonSnackBar extends StatelessWidget {
  const CommonSnackBar({
    Key? key,
    this.title,
    required this.isError,
  }) : super(key: key);

  final String? title;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp48),
      child: isError
          ? Container(
              height: DimensRes.sp48,
              decoration: BoxDecoration(
                color: ColorsRes.error,
                border: Border.all(
                  color: ColorsRes.error,
                ),
                borderRadius: BorderRadius.circular(DimensRes.sp28),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Spacer(),
                    Gaps.hGap16,
                    Text(
                      'Error',
                      style: CommonTextStyles.mediumBold.copyWith(
                        color: ColorsRes.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          : Container(
              height: DimensRes.sp48,
              decoration: BoxDecoration(
                color: ColorsRes.bottomSheetTitle,
                border: Border.all(
                  color: ColorsRes.bottomSheetTitle,
                ),
                borderRadius: BorderRadius.circular(DimensRes.sp28),
              ),
              child: Center(
                child: Row(
                  children: [
                    const Spacer(),
                    Gaps.hGap16,
                    Text(
                      title ?? '',
                      style: CommonTextStyles.mediumBold.copyWith(
                        color: ColorsRes.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
    );
  }
}
