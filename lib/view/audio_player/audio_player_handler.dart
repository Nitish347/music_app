// import 'package:audio_service/audio_service.dart';
// import 'package:just_audio/just_audio.dart';
//
// class AudioPlayerHandler extends BaseAudioHandler implements SeekHandler {
//   final _player = AudioPlayer();
//
//   AudioPlayerHandler() {
//     _notifyAudioHandlerAboutPlaybackEvents();
//   }
//
//   Future<void> playMedia(MediaItem mediaItem) async {
//     mediaItem = MediaItem(
//       id: mediaItem.id,
//       album: mediaItem.album,
//       title: mediaItem.title,
//       artist: mediaItem.artist,
//       duration: mediaItem.duration,
//       artUri: mediaItem.artUri,
//     );
//     mediaItemStream.add(mediaItem);
//     await _player.setAudioSource(AudioSource.uri(Uri.parse(mediaItem.id)));
//     _player.play();
//   }
//
//   void _notifyAudioHandlerAboutPlaybackEvents() {
//     _player.playbackEventStream.listen((event) {
//       final playing = _player.playing;
//       playbackState.add(playbackState.value.copyWith(
//         controls: [
//           MediaControl.rewind,
//           if (playing) MediaControl.pause else MediaControl.play,
//           MediaControl.fastForward,
//           MediaControl.stop,
//         ],
//         systemActions: const {
//           MediaAction.seek,
//           MediaAction.seekForward,
//           MediaAction.seekBackward,
//         },
//         androidCompactActionIndices: const [0, 1, 2],
//         processingState: _getProcessingState(),
//         playing: playing,
//         updatePosition: _player.position,
//         bufferedPosition: _player.bufferedPosition,
//         speed: _player.speed,
//       ));
//     });
//   }
//
//   AudioProcessingState _getProcessingState() {
//     switch (_player.processingState) {
//       case ProcessingState.idle:
//         return AudioProcessingState.idle;
//       case ProcessingState.loading:
//         return AudioProcessingState.loading;
//       case ProcessingState.buffering:
//         return AudioProcessingState.buffering;
//       case ProcessingState.ready:
//         return AudioProcessingState.ready;
//       case ProcessingState.completed:
//         return AudioProcessingState.completed;
//       default:
//         return AudioProcessingState.idle;
//     }
//   }
//
//   @override
//   Future<void> play() => _player.play();
//
//   @override
//   Future<void> pause() => _player.pause();
//
//   @override
//   Future<void> seek(Duration position) => _player.seek(position);
//
//   @override
//   Future<void> stop() async {
//     await _player.stop();
//     await super.stop();
//   }
// }
