import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task1/helper/token_storage.dart';
import '../routes/app_routes.dart';
import '../utils/snackbar.dart';
import '../view/auth/login_view/login_view.dart';

class SigningController extends GetxController{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RxBool loading = false.obs;
  RxString userName = "".obs;
  Future<void> googleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        log("canceled the sign-in");
        return;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

     UserCredential userCredential =  await _auth.signInWithCredential(credential);
     userName.value = userCredential.user?.displayName ??"";
     log(userCredential.user?.displayName ?? "");
     await Tokens.storeTokenLoggedIn("true");
      Get.offAllNamed(Routes.HOME);
    } catch (error) {
      log(error.toString());
      snack(context, error.toString());
    }
  }

  signUpWithEmailPassword({required String email, required String password, required BuildContext context}) async {
    loading.value = true;
    try {
      final credential  =   await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid  = credential.user?.uid ?? "";
      await Tokens.storeTokenLoggedIn("true");
      loading.value = false;
      Get.offAllNamed(Routes.HOME);

      return credential.user?.uid ?? "";
    } on FirebaseAuthException catch (e) {
      snack(context, e.toString());
      loading.value = false;
      return false;
    }
  }
  Future<bool> signInWithEmailPassword({required String email, required String password, required BuildContext context}) async {
    loading.value = true;
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      log(credential.user!.uid ?? "");
      await Tokens.storeTokenLoggedIn("true");
      loading.value = false;
      Get.offAllNamed(Routes.HOME);

      return true;
    } on FirebaseAuthException catch (e) {
      snack(context, e.toString());
      loading.value = false;
      return false;
    }
  }
  Future<void> googleSignOut(BuildContext context) async {
    await Tokens.deleteName();
    await Tokens.deleteTokenLoggedIn();
    await _googleSignIn.signOut();
    await _auth.signOut();
    Get.offAll(()=>LoginView());
    snack(context,"Logged Out");
    log("signed out");
  }
}