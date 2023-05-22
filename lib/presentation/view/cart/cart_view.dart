import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/presentation/view/cart/controller/cart_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_list_shop.dart';

import '../../../common/constants/assets.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_gaps.dart';
import '../../widgets/common_text_styles.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final _cartController = serviceLocator<CartController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(DimensRes.sp16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Obx(
                () => _cartController.orderList.isEmpty
                    ? Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              Assets.icSad,
                              width: DimensRes.sp32,
                              height: DimensRes.sp32,
                            ),
                            Gaps.hGap8,
                            Text(
                              S.current.empty,
                              style: CommonTextStyles.mediumBold,
                            ),
                          ],
                        ),
                      )
                    : CommonListShop(
                        isVertical: true,
                        isShowRating: false,
                        isSlidable: true,
                        shop: _cartController.orderList,
                      ),
              ),
            ),
            Gaps.vGap2,
            Gaps.vLine,
            Gaps.vGap12,
            Text(
              S.current.title_order_info,
              style: CommonTextStyles.large20
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            Gaps.vGap24,
            _buildRowPrice(title: S.current.title_sub_total, price: '75'),
            Gaps.vGap8,
            _buildRowPrice(title: S.current.title_sub_total, price: '5'),
            Gaps.vGap16,
            _buildRowPrice(
              title: S.current.title_sub_total,
              price: '80',
              isTotal: true,
            ),
            Gaps.vGap16,
            SizedBox(
              width: double.infinity,
              child: CommonButton(
                onPressed: () {},
                title: S.current.button_buy,
              ),
            )
          ],
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
            S.current.cart,
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

  Widget _buildRowPrice({
    required String title,
    required String price,
    bool? isTotal,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: CommonTextStyles.medium.copyWith(color: ColorsRes.textGray),
          ),
        ),
        Text(
          '\$$price',
          style: isTotal ?? false
              ? CommonTextStyles.large20.copyWith(fontWeight: FontWeight.w700)
              : CommonTextStyles.medium,
        )
      ],
    );
  }
}
