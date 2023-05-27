import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/config/log/log.dart';
import 'package:shop_laptop_project/domain/pref/app_pref.dart';

@Singleton()
class LoginController extends GetxController {
  LoginController(this._pref);

  final AppPref _pref;

  final otp = ''.obs;
  final verifyId = ''.obs;
  final nextToOtp = false.obs;
  final nextToHome = false.obs;
  final isError = false.obs;
  final isFirstTime = false.obs;
  final isLoading = false.obs;

  void getFirstTimeLaunchApp() async {
    isLoading.value = true;
    isFirstTime.value = await _pref.firstTime;
    isLoading.value = false;
  }

  void sendOtp(String mobile) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await _pref.setPhoneNumber(mobile);

    var phone = '';

    if (mobile.startsWith('0')) {
      phone = mobile.replaceFirst('0', '+84');
    }
    Log.e('Mobile: $phone');

    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        Log.e('Success');
      },
      verificationFailed: (FirebaseAuthException fail) {
        Log.e('${fail.message}');
      },
      codeSent: (String verificationId, int? resendToken) async {
        verifyId.value = verificationId;
        nextToOtp.value = true;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOtp() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verifyId.value,
        smsCode: otp.value,
      );
      await auth.signInWithCredential(credential);
      nextToHome.value = true;
      isError.value = false;
    } catch (e) {
      Log.e(e.toString());
      isError.value = true;
    }
  }
}
