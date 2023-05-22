import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/presentation/view/shop/controller/shop_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_list_shop.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../data/model/shop_model.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_gaps.dart';
import '../../widgets/common_text_styles.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  final _shopController = serviceLocator<ShopController>();

  @override
  void initState() {
    super.initState();
    _shopController.getListShop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp16),
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.vLine,
                _buildTabTitle(),
                _buildTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  CommonAppBar _buildAppBar() {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      widgetTitle: Padding(
        padding: const EdgeInsets.only(left: DimensRes.sp16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.shop,
            style: CommonTextStyles.title,
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: ColorsRes.primary,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildTabTitle() {
    return Container(
      height: DimensRes.sp44,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: DimensRes.sp16,
      ),
      padding: const EdgeInsets.all(DimensRes.sp4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(DimensRes.sp12)),
        color: ColorsRes.borderGray,
      ),
      child: TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRes.sp12),
          color: Colors.white,
        ),
        tabs: [
          _buildTab(S.current.tab_service),
          _buildTab(S.current.tab_device),
        ],
        indicatorColor: ColorsRes.transparent,
        labelStyle: CommonTextStyles.medium,
        labelColor: ColorsRes.primary,
        unselectedLabelColor: ColorsRes.primary,
      ),
    );
  }

  Tab _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: CommonTextStyles.medium,
      ),
    );
  }

  Widget _buildTabView() {
    return Expanded(
      child: Obx(
        () => _shopController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : TabBarView(
                children: [
                  _buildTabItem(_shopController.shopDevices),
                  _buildTabItem(_shopController.shopServices),
                ],
              ),
      ),
    );
  }

  Widget _buildTabItem(List<ShopModel> listShop) {
    return CommonListShop(
      isVertical: true,
      isShopButton: true,
      shop: listShop,
    );
  }
}
