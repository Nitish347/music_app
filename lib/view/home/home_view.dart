import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task1/controllers/home_controllers/songs_controller.dart';
import 'package:task1/controllers/signing_controller.dart';
import 'package:task1/helper/token_storage.dart';
import 'package:task1/models/avatar_model.dart';
import 'package:task1/view/audio_player/small_audio_player.dart';
import 'package:task1/view/home/widgets/avatar_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(SigningController());
  final songsController = Get.put(SongsControllers());
  String name = "";
  getName() async {
    String res = await Tokens.getName() ?? "";
    setState(() {
      if(res == null){
        name = FirebaseAuth.instance.currentUser?.email ??"";
      }else {
        name = res;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getName();
    songsController.getAvatar();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const Drawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 10,
        shadowColor: Colors.black,
        backgroundColor: const Color(0xff5D548A),
        toolbarHeight: 119.h,
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
        title: Column(
          children: [
            Text(
              "Hey ${FirebaseAuth.instance.currentUser?.displayName ?? name}!",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                  color: Colors.white),
            ),
            Text(
              "Listen. Focus. Unwind.",
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: Colors.white),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.center,
        width: 1.sw,
        height: 66.h,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          // Colors.white,
          Colors.grey,
          Color(0xff2E2E2E),
          Colors.black
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            bottomIcons("Home", "assets/icons/home.svg"),
            SizedBox(
              width: 50.w,
            ),
            InkWell(
                onTap: () async {
                  await controller.googleSignOut(context);
                },
                child: bottomIcons("Logout", "assets/icons/logout.svg")),
          ],
        ),
      ),
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff5D548A), Colors.black],
                transform: GradientRotation(70),
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Listen. Focus. Unwind.",
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                    color: Colors.white),
              ),
            ),
            Expanded(
              child: SizedBox(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    crossAxisSpacing: 0.0, // Space between columns
                    mainAxisSpacing: 0.0, // Space between rows
                    childAspectRatio: 1.1, // Width to height ratio
                  ),
                  itemCount: songsController.avatars.length,
                  itemBuilder: (BuildContext context, int index) {
                    AvatarModel avatar = songsController.avatars[index];
                    return InkWell(
                      onTap: ()=>Get.to(SmallAudioPlayer(mood: avatar.mood ??"",)),
                      child: AvatarCard(
                        title: avatar.mood ?? "",
                        img: avatar.avatar ?? "",
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Widget bottomIcons(String text, String img) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SvgPicture.asset(img),
      Text(
        text,
        style: GoogleFonts.inter(
            fontWeight: FontWeight.w400, fontSize: 12.sp, color: Colors.white),
      ),
    ],
  );
}
// for your daily mood