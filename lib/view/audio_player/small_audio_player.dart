import 'dart:developer';

import 'package:audio_service/audio_service.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:math';
import '../../controllers/home_controllers/songs_controller.dart';
import '../../models/song_model.dart';

class SmallAudioPlayer extends StatefulWidget {
  String mood;

   SmallAudioPlayer({super.key,required this.mood});

  @override
  State<SmallAudioPlayer> createState() => _SmallAudioPlayerState();
}

class _SmallAudioPlayerState extends State<SmallAudioPlayer> {
  final _player = AudioPlayer();

  int _index = 0;
  bool _loading = false;
  bool _playing = false;
  int ind=0;
  var random = Random();

  getData()async{
     await songsController.getSongs(mood: "tired");
     if(songsController.songs.isNotEmpty) {
       await setAudioSource();
       _playMusic();
     }

  }
  @override
  void initState() {
getData();
    super.initState();
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _playMusic() async {
    setState(() {
      _playing = true;
    });
    await _player.play();
  }

  void _pauseMusic() async {
    setState(() {
      _playing = false;
    });
    await _player.pause();
  }

  final songsController = Get.put(SongsControllers());

  ConcatenatingAudioSource createPlaylist(int songIndex) {
    setState(() {
      _index = songIndex;
    });
    final playlist = ConcatenatingAudioSource(
        useLazyPreparation: true,
        // shuffleOrder: DefaultShuffleOrder(),
        children: List.generate(songsController.songs.length, (index) {
          return AudioSource.uri(
              Uri.parse(songsController.songs[index].assetPath ?? ""),

            tag: MediaItem(
              id: songsController.songs[index].id.toString(),
              album: widget.mood.toUpperCase(),

              title: songsController.songs[index].name ??"",
              artUri: Uri.parse("https://cdn.pixabay.com/index/2024/03/15/02-10-19-229_1440x550.png"),

              playable: true
            ),
          );
        }));
    return playlist;
  }

  setAudioSource() async {

    await _player.setAudioSource(createPlaylist(0),
        initialIndex: 0, initialPosition: Duration.zero);

  }

  @override
  Widget build(BuildContext context) {
    return


     SafeArea(
      child:Obx(() => Scaffold(
          bottomNavigationBar: songsController.songLoading.value ?const Center(child: CircularProgressIndicator())  :  SizedBox(
              height: 100.h,
              child:  Center(
                child: Container(
                  alignment: Alignment.center,
                  height: 100.w,
                  color: Color(0xff2F2F2F),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: 0.3.sw,
                              child: Text(songsController.songs[_index].name ?? "",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.normal
                              ),)),
                          IconButton(
                            onPressed: () async {
                              if(_index>0){
                                setState(() {
                                  _loading = true;
                                });
                                await _player.seekToNext();
                                setState(() {
                                  _loading = false;
                                  _index--;
                                });
                              }

                            },
                            icon: const Icon(
                              Icons.fast_rewind_rounded,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            width: 50,
                            child:  _loading ?   const CircularProgressIndicator():  IconButton(
                              onPressed: () {
                                if (_playing) {
                                  _pauseMusic();
                                } else {
                                  _playMusic();
                                }
                              },
                              icon: Icon(
                                _playing ? Icons.pause : Icons.play_arrow,
                                color: Colors.white,
                                size: 40.sp,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              if( songsController.songs.length-1 > _index ){
                                setState(() {
                                  _loading = true;
                                });
                                await _player.seekToNext();
                                setState(() {
                                  _index++;
                                  _loading = false;
                                });
                              }

                            },
                            icon: const Icon(
                              Icons.fast_forward_rounded,
                              color: Colors.white,
                            ),
                          ), IconButton(
                            onPressed: () async {
                              if( songsController.songs.length-1 > _index ){
                                int ranInt =  random.nextInt(songsController.songs.length-1);
                                setState(() {
                                  _loading = true;
                                });
                                await _player.seek(Duration.zero, index:ranInt);
                                setState(() {
                                  _loading = false;
                                  _index = ranInt;
                                });
                              }

                            },
                            icon: const Icon(
                              Icons.shuffle,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: StreamBuilder<Duration>(
                          stream: _player.positionStream,
                          builder: (context, snapshot1) {
                            final duration = snapshot1.data ?? Duration.zero;
                            return StreamBuilder<Duration>(
                              stream: _player.bufferedPositionStream,
                              builder: (context, snapshot2) {
                                final bufferedDuration =
                                    snapshot2.data ?? Duration.zero;
                                return SizedBox(
                                  height: 30,
                                  child: ProgressBar(
                                      progress: duration,
                                      total: _player.duration ?? Duration.zero,
                                      buffered: bufferedDuration,
                                      timeLabelPadding: -1,
                                      timeLabelTextStyle: const TextStyle(
                                          fontSize: 14, color: Colors.white),
                                      progressBarColor: const Color(0xff3E47C6),
                                      baseBarColor: Colors.grey[200],
                                      bufferedBarColor: Colors.grey[350],
                                      thumbColor: const Color(0xff3E47C6),
                                      onSeek: (duration) async {
                                        await _player.seek(duration);
                                      }),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),

              )),
          backgroundColor: Colors.black,
          body:  Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/backgrounds/songs.png"),fit: BoxFit.fill)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.topCenter,

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: SizedBox(
                          height: 90,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                             InkWell(
                                 onTap: (){
                                   Get.back();
                                 },
                                 child: const Icon(Icons.arrow_back_rounded,color: Colors.white,size: 35,)),
                              Text(
                              widget.mood.toUpperCase(),
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 24.sp,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/avatar/tired_tp.svg")
                    ],
                  ),
                ),
                songsController.songLoading.value ? const CircularProgressIndicator()  : Expanded(child: ListView.builder(
                    itemCount: songsController.songs.length,
                    itemBuilder: (context,index){
                      SongModel song = songsController.songs[index];
                      return   Padding(
                        padding:  const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                        child: InkWell(
                          onTap: (){
                            setState(() {
                              _player.seek(Duration.zero,index: index);
                              _index = index;
                            });
                          },
                          child: Text(
                            song.name ?? "",
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 16.sp,
                                color: Colors.white),
                          ),
                        ),
                      );
                    }))
              ],
            ),
          )),
      ),
    );
  }
}
