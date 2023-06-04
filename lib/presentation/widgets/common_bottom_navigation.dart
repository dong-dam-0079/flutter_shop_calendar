import 'package:flutter/material.dart';

import '../../common/constants/assets.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../generated/l10n.dart';
import 'common_icons.dart';

enum BottomNavItem { home, shop, cart, profile }

class CommonBottomNavigation extends StatelessWidget {
  const CommonBottomNavigation({
    Key? key,
    required this.currentNavItem,
    required this.onNavItemSelected,
  }) : super(key: key);

  final BottomNavItem currentNavItem;
  final Function(BottomNavItem) onNavItemSelected;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentNavItem.index,
      unselectedItemColor: ColorsRes.textGray,
      selectedItemColor: ColorsRes.primary,
      selectedFontSize: DimensRes.sp12,
      unselectedFontSize: DimensRes.sp12,
      backgroundColor: ColorsRes.white,
      items: [
        _buildNavItem(
          activeIcon: Assets.icCalendar,
          icon: Assets.icCalendar,
          label: S.current.calendar,
        ),
        _buildNavItem(
          activeIcon: Assets.icShop,
          icon: Assets.icShop,
          label: S.current.shop,
        ),
        _buildNavItem(
          activeIcon: Assets.icCart,
          icon: Assets.icCart,
          label: S.current.cart,
        ),
        _buildNavItem(
          activeIcon: Assets.icProfile,
          icon: Assets.icProfile,
          label: S.current.profile,
        ),
      ],
      onTap: (index) => onNavItemSelected(
        BottomNavItem.values[index],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required String activeIcon,
    required String icon,
    required String label,
    bool isSvgIcon = true,
  }) {
    return BottomNavigationBarItem(
      activeIcon: CommonAssetIcon(
        iconPath: activeIcon,
        iconColor: ColorsRes.primary,
        isSvg: isSvgIcon,
      ),
      icon: CommonAssetIcon(
        iconPath: icon,
        iconColor: ColorsRes.textGray,
        isSvg: isSvgIcon,
      ),
      label: label,
    );
  }
}
