import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

import '../../../common/constants/assets.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_gaps.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.only(
          left: DimensRes.sp16,
          right: DimensRes.sp16,
          top: DimensRes.sp28,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.current.title_new,
              style: CommonTextStyles.largeBold,
            ),
            Gaps.vGap8,
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: _buildListNew(),
            ),
            Gaps.vGap16,
            Text(
              S.current.title_popular,
              style: CommonTextStyles.largeBold,
            ),
            Gaps.vGap8,
            Expanded(
              child: _buildListPopular(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListNew() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
          width: MediaQuery.of(context).size.width / 2.8,
          margin: const EdgeInsets.only(right: DimensRes.sp12),
          child: Column(
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
              Expanded(
                child: _buildContentList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListPopular() {
    return ListView.builder(
      itemCount: 5,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: DimensRes.sp16),
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
                child: _buildContentList(isVertical: true),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentList({
    bool? isVertical,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: isVertical ?? true
          ? MainAxisAlignment.center
          : MainAxisAlignment.start,
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
          mainAxisAlignment: isVertical ?? false
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
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
          visible: isVertical ?? false,
          child: Flexible(
            child: Text(
              'Lorem ternjkand ndansc bhjdab nwdjkqda nasjd nc nadjsa jncabjhd bndja badsjb bdasbc asdj bja',
              style: CommonTextStyles.small.copyWith(color: ColorsRes.textGray),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  CommonAppBar _buildAppBar(BuildContext context) {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      widgetTitle: Padding(
        padding: const EdgeInsets.only(left: DimensRes.sp16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: RichText(
            text: const TextSpan(
                text: 'Hello Pan\n',
                style: CommonTextStyles.largeBold,
                children: [
                  TextSpan(
                      text: 'Welcome back', style: CommonTextStyles.large18)
                ]),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: DimensRes.sp16),
          child: Theme(
            data: Theme.of(context).copyWith(
              tooltipTheme: const TooltipThemeData(
                decoration: BoxDecoration(color: ColorsRes.transparent),
              ),
            ),
            child: _buildButtonMenu(),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          color: ColorsRes.primary,
          height: 1,
        ),
      ),
    );
  }

  PopupMenuButton<dynamic> _buildButtonMenu() {
    return PopupMenuButton(
      tooltip: '',
      icon: SvgPicture.asset(
        Assets.icMenu,
        height: DimensRes.sp20,
        width: DimensRes.sp20,
        color: ColorsRes.primary,
      ),
      padding: const EdgeInsets.only(right: DimensRes.sp8),
      position: PopupMenuPosition.under,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(DimensRes.sp12),
        ),
      ),
      itemBuilder: (context) => [
        _buildItemMenu(
          value: 1,
          S.current.button_go_favorite,
          Assets.icFavorite,
        ),
        const PopupMenuItem(
          padding: EdgeInsets.zero,
          height: DimensRes.sp2,
          child: Gaps.vLine,
        ),
        _buildItemMenu(
          value: 2,
          S.current.button_go_history,
          Assets.icHistory,
        ),
      ],
      onSelected: (value) {
        if (value == 1) {
          HomeRouter.goFavorite(context);
        }
        if (value == 2) {
          HomeRouter.goFavorite(context);
        }
      },
    );
  }

  PopupMenuItem<dynamic> _buildItemMenu(
    String title,
    String icon, {
    required int value,
  }) {
    return PopupMenuItem(
      value: value,
      child: _buildRowItem(
        title: title,
        icon: icon,
      ),
    );
  }

  Widget _buildRowItem({
    required String title,
    required String icon,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: DimensRes.sp20,
          height: DimensRes.sp20,
          color: ColorsRes.primary,
        ),
        Gaps.hGap8,
        Text(
          title,
          style: CommonTextStyles.medium,
        ),
        Gaps.hGap16,
      ],
    );
  }
}
