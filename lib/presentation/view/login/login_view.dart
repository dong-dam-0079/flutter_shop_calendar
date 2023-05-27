import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/res/colors.dart';
import 'package:shop_laptop_project/common/res/dimens.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/view/login/controller/login_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_box.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

import '../../../generated/l10n.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with BaseMixin {
  final _loginController = serviceLocator<LoginController>();

  final _phoneCtrl = TextEditingController();

  Worker? worker;
  Worker? workerFirst;

  @override
  void initState() {
    super.initState();
    _loginController.getFirstTimeLaunchApp();
    workerFirst = ever(_loginController.isFirstTime, (bool isFirstTime) {
      if (isFirstTime) {
        HomeRouter.goMainView(context);
      }
    });

    worker = ever(_loginController.nextToOtp, (bool isNext) {
      if (isNext) {
        HomeRouter.goOtp(context);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _phoneCtrl.dispose();
    worker?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightImg = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () => _loginController.isFirstTime.value
            ? const Center(child: CircularProgressIndicator())
            : Column(
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
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome',
                              style: CommonTextStyles.largeBold
                                  .copyWith(color: ColorsRes.white),
                            ),
                            Gaps.vGap8,
                            Text(
                              'Please, Sign in to continue...',
                              style: CommonTextStyles.large18
                                  .copyWith(color: ColorsRes.white),
                            ),
                            Gaps.vGap24,
                            CommonTextBox(
                              labelText: S.current.phone_number,
                              controller: _phoneCtrl,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              autoFocus: false,
                            ),
                            Gaps.vGap32,
                            SizedBox(
                              width: double.infinity,
                              child: CommonButton(
                                onPressed: () {
                                  var phone = _phoneCtrl.text;

                                  if (phone.length < 9) {
                                    showErrorDialog(
                                      title: 'Login Error',
                                      message: 'Incorrect length phone number',
                                    );
                                  } else {
                                    _loginController.sendOtp(_phoneCtrl.text);
                                  }
                                },
                                title: 'Send OTP',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
