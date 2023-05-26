import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/presentation/view/favorite/controller/fav_controller.dart';

import '../../../common/constants/assets.dart';
import '../../../common/constants/common_constants.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../config/router/routers/home_router.dart';
import '../../../data/model/shop_model.dart';
import '../../../generated/l10n.dart';
import '../../widgets/common_gaps.dart';
import '../../widgets/common_text_styles.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({Key? key}) : super(key: key);

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final _favCtrl = serviceLocator<FavController>();

  @override
  void initState() {
    super.initState();
    _favCtrl.getFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(),
            Gaps.vGap16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp16),
              child: Text(
                'Your favorite item',
                style: CommonTextStyles.large20
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            Gaps.vGap16,
            Expanded(
              child: GetBuilder<FavController>(
                init: _favCtrl,
                builder: (controller) => _favCtrl.favorites.isEmpty
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
                              S.current.empty_fav,
                              style: CommonTextStyles.mediumBold,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: DimensRes.sp16),
                        itemCount: _favCtrl.favorites.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          var item = _favCtrl.favorites[index];

                          return InkWell(
                            highlightColor: ColorsRes.transparent,
                            splashColor: ColorsRes.transparent,
                            onTap: () {
                              HomeRouter.goDetail(context, shopModel: item);
                            },
                            child: Hero(
                              tag: item.shopId,
                              child: Container(
                                margin: const EdgeInsets.only(
                                    bottom: DimensRes.sp16),
                                decoration: BoxDecoration(
                                  color: ColorsRes.primary.withOpacity(0.1),
                                  borderRadius:
                                      BorderRadius.circular(DimensRes.sp16),
                                ),
                                child: Slidable(
                                  key: UniqueKey(),
                                  groupTag: 'group2',
                                  endActionPane: ActionPane(
                                    extentRatio: 0.25,
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          _favCtrl.removeFavorite(item);
                                        },
                                        backgroundColor: ColorsRes.red,
                                        foregroundColor: Colors.white,
                                        icon: Icons.delete_forever_rounded,
                                        borderRadius: const BorderRadius.only(
                                          topRight:
                                              Radius.circular(DimensRes.sp16),
                                          bottomRight:
                                              Radius.circular(DimensRes.sp16),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset(
            Assets.icBack,
            width: DimensRes.sp20,
            height: DimensRes.sp20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: DimensRes.sp16),
          child: InkWell(
            onTap: () {
              _favCtrl.removeAll();
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  Assets.icDelete,
                  width: DimensRes.sp20,
                  height: DimensRes.sp20,
                ),
                const Text(
                  'Remove all',
                  style: CommonTextStyles.small,
                )
              ],
            ),
          ),
        ),
      ],
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
            flex: 1,
            child: Container(
              height: DimensRes.sp80,
              width: DimensRes.sp80,
              margin: const EdgeInsets.all(DimensRes.sp4),
              padding: EdgeInsets.all(
                  item.isCateServices ? DimensRes.sp16 : DimensRes.sp0),
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
            child: Text(
              item.itemName,
              style: CommonTextStyles.mediumBold,
            ),
          ),
          Gaps.hGap4,
        ],
      ),
    );
  }
}
