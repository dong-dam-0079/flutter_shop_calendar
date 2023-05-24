import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/view/home/controller/home_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_list_shop.dart';
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

  @override
  void initState() {
    super.initState();
    _homeController.getListShop();
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
        child: Obx(
          () => _homeController.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.current.title_new,
                      style: CommonTextStyles.largeBold,
                    ),
                    Gaps.vGap8,
                    Obx(
                      () => SizedBox(
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: _buildListNew(),
                      ),
                    ),
                    Gaps.vGap16,
                    Text(
                      S.current.title_popular,
                      style: CommonTextStyles.largeBold,
                    ),
                    Gaps.vGap8,
                    Expanded(
                      child: CommonListShop(
                        isVertical: true,
                        shop: _homeController.shopPopular,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildListNew() {
    return ListView.builder(
      itemCount: _homeController.shopNews.length,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        var news = _homeController.shopNews[index];

        return InkWell(
          onTap: () {
            HomeRouter.goDetail(context, shopModel: news);
          },
          child: Container(
            width: MediaQuery.of(context).size.width / 2.8,
            margin: const EdgeInsets.only(right: DimensRes.sp12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(DimensRes.sp4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(DimensRes.sp16),
                      color: ColorsRes.white,
                      boxShadow: [
                        BoxShadow(
                          color: ColorsRes.primary.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 0.5),
                        )
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(DimensRes.sp16),
                      child: Image.asset(
                        Assets.imgKeyboard,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CommonItemList(
                    isVertical: false,
                    item: news,
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
            style: CommonTextStyles.title,
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
        color: ColorsRes.primary,
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
        const PopupMenuItem(
          padding: EdgeInsets.zero,
          height: DimensRes.sp2,
          child: Gaps.vLine,
        ),
        _buildItemMenu(
          value: 2,
          S.current.button_go_history,
          Assets.icHistory,
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          HomeRouter.goFavorite(context);
        }
        if (value == 2) {
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
