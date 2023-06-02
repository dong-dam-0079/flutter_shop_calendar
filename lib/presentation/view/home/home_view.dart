import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/view/home/controller/home_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

import '../../../common/constants/assets.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_gaps.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _homeController = serviceLocator<HomeController>();
  List<DateTime?> initDate = [DateTime.now()];

  @override
  void initState() {
    super.initState();
    _homeController.getListShop();
  }

  @override
  void dispose() {
    super.dispose();
    _homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(
          left: DimensRes.sp16,
          right: DimensRes.sp16,
          top: DimensRes.sp16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.single),
                value: initDate,
                onValueChanged: (dates) {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  CommonAppBar _buildAppBar(BuildContext context) {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      widgetTitle: Padding(
        padding: const EdgeInsets.only(left: DimensRes.sp16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.home,
            style: CommonTextStyles.title.copyWith(color: ColorsRes.white),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: DimensRes.sp16),
          child: Theme(
            data: Theme.of(context).copyWith(
              tooltipTheme: const TooltipThemeData(
                decoration: BoxDecoration(color: ColorsRes.transparent),
              ),
            ),
            child: _buildButtonMenu(),
          ),
        ),
      ],
    );
  }

  PopupMenuButton<dynamic> _buildButtonMenu() {
    return PopupMenuButton(
      tooltip: '',
      icon: SvgPicture.asset(
        Assets.icMenu,
        height: DimensRes.sp20,
        width: DimensRes.sp20,
        color: ColorsRes.white,
      ),
      padding: const EdgeInsets.only(right: DimensRes.sp8),
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DimensRes.sp12),
        ),
      ),
      itemBuilder: (context) => [
        _buildItemMenu(
          value: 1,
          S.current.button_go_favorite,
          Assets.icFavorite,
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          HomeRouter.goFavorite(context);
        }
      },
    );
  }

  PopupMenuItem<dynamic> _buildItemMenu(
    String title,
    String icon, {
    required int value,
  }) {
    return PopupMenuItem(
      value: value,
      child: _buildRowItem(
        title: title,
        icon: icon,
      ),
    );
  }

  Widget _buildRowItem({
    required String title,
    required String icon,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: DimensRes.sp20,
          height: DimensRes.sp20,
          color: ColorsRes.primary,
        ),
        Gaps.hGap8,
        Text(
          title,
          style: CommonTextStyles.medium,
        ),
        Gaps.hGap16,
      ],
    );
  }
}
