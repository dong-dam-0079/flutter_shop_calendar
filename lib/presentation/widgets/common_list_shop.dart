import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';

import '../../common/constants/assets.dart';
import '../../common/res/colors.dart';
import '../../common/res/dimens.dart';
import '../../generated/l10n.dart';
import 'common_gaps.dart';
import 'common_text_styles.dart';

class CommonListShop extends StatelessWidget {
  const CommonListShop({
    Key? key,
    required this.isVertical,
    this.isShopButton,
    this.isCart,
  }) : super(key: key);

  final bool isVertical;
  final bool? isShopButton;
  final bool? isCart;

  @override
  Widget build(BuildContext context) {
    return SlidableAutoCloseBehavior(
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              HomeRouter.goDetail(context);
            },
            child: Hero(
              tag: 'hero',
              child: Container(
                margin: const EdgeInsets.only(bottom: DimensRes.sp16),
                decoration: BoxDecoration(
                  color: ColorsRes.borderList.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(DimensRes.sp16),
                ),
                child: Slidable(
                  key: UniqueKey(),
                  enabled: isCart ?? false,
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
                  child: _itemList(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Container _itemList() {
    return Container(
      decoration: BoxDecoration(
          color: ColorsRes.borderList.withOpacity(0.4),
          borderRadius: BorderRadius.circular(DimensRes.sp16)),
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
                child: Image.asset(
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
    this.isCart,
  });

  final bool isVertical;
  final bool? isShopButton;
  final bool? isCart;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Flexible(
          child: Text(
            'Keyboard FL-esport',
            style: CommonTextStyles.medium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Gaps.vGap4,
        Visibility(
          visible: isCart ?? false,
          child: Row(
            mainAxisAlignment:
                isVertical ? MainAxisAlignment.start : MainAxisAlignment.center,
            children: [
              Flexible(
                child: RatingBar.builder(
                  itemSize: DimensRes.sp16,
                  initialRating: 3.5,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ),
              Gaps.hGap8,
              const Text(
                '3.5',
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
              'Lorem ternjkand ndansc bhjdab nwdjkqda nasjd nc nadjsa jncabjhd bndja badsjb bdasbc asdj bja',
              style: CommonTextStyles.small.copyWith(color: ColorsRes.darkGray),
              maxLines: 3,
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
              onPressed: () {},
              title: S.current.button_add_to_cart,
              padding: const EdgeInsets.symmetric(vertical: DimensRes.sp8),
            ),
          ),
        ),
      ],
    );
  }
}
