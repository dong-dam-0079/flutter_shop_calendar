import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_laptop_project/common/constants/common_constants.dart';
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
    this.isShowCount,
  }) : super(key: key);

  final bool isVertical;
  final bool? isShopButton;
  final bool? isShowRating;
  final bool? isSlidable;
  final bool? isShowCount;
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
            highlightColor: ColorsRes.transparent,
            splashColor: ColorsRes.transparent,
            onTap: () {
              HomeRouter.goDetail(context, shopModel: item);
            },
            child: Hero(
              tag: item.shopId,
              child: Container(
                margin: const EdgeInsets.all(DimensRes.sp16),
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
                        onPressed: (context) {
                          _cartController.removeFromCart(item);
                        },
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
                  child: _itemList(item, context),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _itemList(ShopModel item, BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(DimensRes.sp16)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: 140,
              width: 140,
              margin: const EdgeInsets.all(DimensRes.sp4),
              padding: EdgeInsets.all(
                  item.isCateServices ? DimensRes.sp32 : DimensRes.sp0),
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
                child: item.isCateServices
                    ? Image.asset(
                        Assets.imgSetting,
                        fit: BoxFit.fill,
                      )
                    : CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            item.linkImage ?? CommonConstants.defaultLinkImg,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            Assets.imgSetting,
                            fit: BoxFit.fill,
                          );
                        },
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
              isShowCount: isShowCount,
              item: item,
              onClickAdd: () {
                _cartController.addToCart(item);
                _showToast(context);
              },
            ),
          ),
          Gaps.hGap4,
        ],
      ),
    );
  }

  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 500),
        content: Text(
          'Added to Cart',
          style: CommonTextStyles.mediumBold.copyWith(color: ColorsRes.white),
        ),
        backgroundColor: ColorsRes.secondary,
      ),
    );
  }
}

class CommonItemList extends StatelessWidget {
  CommonItemList({
    super.key,
    required this.isVertical,
    this.isShopButton,
    this.isShowRating,
    required this.item,
    this.onClickAdd,
    this.isShowCount,
  });

  final bool isVertical;
  final bool? isShopButton;
  final bool? isShowRating;
  final bool? isShowCount;
  final ShopModel item;
  final Function()? onClickAdd;

  final _cartController = serviceLocator<CartController>();

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
        _buildRating(),
        Gaps.vGap4,
        _buildDescribe(),
        Gaps.vGap8,
        _buildPrice(),
        _buildCount(),
      ],
    );
  }

  Visibility _buildRating() {
    return Visibility(
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
    );
  }

  Visibility _buildDescribe() {
    return Visibility(
      visible: isVertical,
      child: Flexible(
        child: Text(
          item.describe,
          style: CommonTextStyles.small.copyWith(color: ColorsRes.darkGray),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  Visibility _buildButtonAddCart() {
    return Visibility(
      visible: isShopButton ?? false,
      child: CommonButton(
        onPressed: onClickAdd,
        title: S.current.button_add,
        padding: const EdgeInsets.all(DimensRes.sp8),
      ),
    );
  }

  Widget _buildPrice() {
    return Row(
      children: [
        Visibility(
          visible: isVertical,
          child: Expanded(
            child: Text(
              '\$${item.totalPrice}',
              style: CommonTextStyles.mediumBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        _buildButtonAddCart(),
      ],
    );
  }

  Widget _buildCount() {
    return Visibility(
      visible: isShowCount ?? false,
      child: Row(
        children: [
          IconButton(
            splashRadius: DimensRes.sp20,
            onPressed: () {
              _cartController.minusCountItem(item);
            },
            icon: SvgPicture.asset(
              Assets.icMinus,
              height: DimensRes.sp24,
              width: DimensRes.sp24,
            ),
          ),
          Gaps.hGap8,
          Text(
            item.count.toString(),
            style: CommonTextStyles.mediumBold,
          ),
          Gaps.hGap8,
          IconButton(
            splashRadius: DimensRes.sp20,
            onPressed: () {
              _cartController.plusCountItem(item);
            },
            icon: SvgPicture.asset(
              Assets.icPlus,
              height: DimensRes.sp24,
              width: DimensRes.sp24,
            ),
          ),
        ],
      ),
    );
  }
}
