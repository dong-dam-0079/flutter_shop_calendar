import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';

import '../../../common/constants/assets.dart';
import '../../../common/res/colors.dart';
import '../../../common/res/dimens.dart';
import '../../../config/di/app_module.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_gaps.dart';
import '../../widgets/common_text_styles.dart';
import 'controller/profile_controller.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _proController = serviceLocator<ProfileController>();

  @override
  void initState() {
    super.initState();
    _proController.getPhoneNumber();
  }

  @override
  Widget build(BuildContext context) {
    var heightImg = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                Assets.imgBackground,
                fit: BoxFit.fill,
                width: heightImg,
                height: heightImg,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                top: DimensRes.sp50,
                left: DimensRes.sp16,
                right: DimensRes.sp16,
              ),
              decoration: BoxDecoration(
                color: ColorsRes.primary.withOpacity(0.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(DimensRes.sp42),
                  topLeft: Radius.circular(DimensRes.sp42),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Phone number',
                    style: CommonTextStyles.large18
                        .copyWith(color: ColorsRes.white),
                  ),
                  Gaps.vGap8,
                  Obx(
                    () => Text(
                      _proController.phone.value,
                      style: CommonTextStyles.large18
                          .copyWith(color: ColorsRes.white),
                    ),
                  ),
                  Gaps.vGap32,
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      child: CommonButton(
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut().whenComplete(
                              () => HomeRouter.forceLogout(context));
                        },
                        title: 'Logout',
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
