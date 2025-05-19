import 'package:traveller_diary/videos.dart';
import 'package:video_player/video_player.dart';

class VideoManager {
  final List<VideoPlayerController> controllers = [];

  List<String> get videoUrls => videos;

  Future<void> initialize() async {
    controllers.clear();
    for (final url in videoUrls) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      controller.setLooping(true);
      controllers.add(controller);
    }

    // Only initialize first few (e.g., 3)
    for (int i = 0; i < controllers.length && i < 3; i++) {
      await controllers[i].initialize();
    }
  }

  Future<void> pauseAllExcept(int index) async {
    if (controllers.isEmpty || index >= controllers.length) return;
    for (int i = 0; i < controllers.length; i++) {
      if (i == index) {
        controllers[i].play();
      } else {
        controllers[i].pause();
      }
    }
    // Initialize the next and previous controllers
    if (index + 1 < controllers.length &&
        !controllers[index + 1].value.isInitialized) {
      await controllers[index + 1].initialize();
    }
    if (index - 1 >= 0 && !controllers[index - 1].value.isInitialized) {
      await controllers[index - 1].initialize();
    }
  }

  Future<void> pauseAndDisposeFarVideos(int currentIndex) async {
    if (controllers.isEmpty ||
        currentIndex < 0 ||
        currentIndex >= controllers.length) return;
    //  if (controllers.isEmpty) return; // Guard clause
    for (int i = 0; i < controllers.length; i++) {
      if ((i - currentIndex).abs() > 2) {
        if (i < controllers.length && controllers[i].value.isInitialized) {
          controllers[i].dispose();
          final newController =
              VideoPlayerController.networkUrl(Uri.parse(videoUrls[i]))
                ..setLooping(true);
          controllers[i] = newController;
        }
      }
    }
  }

  Future<void> preloadAdjacent(int index) async {
    if (controllers.isEmpty) return; // Guard clause
    // Only preload next and previous if not already initialized
    for (int offset in [-1, 1]) {
      final adjIndex = index + offset;
      if (adjIndex >= 0 && adjIndex < controllers.length) {
        final controller = controllers[adjIndex];
        if (!controller.value.isInitialized) {
         await controller.initialize();
        }
      }
    }
  }

  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
  }
}
