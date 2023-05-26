import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/extensions/date_extension.dart';
import 'package:shop_laptop_project/common/res/colors.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/presentation/view/cart/controller/cart_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_box.dart';

import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_text_styles.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({Key? key}) : super(key: key);

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView>
    with BaseMixin, SingleTickerProviderStateMixin {
  final _cartController = serviceLocator<CartController>();

  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _phoneCtrl.text = _cartController.phone.value;
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          _buildPrice(),
          Expanded(
            child: SingleChildScrollView(
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
                  Gaps.vGap8,
                  _buildTimeOrder(),
                  Gaps.vGap24,
                  Text(
                    S.current.pay_method,
                    style: CommonTextStyles.mediumBold,
                  ),
                  Gaps.vGap8,
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
                  Text(
                    S.current.sorry_atm,
                    style: CommonTextStyles.small
                        .copyWith(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          ),
          _buildButtonPay(),
          Gaps.vGap16,
        ],
      ),
    );
  }

  Container _buildButtonPay() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: DimensRes.sp16),
      child: CommonButton(
        onPressed: () {
          if (_phoneCtrl.text.isEmpty || _addressCtrl.text.isEmpty) {
            _showToast('Please, filling all information');
          } else {
            _showToast('Order Success');
            _cartController.orderList.clear();
            _cartController
                .payment(location: _addressCtrl.text)
                .then((value) => Navigator.pop(context));
          }
        },
        title: 'Payment',
      ),
    );
  }

  void _showToast(String title) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          title,
          style: CommonTextStyles.mediumBold.copyWith(color: ColorsRes.white),
        ),
        backgroundColor: ColorsRes.secondary,
      ),
    );
  }

  Widget _buildPrice() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: DimensRes.sp24),
      decoration: BoxDecoration(
        color: ColorsRes.primary.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(DimensRes.sp16),
          bottomRight: Radius.circular(DimensRes.sp16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset(
              Assets.icBack,
              color: ColorsRes.white,
              width: DimensRes.sp20,
              height: DimensRes.sp20,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(DimensRes.sp42),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ColorsRes.white,
            ),
            child: Center(
              child: Obx(
                () => Text(
                  '\$${_cartController.total}',
                  style: CommonTextStyles.mediumBold
                      .copyWith(fontSize: DimensRes.sp32),
                ),
              ),
            ),
          ),
          Gaps.vGap8,
          Center(
            child: Text(
              'Current Price',
              style: CommonTextStyles.medium.copyWith(color: ColorsRes.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeOrder() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            _showDatePicker();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: DimensRes.sp16,
              horizontal: DimensRes.sp32,
            ),
            decoration: BoxDecoration(
              color: ColorsRes.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DimensRes.sp8),
            ),
            child: Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Text(
                    _cartController.dayOrder.value,
                    style: CommonTextStyles.medium,
                  ),
                )),
          ),
        ),
        Gaps.hGap16,
        InkWell(
          onTap: () {
            _showDatePicker();
          },
          child: Container(
            padding: const EdgeInsets.all(DimensRes.sp16),
            decoration: BoxDecoration(
              color: ColorsRes.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(DimensRes.sp8),
            ),
            child: Obx(
              () => Text(
                _cartController.timeOrder.value,
                style: CommonTextStyles.medium,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _showDatePicker() {
    showCupertinoModalPopup(
        context: context,
        builder: (ctx) {
          return Container(
            height: 250,
            color: const Color.fromARGB(255, 255, 255, 255),
            child: Column(
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (val) {
                      _cartController.dayOrder.value = val.toStringWithDate();
                      _cartController.timeOrder.value = val.toStringWithTime();
                    },
                  ),
                ),
                CupertinoButton(
                  child: Text(
                    'OK',
                    style: CommonTextStyles.mediumBold.copyWith(
                      color: ColorsRes.primary,
                      fontSize: DimensRes.sp18,
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                )
              ],
            ),
          );
        });
  }

  Widget _buildPaymentMethods() {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(DimensRes.sp4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(DimensRes.sp10)),
        color: ColorsRes.primary.withOpacity(0.2),
      ),
      child: IgnorePointer(
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
