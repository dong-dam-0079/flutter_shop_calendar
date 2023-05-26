import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/res/colors.dart';
import 'package:shop_laptop_project/data/model/order_model.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_box.dart';

import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_text_styles.dart';

class PayView extends StatefulWidget {
  const PayView({Key? key, required this.order}) : super(key: key);
  final OrderModel order;

  @override
  State<PayView> createState() => _PayViewState();
}

class _PayViewState extends State<PayView>
    with BaseMixin, SingleTickerProviderStateMixin {
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _phoneCtrl.text = '0961370710';
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _addressCtrl.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensRes.sp16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.complete_your_order,
              style: CommonTextStyles.large20,
            ),
            Gaps.vGap32,
            _buildOrderInfo(
              labelText: S.current.phone_number,
              controller: _phoneCtrl,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              obscureText: false,
              autoFocus: false,
            ),
            Gaps.vGap24,
            _buildOrderInfo(
              labelText: S.current.address,
              controller: _addressCtrl,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
              autoFocus: false,
            ),
            Gaps.vGap24,
            Text(
              S.current.time_order,
              style: CommonTextStyles.mediumBold,
            ),
            Gaps.vGap16,
            _buildTimeOrder(),
            Gaps.vGap24,
            Text(
              S.current.pay_method,
              style: CommonTextStyles.mediumBold,
            ),
            Gaps.vGap16,
            _buildPaymentMethods(),
            SizedBox(
              height: DimensRes.sp8,
              child: TabBarView(
                controller: _tabController,
                children: [
                  Container(),
                  Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeOrder() {
    return Row(
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: DimensRes.sp16,
              horizontal: DimensRes.sp32,
            ),
            decoration: BoxDecoration(
              color: ColorsRes.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DimensRes.sp8),
            ),
            child: const Align(
                alignment: Alignment.center,
                child: Text(
                  '2023/05/28',
                  style: CommonTextStyles.medium,
                )),
          ),
        ),
        Gaps.hGap16,
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(DimensRes.sp16),
            decoration: BoxDecoration(
              color: ColorsRes.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DimensRes.sp8),
            ),
            child: const Text(
              '12:30',
              style: CommonTextStyles.medium,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildPaymentMethods() {
    return Container(
      height: DimensRes.sp44,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        vertical: DimensRes.sp16,
      ),
      padding: const EdgeInsets.all(DimensRes.sp4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(DimensRes.sp10)),
        color: ColorsRes.borderGray,
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRes.sp8),
          color: Colors.white,
        ),
        tabs: [
          _buildTab(S.current.cash_method),
          _buildTab(S.current.atm_method),
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

  CommonAppBar _buildAppBar() {
    return CommonAppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          Assets.icBack,
          width: DimensRes.sp20,
          height: DimensRes.sp20,
        ),
      ),
    );
  }

  Widget _buildOrderInfo({
    required String labelText,
    required TextEditingController controller,
    required TextInputAction textInputAction,
    required bool obscureText,
    required bool autoFocus,
    TextInputType? keyboardType,
  }) {
    return CommonTextBox(
      backgroundColor: ColorsRes.white,
      inputTextStyle: CommonTextStyles.medium.copyWith(color: Colors.black),
      textInputAction: textInputAction,
      labelText: labelText,
      controller: controller,
      obscureText: obscureText,
      autoFocus: autoFocus,
      keyboardType: keyboardType,
    );
  }
}
