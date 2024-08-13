import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/controllers/on_boarding_controllers.dart';
import 'package:task1/helper/token_storage.dart';
import 'package:task1/routes/app_routes.dart';
import 'package:task1/utils/custom_button.dart';
import 'package:task1/utils/on_boarding_texts.dart';
import 'package:task1/view/on_boarding/widgets/on_boarding_card.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  PageController pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  final onboardingController = Get.put(OnBoardingControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => Container(
        height: 1.sh,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(OnBoardingTexts.backgrounds[onboardingController.index.value],),fit: BoxFit.fill
            )
        ),
        child: Column(
          children: [
            SizedBox(
              height: 680.h,
              width: 1.sw,
              child: PageView.builder(
                  itemCount: OnBoardingTexts.upperTexts.length,
                  controller: pageController,
                  onPageChanged: (val) {
                    onboardingController.index.value = val;
                  },
                  itemBuilder: (_, i) {
                    return OnBoardingCard(
                      img: OnBoardingTexts.images[i],
                      lowerText: OnBoardingTexts.lowerTexts[i],
                      upperText: OnBoardingTexts.upperTexts[i],
                    );
                  }),
            ),
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.sp),
                child: Obx(
                      () => SizedBox(
                    height: 50.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DotsIndicator(
                          dotsCount: OnBoardingTexts.upperTexts.length,
                          position: onboardingController.index.value,
                          decorator: DotsDecorator(
                            size: const Size.square(9.0),
                            color: Colors.white,
                            activeColor: Colors.white,
                            activeSize: const Size(18.0, 9.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                        onboardingController.index.value ==
                            OnBoardingTexts.lowerTexts.length - 1
                            ? InkWell(
                          onTap: ()async{
                            await Tokens.storeTokenOnBoarding("true");
                            Get.offAllNamed(Routes.LOGIN);
                          },
                          child: CustomButton(
                            size: Size(144.w, 39.h),
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 16.sp),
                            ),
                          ),
                        )
                            : Container(
                          height: 50.h,
                          width: 50.h,
                          padding: EdgeInsets.all(2.5.sp),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: Colors.white)),
                          child: InkWell(
                            onTap: () {
                              if (onboardingController.index.value <
                                  OnBoardingTexts.lowerTexts.length - 1) {
                                onboardingController.onChangedIndex();
                                pageController.nextPage(
                                  duration:
                                  const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.arrow_forward_ios_sharp),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
