import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/res/colors.dart';
import 'package:shop_laptop_project/common/res/dimens.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/generated/l10n.dart';
import 'package:shop_laptop_project/presentation/view/history/controller/history_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final _historyCtrl = serviceLocator<HistoryController>();

  @override
  void initState() {
    super.initState();
    _historyCtrl.initHistory();
  }

  @override
  void dispose() {
    super.dispose();
    _historyCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.current.button_go_history,
          style: CommonTextStyles.large20,
        ),
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
        backgroundColor: ColorsRes.white,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.vGap16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensRes.sp16),
              child: Text(
                'Your repair booking history',
                style: CommonTextStyles.large20
                    .copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            Gaps.vGap24,
            Expanded(
              child: GetBuilder<HistoryController>(
                init: _historyCtrl,
                builder: (controller) => _historyCtrl.histories.isEmpty
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
                            const Text(
                              'Nothing History',
                              style: CommonTextStyles.mediumBold,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: DimensRes.sp16),
                        shrinkWrap: true,
                        itemCount: _historyCtrl.histories.length,
                        itemBuilder: (context, index) {
                          var item = _historyCtrl.histories[index];

                          return Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: DimensRes.sp8,
                              horizontal: DimensRes.sp16,
                            ),
                            margin:
                                const EdgeInsets.only(bottom: DimensRes.sp16),
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(DimensRes.sp16),
                              color: ColorsRes.primary.withOpacity(0.2),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.service,
                                  style: CommonTextStyles.large20
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                                Gaps.vGap8,
                                Text(
                                  item.date,
                                  style: CommonTextStyles.medium
                                      .copyWith(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  item.method,
                                  style: CommonTextStyles.medium
                                      .copyWith(fontStyle: FontStyle.italic),
                                )
                              ],
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
}
