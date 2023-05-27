import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shop_laptop_project/common/base/base_mixin.dart';
import 'package:shop_laptop_project/common/constants/assets.dart';
import 'package:shop_laptop_project/common/res/colors.dart';
import 'package:shop_laptop_project/common/res/dimens.dart';
import 'package:shop_laptop_project/config/di/app_module.dart';
import 'package:shop_laptop_project/config/router/routers/home_router.dart';
import 'package:shop_laptop_project/presentation/view/login/controller/login_controller.dart';
import 'package:shop_laptop_project/presentation/widgets/common_button.dart';
import 'package:shop_laptop_project/presentation/widgets/common_gaps.dart';
import 'package:shop_laptop_project/presentation/widgets/common_text_styles.dart';

class OtpView extends StatefulWidget {
  const OtpView({Key? key}) : super(key: key);

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> with BaseMixin {
  final _loginController = serviceLocator<LoginController>();

  Worker? worker;

  @override
  void initState() {
    super.initState();
    _loginController.nextToOtp.value = false;

    worker = ever(_loginController.isError, (bool isError) {
      if (isError) {
        showErrorDialog(
            message:
                'The verification code from SMS/TOTP is invalid\nPlease check and enter the correct verification code again.');
      } else {
        if (_loginController.nextToHome.value) {
          _loginController.setFirstTimeLaunch();
          HomeRouter.goMainView(context);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    worker?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightImg = MediaQuery.of(context).size.width / 3;
    final itemWidth = MediaQuery.of(context).size.width * 0.12;
    final itemHeight = itemWidth * 1.3;

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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'Phone Verification',
                      style: CommonTextStyles.large
                          .copyWith(color: ColorsRes.white),
                    ),
                    Gaps.vGap8,
                    Text(
                      'We need to register your phone number before getting started!',
                      textAlign: TextAlign.center,
                      style: CommonTextStyles.large18
                          .copyWith(color: ColorsRes.white),
                    ),
                    Gaps.vGap16,
                    PinCodeTextField(
                      appContext: context,
                      animationType: AnimationType.none,
                      animationDuration: const Duration(milliseconds: 1),
                      length: 6,
                      mainAxisAlignment: MainAxisAlignment.center,
                      autoFocus: true,
                      cursorColor: Colors.orange,
                      textStyle: CommonTextStyles.large,
                      keyboardAppearance: Brightness.light,
                      pinTheme: PinTheme(
                        fieldWidth: itemWidth,
                        fieldHeight: itemHeight,
                        activeColor: Colors.orange,
                        inactiveColor: ColorsRes.textGray,
                        selectedColor: Colors.orange,
                        activeFillColor: ColorsRes.primary,
                        fieldOuterPadding: const EdgeInsets.all(4),
                      ),
                      enablePinAutofill: false,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        _loginController.otp.value = value;
                      },
                    ),
                    Gaps.vGap20,
                    SizedBox(
                      width: double.infinity,
                      child: CommonButton(
                        onPressed: () async {
                          if (_loginController.otp.value.length != 6) {
                            showErrorDialog(
                              title: 'Login Error',
                              message: 'Incorrect OTP',
                            );
                          } else {
                            await _loginController.verifyOtp();
                          }
                        },
                        title: 'Login',
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
