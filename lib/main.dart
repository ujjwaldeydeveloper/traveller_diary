import 'package:flutter/material.dart';
import 'package:traveller_diary/video_manager.dart';
import '/widgets/bottom_bar.dart';
import '/widgets/proflie.dart';
import '/widgets/user_activity.dart';
import '/videos.dart';
import 'package:video_player/video_player.dart';

import 'video_player_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final VideoManager _videoManager;
  final PageController _pageController = PageController();

  bool _isLoading = true; // Add a loading state

  @override
  void initState() {
    super.initState();
    _videoManager = VideoManager();
    _videoManager.initialize().then((_) {
      if (mounted && _videoManager.controllers.isNotEmpty) {
        setState(() {
          _isLoading = false; // Set loading state to false
        }); // Refresh to rebuild with initialized controllers
        _videoManager.controllers[0].play(); // Start first video
      }
    });
  }

  void dispose() {
    _videoManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (_isLoading) {
    //   // Show a loading indicator while initializing
    //   return const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // }
    return pageBuilder();
  }

  Widget pageBuilder() {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: videos.length,
          scrollDirection: Axis.vertical,
          onPageChanged: (index) async {
            await _videoManager.pauseAllExcept(index);
            await _videoManager.pauseAndDisposeFarVideos(index);
            await _videoManager.preloadAdjacent(index); // preload without fetching
          },
          itemBuilder: (context, index) {
            if (index >= _videoManager.controllers.length) {
              return const Center(child: CircularProgressIndicator());
            }

            final controller = _videoManager.controllers[index];

            if (!controller.value.isInitialized) {
              controller.initialize().then((_) {
                if (mounted) setState(() {});
              });
              return const Center(child: CircularProgressIndicator());
            }

            return VideoPlayerItem(controller: controller);
          },
        ),
        // Positioned(
        //   left: MediaQuery.of(context).size.width / 2 - 64,
        //   child: SafeArea(
        //     child: Container(
        //       decoration: BoxDecoration(
        //           color: Colors.amber,
        //           borderRadius: BorderRadius.horizontal(
        //               right: Radius.circular(20), left: Radius.circular(20))),
        //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        //       child: Text('Hot or Not',
        //           style: TextStyle(
        //               fontSize: 16.0,
        //               fontWeight: FontWeight.bold,
        //               decoration: TextDecoration.none,
        //               color: Colors.white)),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  // Widget videoCard() {
  //   return GestureDetector(
  //     onTap: () {
  //       _controller!.value.isPlaying
  //           ? _controller!.pause()
  //           : _controller!.play();
  //     },
  //     child: Stack(
  //       children: <Widget>[
  //         _controller!.value.isInitialized
  //             ? FittedBox(
  //                 fit: BoxFit.fill,
  //                 child: SizedBox(
  //                   height: MediaQuery.of(context).size.height,
  //                   width: MediaQuery.of(context).size.width,
  //                   child: VideoPlayer(_controller!),
  //                 ),
  //               )
  //             : Container(
  //                 color: Colors.black,
  //                 child: const Center(
  //                   child: Text("Loading"),
  //                 ),
  //               ),
  //         const BottomBar(),
  //         const Profile(),
  //         const UserActivity(),
  //       ],
  //     ),
  //   );
  // }
}
