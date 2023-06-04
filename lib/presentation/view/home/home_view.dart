import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';
import 'package:shop_laptop_project/common/extensions/date_extension.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/log/log.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/view/home/controller/home_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_app_bar.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_box.dart';
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

class _HomeViewState extends State<HomeView>
    with BaseMixin, SingleTickerProviderStateMixin {
  final _homeController = serviceLocator<HomeController>();
  final _addressCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  List<DateTime?> initDate = [DateTime.now()];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _homeController.initDropValue();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.index == 0) {
        _homeController.isShowAddress.value = true;
        _homeController.method.value = S.current.method_home;
      } else {
        _homeController.isShowAddress.value = false;
        _homeController.method.value = S.current.method_store;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _homeController.dispose();
    _addressCtrl.dispose();
    _phoneCtrl.dispose();
    _nameCtrl.dispose();
    _tabController.removeListener(() {});
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: CalendarDatePicker2(
              config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single),
              value: initDate,
              onValueChanged: (dates) {
                var date = dates.first;
                if (date != null) {
                  _homeController.date.value = date.toStringWithDate();
                  Log.e(date.toStringWithDate());
                } else {
                  _homeController.date.value =
                      DateTime.now().toStringWithDate();
                }
              },
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: DimensRes.sp16,
                left: DimensRes.sp16,
                right: DimensRes.sp16,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(DimensRes.sp24),
                  topRight: Radius.circular(DimensRes.sp24),
                ),
                color: ColorsRes.secondary.withOpacity(0.35),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Service',
                      style: CommonTextStyles.large18,
                    ),
                    Gaps.vGap8,
                    Obx(
                      () => Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: DimensRes.sp8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(DimensRes.sp8),
                          border: Border.all(color: ColorsRes.primary),
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _homeController.service.value,
                          onChanged: (value) {
                            _homeController.service.value = value!;
                          },
                          items: _homeController.services
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          underline: Gaps.empty,
                        ),
                      ),
                    ),
                    Gaps.vGap24,
                    const Text(
                      'Order Infomation',
                      style: CommonTextStyles.large18,
                    ),
                    Gaps.vGap8,
                    _buildOrderInfo(
                      labelText: S.current.name,
                      controller: _nameCtrl,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      obscureText: false,
                      autoFocus: false,
                    ),
                    Gaps.vGap8,
                    _buildOrderInfo(
                      labelText: S.current.phone_number,
                      controller: _phoneCtrl,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.number,
                      obscureText: false,
                      autoFocus: false,
                    ),
                    Gaps.vGap24,
                    const Text(
                      'Repair Method',
                      style: CommonTextStyles.large18,
                    ),
                    Gaps.vGap8,
                    _buildRepairMethod(),
                    SizedBox(
                      height: DimensRes.sp8,
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          Container(),
                          Container(),
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: _homeController.isShowAddress.value,
                        child: _buildOrderInfo(
                          labelText: S.current.address,
                          controller: _addressCtrl,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          autoFocus: false,
                        ),
                      ),
                    ),
                    Gaps.vGap40,
                    SizedBox(
                      width: double.infinity,
                      child: CommonButton(
                        onPressed: () {
                          if (_nameCtrl.text.isEmpty ||
                              _phoneCtrl.text.isEmpty) {
                            showErrorDialog(
                                message: S.current.message_field_all);
                          } else {
                            _homeController
                                .booking(
                              name: _nameCtrl.text,
                              phone: _phoneCtrl.text,
                              address: _addressCtrl.text,
                            )
                                .then((value) {
                              _nameCtrl.clear();
                              _phoneCtrl.clear();
                              _addressCtrl.clear();
                            });
                            _showToast('Booking Success');
                          }
                        },
                        title: 'BOOKING',
                      ),
                    ),
                    Gaps.vGap16,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(String title) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        content: Text(
          title,
          style: CommonTextStyles.mediumBold.copyWith(color: ColorsRes.white),
        ),
        backgroundColor: ColorsRes.secondary,
      ),
    );
  }

  Widget _buildRepairMethod() {
    return Container(
      height: kToolbarHeight,
      width: double.infinity,
      padding: const EdgeInsets.all(DimensRes.sp4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(DimensRes.sp10)),
        color: Color(0xFF798AD5),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(DimensRes.sp8),
          color: Colors.white,
        ),
        tabs: [
          _buildTab(S.current.method_home),
          _buildTab(S.current.method_store),
        ],
        indicatorColor: ColorsRes.transparent,
        labelStyle: CommonTextStyles.medium,
        labelColor: ColorsRes.primary,
        unselectedLabelColor: ColorsRes.primary,
      ),
    );
  }

  Tab _buildTab(String title) {
    return Tab(
      child: Text(
        title,
        style: CommonTextStyles.medium,
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

  CommonAppBar _buildAppBar(BuildContext context) {
    return CommonAppBar(
      automaticallyImplyLeading: false,
      widgetTitle: Padding(
        padding: const EdgeInsets.only(left: DimensRes.sp16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            S.current.calendar,
            style: CommonTextStyles.title.copyWith(color: ColorsRes.white),
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
    );
  }

  PopupMenuButton<dynamic> _buildButtonMenu() {
    return PopupMenuButton(
      tooltip: '',
      icon: SvgPicture.asset(
        Assets.icMenu,
        height: DimensRes.sp20,
        width: DimensRes.sp20,
        color: ColorsRes.white,
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
          HomeRouter.goHistory(context);
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
