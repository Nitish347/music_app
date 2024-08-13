// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:task1/models/song_model.dart';
//
// import '../../controllers/home_controllers/songs_controller.dart';
// import '../audio_player/small_audio_player.dart';
// class SongsView extends StatefulWidget {
//   const SongsView({super.key});
//
//   @override
//   State<SongsView> createState() => _SongsViewState();
// }
//
// class _SongsViewState extends State<SongsView> {
//
//   final songsController = Get.put(SongsControllers());
//   int ind=0;
//   @override
//   void initState() {
//     songsController.getSongs(mood: "tired");
//     // TODO: implement initState
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child:Obx(() => Scaffold(
//         bottomNavigationBar: songsController.songLoading.value ?const CircularProgressIndicator()  :  SizedBox(
//             height: 200,
//             child: SmallAudioPlayer(mood: '',)),
//         backgroundColor: Colors.black,
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Container(
//               alignment: Alignment.topCenter,
//
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Padding(
//                     padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
//                     child: Text(
//                       "Tired",
//                       textAlign: TextAlign.start,
//                       style: GoogleFonts.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24.sp,
//                           color: Colors.white),
//                     ),
//                   ),
//                   SvgPicture.asset("assets/avatar/tired_tp.svg")
//                 ],
//               ),
//             ),
//             songsController.songLoading.value ? const CircularProgressIndicator()  : Expanded(child: ListView.builder(
//
//                 itemCount: songsController.songs.length,
//                 itemBuilder: (context,index){
//                   SongModel song = songsController.songs[index];
//                   return   Padding(
//                     padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
//                     child: InkWell(
//                       onTap: (){
//                         setState(() {
//                           ind = index;
//                         });
//                       },
//                       child: Text(
//                         song.name ?? "",
//                         textAlign: TextAlign.start,
//                         style: GoogleFonts.inter(
//                             fontWeight: FontWeight.w400,
//                             fontSize: 16.sp,
//                             color: Colors.white),
//                       ),
//                     ),
//                   );
//                 }))
//           ],
//         )),
//       ),
//     );
//   }
// }
