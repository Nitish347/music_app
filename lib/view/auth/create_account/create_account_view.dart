import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/controllers/signing_controller.dart';
import 'package:task1/routes/app_routes.dart';
import 'package:task1/utils/custom_button.dart';
import 'package:task1/view/nick_name/nick_name_view.dart';
import '../../../utils/snackbar.dart';
import '../../../utils/textField.dart';

class CreateAccountView extends StatelessWidget {
  CreateAccountView({super.key});
  final controller = Get.put(SigningController());
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Login.png"),fit: BoxFit.fill)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 230.h,
                ),
                Text("CREATE AN ACCOUNT",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700, fontSize: 24.sp)),
                SizedBox(
                  height: 28.h,
                ),
                InkWell(
                  onTap: () async {
                    await controller.googleSignIn(context);
                  },
                  child: CustomButton(
                    size: Size(326.w, 43.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset("assets/google.svg"),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          "continue with google",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  width: 1.sh,
                  height: 20,
                  child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Container(
                      height: 1,
                      width: 0.35.sw,
                      color: Colors.white,
                    ),
                      Text("or",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                          )),
                      Container(
                      height: 1,
                      width: 0.35.sw,
                      color: Colors.white,
                    ),
            
                    ],
                  ),
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomTextField(
                  controller: _email,
                  text: "Email ID",
                ),
                SizedBox(
                  height: 28.h,
                ),
                CustomTextField(
                  controller: _password,
                  text: "Enter Password",
                  isPass: true,
                ),
                SizedBox(
                  height: 28.h,
                ),
                InkWell(
                  onTap: ()async{
                    if(_email.text.isEmpty){
                      snack(context, "Enter your email");
                      return ;
                    }  if(_password.text.isEmpty){
                      snack(context, "Enter your password");
                      return ;
                    }
                    log(_email.text);
                    await controller.signUpWithEmailPassword(email: _email.text, password: _password.text, context: context);
                  },
                  child: Obx(() => CustomButton(
                    size: Size(330.w, 44.h),
                    child: controller.loading.value ?  CircularProgressIndicator() :  Text(
                      "continue",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600, fontSize: 16.sp),
                    ),
                  ),)
                ),
                SizedBox(
                  height: 28.h,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Center(
                      child: Text("Already have an account?",
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                          )),
                    ),  Center(
                      child: InkWell(
                        onTap: () => Get.offAllNamed(Routes.LOGIN),
                        child: Text(" Login",
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white)),
                      ),
                    ),
                  ],),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Center(
                  child: InkWell(
                    onTap: () => Get.to(NickNameView()),
                    child: Text("Continue as Guest",
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
