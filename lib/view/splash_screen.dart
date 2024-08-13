import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/controllers/signing_controller.dart';
import 'package:task1/helper/token_storage.dart';

import '../routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final controller = Get.put(SigningController());
  goto()async{
    await Future.delayed(Duration(seconds: 2));
    String? name = await Tokens.getName();
    if(name!=null){
      controller.userName.value = name;
    }
    Get.toNamed(Routes.ONBOARDING);
  }
  @override
  void initState() {
    // TODO: implement initState
    goto();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: SvgPicture.asset("assets/spalsh_screen.svg")),
          Text("Soundscape",style: GoogleFonts.inter(
            fontSize: 34.sp,
            fontWeight: FontWeight.w500
          ),)
        ],
      ),
    );
  }
}
