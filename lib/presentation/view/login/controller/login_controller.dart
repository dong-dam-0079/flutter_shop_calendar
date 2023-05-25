import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:shop_laptop_project/config/log/log.dart';

@injectable
class LoginController extends GetxController {
  final phoneNumber = ''.obs;

  void loginWithPhoneNumber(String mobile) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    auth.verifyPhoneNumber(
      phoneNumber: phoneNumber.value,
      verificationCompleted: (authCredential) {
        auth.signInWithCredential(authCredential).then((value) {});
      },
      verificationFailed: (fail) {
        Log.e('${fail.message}');
      },
      codeSent: (verificationId, forceResendingToken) {},
      codeAutoRetrievalTimeout: (timeOut) {},
    );
  }
}
