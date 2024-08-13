import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  Size size;
  Widget child;
  CustomButton({super.key, required this.size, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(colors: [
            Color(0xffFFF4F4),
            Color(0xff7B6B7B),
            Color(0xff7B6B7B),
          ],
              begin: Alignment.centerLeft, end: Alignment.centerRight)),
      child: child
    );
  }
}
