import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
class AvatarCard extends StatelessWidget {
  String title;
  String img;
   AvatarCard({super.key,required this.img,required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
           height: 100.h,
            width: 100.h,
            child: SvgPicture.asset(img,fit: BoxFit.cover,),
          ),
          Text("${title.toUpperCase()}?",style: GoogleFonts.inter(
            fontWeight: FontWeight.normal,
            fontSize: 14.sp
          ),)
        ],
      ),
    );
  }
}
