import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String text;
  bool? isPass;
  CustomTextField(
      {super.key,
      required this.controller,
      required this.text,
      this.isPass = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isObscure = false;

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.text,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500, fontSize: 18.sp)),
          SizedBox(
            height: 8.h,
          ),
          TextField(
            obscureText: isObscure,
            controller: widget.controller,
            maxLines: 1,
            style: GoogleFonts.inter(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              suffixIcon: widget.isPass ?? false
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Icon(isObscure
                          ? CupertinoIcons.eye_slash_fill
                          : CupertinoIcons.eye_fill))
                  : null,
              contentPadding: const EdgeInsets.all(10),
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(60.r),
                  borderSide: const BorderSide(color: Colors.white)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50.r),
                  borderSide: const BorderSide(color: Colors.white)),
              hintText: "Type Here...",
              hintStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  color: Color(0xff938E8E)),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
