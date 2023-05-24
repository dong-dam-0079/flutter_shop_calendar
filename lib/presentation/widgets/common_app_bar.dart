import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../config/router/utils/navigator_utils.dart';
import 'common_text_styles.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    Key? key,
    this.title,
    this.titleTextStyle,
    this.backgroundColor,
    this.centerTitle,
    this.actions,
    this.elevation,
    this.onTap,
    this.leading,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.systemUiOverlayStyle,
    this.widgetTitle,
  }) : super(key: key);

  final String? title;
  final Widget? widgetTitle;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final bool? centerTitle;
  final bool automaticallyImplyLeading;
  final List<Widget>? actions;
  final double? elevation;
  final VoidCallback? onTap;
  final Widget? leading;
  final SystemUiOverlayStyle? systemUiOverlayStyle;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      title: widgetTitle ??
          Text(
            title ?? '',
            style: titleTextStyle ??
                CommonTextStyles.title.copyWith(
                  color: ColorsRes.primary,
                ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      systemOverlayStyle: systemUiOverlayStyle ??
          const SystemUiOverlayStyle(
            statusBarColor: ColorsRes.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
      backgroundColor: backgroundColor ?? ColorsRes.backgroundTheme,
      elevation: elevation ?? 0.0,
      centerTitle: centerTitle ?? false,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: leading != null
          ? InkWell(
              borderRadius: BorderRadius.circular(DimensRes.sp30),
              onTap: onTap ??
                  () {
                    NavigatorUtils.goBack(context);
                  },
              child: leading,
            )
          : null,
      actions: actions,
      bottom: bottom ?? PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: ColorsRes.primary.withOpacity(0.2),
          height: 1,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
