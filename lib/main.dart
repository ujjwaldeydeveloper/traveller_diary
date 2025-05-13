import 'package:flutter/material.dart';
import '/widgets/bottom_bar.dart';
import '/widgets/proflie.dart';
import '/widgets/user_activity.dart';
import '/videos.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  VideoPlayerController? _controller;
  int currentIndex = 0;

  String addDemoData() {
    for (var video in videos) {
      if (video.isNotEmpty) {
        return video;
      }
      return '';
    }
    return '';
  }

  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(videos[currentIndex]))
          ..initialize().then((_) {
            setState(() {
              _controller!.play();
              _controller?.addListener(_videoListener);
            });
          });
  }

  void _videoListener() {
    if (_controller!.value.position >= _controller!.value.duration &&
        !_controller!.value.isPlaying) {
      _controller?.removeListener(_videoListener);
      _controller?.dispose();

      if (currentIndex + 1 < videos.length) {
        currentIndex++;
        _initializeAndPlay(currentIndex);
      }
    }
  }

  void _initializeAndPlay(int index) async {
    // Remove any existing listener
    _controller?.removeListener(_videoListener);

    // Dispose previous controller if it exists
    await _controller?.dispose();

    // Create new controller for the current video URL
    _controller = VideoPlayerController.networkUrl(Uri.parse(videos[index]));

    // Initialize the video
    await _controller!.initialize();

    // Refresh the UI
    setState(() {});

    // Start playing the video
    _controller!.play();

    // Add listener to check for video completion
    _controller!.addListener(_videoListener);
  }

  @override
  Widget build(BuildContext context) {
    return pageBuilder();
  }

  Widget pageBuilder() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: 0,
            viewportFraction: 1,
          ),
          itemCount: videos.length,
          onPageChanged: (index) {
            index = index % (videos.length);
            index = index + 1;
            // feedViewModel.changeVideo(index);
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (videos.length);
            return Column(
              children: [
                videoCard(),
              ],
            );
          },
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 64,
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(20), left: Radius.circular(20))),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              child: Text('Hot or Not',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.none,
                      color: Colors.white)),
            ),
          ),
        ),
      ],
    );
  }

  Widget videoCard() {
    return GestureDetector(
      onTap: () {
        _controller!.value.isPlaying
            ? _controller!.pause()
            : _controller!.play();
      },
      child: Stack(
        children: <Widget>[
          _controller!.value.isInitialized
              ? FittedBox(
                  fit: BoxFit.fill,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: VideoPlayer(_controller!),
                  ),
                )
              : Container(
                  color: Colors.black,
                  child: const Center(
                    child: Text("Loading"),
                  ),
                ),
          const BottomBar(),
          const Profile(),
          const UserActivity(),
        ],
      ),
    );
  }
}
