import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/data/model/shop_model.dart';
import 'package:shop_laptop_project/presentation/view/cart/controller/cart_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';

import '../../common/constants/assets.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../generated/l10n.dart';
import 'common_gaps.dart';
import 'common_text_styles.dart';

class CommonListShop extends StatelessWidget {
  CommonListShop({
    Key? key,
    required this.isVertical,
    this.isShopButton,
    this.isShowRating,
    required this.shop,
    this.isSlidable,
  }) : super(key: key);

  final bool isVertical;
  final bool? isShopButton;
  final bool? isShowRating;
  final bool? isSlidable;
  final List<ShopModel> shop;

  final _cartController = serviceLocator<CartController>();

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        itemCount: shop.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          var item = shop[index];

          return InkWell(
            onTap: () {
              HomeRouter.goDetail(context, shopModel: item);
            },
            child: Hero(
              tag: item.shopId,
              child: Container(
                margin: const EdgeInsets.only(bottom: DimensRes.sp16),
                padding: const EdgeInsets.all(DimensRes.sp4),
                decoration: BoxDecoration(
                  color: ColorsRes.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(DimensRes.sp16),
                ),
                child: Slidable(
                  key: UniqueKey(),
                  enabled: isSlidable ?? false,
                  groupTag: 'group',
                  endActionPane: ActionPane(
                    extentRatio: 0.25,
                    motion: const ScrollMotion(),
                    children: [
                      SlidableAction(
                        onPressed: (context) {},
                        backgroundColor: ColorsRes.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete_forever_rounded,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(DimensRes.sp16),
                          bottomRight: Radius.circular(DimensRes.sp16),
                        ),
                      ),
                    ],
                  ),
                  child: _itemList(item),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _itemList(ShopModel item) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(DimensRes.sp16)),
      child: Row(
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
                    color: ColorsRes.primary.withOpacity(0.4),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 0.5),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(DimensRes.sp16),
                child: item.isCateDevices
                    ? Image.asset(
                        Assets.imgSetting,
                        fit: BoxFit.fill,
                      )
                    : Image.asset(
                        Assets.imgKeyboard,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
          Gaps.hGap12,
          Expanded(
            flex: 3,
            child: CommonItemList(
              isVertical: isVertical,
              isShopButton: isShopButton,
              isShowRating: isShowRating,
              item: item,
              onClickAdd: () {
                _cartController.addToCart(item);
              },
            ),
          ),
          Gaps.hGap4,
        ],
      ),
    );
  }
}

class CommonItemList extends StatelessWidget {
  const CommonItemList({
    super.key,
    required this.isVertical,
    this.isShopButton,
    this.isShowRating,
    required this.item,
    this.onClickAdd,
  });

  final bool isVertical;
  final bool? isShopButton;
  final bool? isShowRating;
  final ShopModel item;
  final Function()? onClickAdd;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Text(
            item.itemName,
            style: CommonTextStyles.medium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gaps.vGap4,
        Visibility(
          visible: isShowRating ?? true,
          child: Row(
            mainAxisAlignment:
                isVertical ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Flexible(
                child: RatingBar.builder(
                  itemSize: DimensRes.sp16,
                  initialRating: item.rating,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              Gaps.hGap8,
              Text(
                item.rating.toString(),
                style: CommonTextStyles.mediumBold,
              ),
            ],
          ),
        ),
        Gaps.vGap4,
        Visibility(
          visible: isVertical,
          child: Flexible(
            child: Text(
              item.describe,
              style: CommonTextStyles.small.copyWith(color: ColorsRes.darkGray),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Gaps.vGap8,
        Visibility(
          visible: isVertical,
          child: Flexible(
            child: Text(
              '\$${item.price}',
              style: CommonTextStyles.mediumBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Gaps.vGap8,
        Visibility(
          visible: isShopButton ?? false,
          child: SizedBox(
            width: double.infinity,
            child: CommonButton(
              onPressed: onClickAdd,
              title: S.current.button_add_to_cart,
              padding: const EdgeInsets.symmetric(vertical: DimensRes.sp8),
            ),
          ),
        ),
      ],
    );
  }
}
