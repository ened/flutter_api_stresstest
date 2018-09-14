import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_stresstest/application.dart';
import 'package:flutter_api_stresstest/routes.dart';

class RootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter API Stresstest"),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text("Video Player Test"),
            onTap: () {
              Application.router.navigateTo(
                context,
                Routes.videoFileSelection,
                transition: TransitionType.inFromRight,
              );
            },
          ),
          ListTile(
            title: Text("Native Widget Test"),
            onTap: () {
              debugPrint("Native Widget Test");
            },
          ),
        ],
      ),
    );
  }
}
