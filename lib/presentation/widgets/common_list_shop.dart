import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  }) : super(key: key);

  final bool isVertical;
  final bool? isShopButton;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
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
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: DimensRes.sp16),
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
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => Gaps.vLine,
    );
  }
}

class CommonItemList extends StatelessWidget {
  const CommonItemList({
    super.key,
    required this.isVertical,
    this.isShopButton,
  });

  final bool isVertical;
  final bool? isShopButton;

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
        Row(
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
        Gaps.vGap4,
        Visibility(
          visible: isVertical,
          child: Flexible(
            child: Text(
              'Lorem ternjkand ndansc bhjdab nwdjkqda nasjd nc nadjsa jncabjhd bndja badsjb bdasbc asdj bja',
              style: CommonTextStyles.small.copyWith(color: ColorsRes.textGray),
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
