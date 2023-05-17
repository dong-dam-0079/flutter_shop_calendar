import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/res/dimens.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

import '../../../common/res/colors.dart';

class DetailView extends StatefulWidget {
  const DetailView({Key? key}) : super(key: key);

  @override
  State<DetailView> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    var hImage = MediaQuery.of(context).size.height * 0.6;
    var hContent = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox(
            height: hImage,
            width: double.infinity,
            child: Image.asset(
              Assets.imgChair,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: kTextTabBarHeight,
            left: DimensRes.sp20,
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                Assets.icBack,
                height: DimensRes.sp24,
                width: DimensRes.sp24,
              ),
            ),
          ),
          _buildContent(hContent),
        ],
      ),
    );
  }

  Align _buildContent(double hContent) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: hContent,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          vertical: DimensRes.sp24,
          horizontal: DimensRes.sp16,
        ),
        decoration: BoxDecoration(
          color: ColorsRes.white,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(DimensRes.sp40),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorsRes.primary.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0.5),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'name',
                    style: CommonTextStyles.largeBold,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Assets.icFavorite,
                    height: DimensRes.sp24,
                    width: DimensRes.sp24,
                  ),
                ),
              ],
            ),
            Gaps.vGap8,
            RatingBar.builder(
              itemSize: DimensRes.sp24,
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
            Gaps.vGap16,
            const Expanded(
              child: Text(
                'data',
                style: CommonTextStyles.medium,
              ),
            ),
            Gaps.vGap16,
            Text(
              'Price',
              style: CommonTextStyles.mediumBold
                  .copyWith(color: ColorsRes.textGray),
            ),
            _buildPrice(),
            Gaps.vGap16,
            SizedBox(
              width: double.infinity,
              child: CommonButton(
                onPressed: () {},
                title: 'Add to cart',
              ),
            )
          ],
        ),
      ),
    );
  }

  Row _buildPrice() {
    return Row(
      children: [
        const Expanded(
          child: Text(
            '43',
            style: CommonTextStyles.largeBold,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.icMinus,
            height: DimensRes.sp24,
            width: DimensRes.sp24,
          ),
        ),
        Gaps.hGap8,
        const Text(
          '1',
          style: CommonTextStyles.mediumBold,
        ),
        Gaps.hGap8,
        IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(
            Assets.icPlus,
            height: DimensRes.sp24,
            width: DimensRes.sp24,
          ),
        ),
      ],
    );
  }
}
