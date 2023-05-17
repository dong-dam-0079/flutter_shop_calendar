import 'package:flutter/material.dart';

import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_text_styles.dart';

class ShopView extends StatefulWidget {
  const ShopView({Key? key}) : super(key: key);

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp16),
          child: DefaultTabController(
            length: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Home',
                  style: CommonTextStyles.largeBold,
                ),
                _buildTabTitle(),
                _buildTabView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabTitle() {
    return Container(
      height: DimensRes.sp44,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: DimensRes.sp32,
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
      child: TabBarView(
        children: [
          _buildTabItem(),
          _buildTabItem(),
        ],
      ),
    );
  }

  Widget _buildTabItem() {
    return Container(
      color: ColorsRes.red,
    );
  }
}
