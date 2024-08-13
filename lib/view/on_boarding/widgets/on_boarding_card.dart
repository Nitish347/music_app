import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingCard extends StatelessWidget {
  String upperText;
  String lowerText;
  String img;
  OnBoardingCard(
      {super.key,
      required this.img,
      required this.lowerText,
      required this.upperText});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 103.h,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25.w),
          height: 100.h,
          child: Text(
            upperText,
            textAlign: TextAlign.center,
            style:
                GoogleFonts.inter(fontSize: 35.sp, fontWeight: FontWeight.w700),
          ),
        ),
        SvgPicture.asset(
          img,
          color: Colors.white,
          width: 1.sw,
          height: 326.h,
        ),
        SizedBox(
          height: 62.h,
        ),
        SizedBox(
          width: 300.w,
          height: 60.h,
          child: Text(lowerText,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 18.sp, fontWeight: FontWeight.w700)),
        ),
      ],
    );
  }
}
