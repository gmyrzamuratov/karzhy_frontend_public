import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../functions/login/view/login_view.dart';

class AuthController extends GetxController {

  late final FirebaseAuth _auth;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    _auth = FirebaseAuth.instance;
    _auth.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  Future<bool> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Login failed', 'User not found');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Login failed', 'Wrong password');
      } else {
        Get.snackbar('Login failed', e.message!);
      }
    } catch (e) {
      Get.snackbar('Login failed', e.toString());
    }

    return false;
  }

  Future<bool> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Registration failed', 'The password provided is too weak');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Registration failed', 'The account already exists for that email');
      } else {
        Get.snackbar('Registration failed', e.message!);
      }
      return false;
    } catch (e) {
      Get.snackbar('Registration failed', e.toString());
      return false;
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      Get.offAll(LoginView());
    } catch (e) {
      Get.snackbar('Logout failed', e.toString());
    }
  }

}