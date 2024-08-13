import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:just_audio_background/just_audio_background.dart';
// import 'package:just_audio_background/just_audio_background.dart';
import 'package:task1/routes/app_pages.dart';
import 'package:task1/view/audio_player/small_audio_player.dart';
import 'package:task1/view/songs/songs_view.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyBO1anoaUMW1cBgNEtSmbKtYR2DhL75bH8",
            authDomain: "medlist-bc347.firebaseapp.com",
            projectId: "medlist-bc347",
            storageBucket: "medlist-bc347.appspot.com",
            messagingSenderId: "335430665006",
            appId: "1:335430665006:web:bc9ccde424392c6895f0bf",
            measurementId: "G-KJT8SZX0YP"
        ));
  } else {
    await Firebase.initializeApp();
  }
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
          initialRoute: AppPages.INITIAL,
          debugShowCheckedModeBanner: false,
          getPages: AppPages.routes,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: const TextTheme(
              bodyMedium: TextStyle(),
            ).apply(
              bodyColor: Colors.white,
            ),
          ),
        // home: SmallAudioPlayer(),
         ),
    );
  }
}
