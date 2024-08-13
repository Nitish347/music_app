import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/helper/token_storage.dart';
import 'package:task1/utils/custom_button.dart';
import 'package:task1/view/home/home_view.dart';

import '../../controllers/signing_controller.dart';
import '../../utils/snackbar.dart';
import '../../utils/textField.dart';

class NickNameView extends StatelessWidget {
   NickNameView({super.key});
TextEditingController controller = TextEditingController();
   final signInController = Get.put(SigningController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/Nickname.png"),fit: BoxFit.fill)
        ),
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 269.h,),
              Text("ENTER YOUR NAME",
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700, fontSize: 24.sp)),
              SizedBox(height: 28.h,),
              CustomTextField(controller: controller, text: 'Enter your name',),
              SizedBox(height: 46.h,),
              InkWell(
                onTap: ()async{
                  if(controller.text.isEmpty){
                    snack(context, "Enter your name");
                    return ;
                  }
                  log(controller.text);
                  signInController.userName.value = controller.text;
                  await Tokens.storeName(controller.text);
                  await Tokens.storeTokenLoggedIn("true");
                  Get.offAll(HomeView());
                },
                child: CustomButton(
                  size: Size(330.w, 44.h),
                  child: Text(
                    "continue",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600, fontSize: 16.sp),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
