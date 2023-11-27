import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

class AuthViewModel extends GetxController {
  final isSigned = false.obs;
  final dialogargs = ''.obs;
  final currentuserEmail = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        isSigned.value = false;
        currentuserEmail.value = '';
      } else {
        print('User is signed in!');
        isSigned.value = true;
        currentuserEmail.value = user.email!;
      }
    });
  }

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
    FirebaseAuth.instance.signOut();
    isSigned.value = false;
    currentuserEmail.value = '';

    // Navigator.pop(
    //     context, MaterialPageRoute(builder: (context) => Firebaselogin()));
  }
}
