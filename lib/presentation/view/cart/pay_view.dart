import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

class _PayViewState extends State<PayView> {
  final _addressCtrl = TextEditingController();
  final _timeOrderCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _addressCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(DimensRes.sp16),
        child: Column(
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
              autoFocus: true,
            ),
            Gaps.vGap16,
            _buildOrderInfo(
              labelText: S.current.address,
              controller: _addressCtrl,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              obscureText: false,
              autoFocus: false,
            ),
            Gaps.vGap16,
            _buildOrderInfo(
              labelText: S.current.time_order,
              controller: _timeOrderCtrl,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.text,
              obscureText: false,
              autoFocus: false,
            ),
            Gaps.vGap16,
          ],
        ),
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
