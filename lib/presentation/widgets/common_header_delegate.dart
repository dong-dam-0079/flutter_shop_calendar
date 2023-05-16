import 'package:flutter/material.dart';

import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import 'common_text_styles.dart';

class CommonHeaderDelegate extends SliverPersistentHeaderDelegate {
  CommonHeaderDelegate({
    required this.title,
    required this.appBar,
    this.backgroundColor,
    this.maxHeight,
  });

  final String title;
  final Widget appBar;
  final Color? backgroundColor;
  final double? maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final value = (shrinkOffset > (maxExtent - minExtent)
                ? (maxExtent - minExtent)
                : shrinkOffset) /
            (maxExtent - minExtent) +
        -1;
    final progress = shrinkOffset / maxExtent;

    return Container(
      color: backgroundColor ?? ColorsRes.backgroundTheme,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment(value, 1),
            child: Opacity(
              opacity: 1 - progress,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      color: ColorsRes.transparent,
                      height: minExtent,
                      alignment: Alignment(value, 0),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24 + 24 * progress,
                      ),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle.lerp(
                          CommonTextStyles.large,
                          CommonTextStyles.medium,
                          progress,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment(progress, 1),
            child: Opacity(
              opacity: progress,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 48),
                      color: ColorsRes.transparent,
                      height: minExtent,
                      alignment: Alignment(value, 0),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: CommonTextStyles.medium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          appBar,
        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeight ?? DimensRes.sp100;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
