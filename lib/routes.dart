import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_stresstest/screens/root_screen.dart';
import 'package:flutter_api_stresstest/screens/video_file_selection_screen.dart';
import 'package:flutter_api_stresstest/screens/video_player_screen.dart';

class Routes {
  static const String root = "/";
  static const String videoFileSelection = "/video-file-selection";
  static const String videoPlayerRoute = "/video-player/:file";
  static String videoPlayer(String file) {
    return videoPlayerRoute.replaceAll(":file", file.replaceAll("/", ":|:"));
  }

  static const String nativeTest = "/native-test";
  static const String nativeTestElementRoute = "/native-test-element/:number";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("Route not found: $params");
    });

    router.define(
      root,
      handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return RootScreen();
        },
      ),
    );

    router.define(
      videoFileSelection,
      handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return VideoFileSelectionScreen();
        },
      ),
    );

    router.define(
      videoPlayerRoute,
      handler: new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
          return VideoPlayerScreen(
            file: params["file"].first.replaceAll(":|:", "/"),
          );
        },
      ),
    );
  }
}
