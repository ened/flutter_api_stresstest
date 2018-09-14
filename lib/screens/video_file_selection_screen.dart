import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_stresstest/application.dart';
import 'package:flutter_api_stresstest/routes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

class VideoFileSelectionScreen extends StatefulWidget {
  @override
  _VideoFileSelectionScreenState createState() =>
      _VideoFileSelectionScreenState();
}

enum FilesPermission { notDetermined, notGranted, granted }

class _VideoFileSelectionScreenState extends State<VideoFileSelectionScreen> {
  List<File> _files = [];

  FilesPermission _uiState = FilesPermission.notDetermined;

  @override
  void initState() {
    super.initState();

    _handlePermissions();
  }

  void _handlePermissions() async {
    if (Platform.isIOS) {
      setState(() {
        _uiState = FilesPermission.granted;
      });
      _loadFiles();

      return;
    }

    var granted = await SimplePermissions.checkPermission(
      Permission.ReadExternalStorage,
    );

    if (await SimplePermissions.checkPermission(
      Permission.ReadExternalStorage,
    )) {
      setState(() {
        _uiState = FilesPermission.granted;
      });
      _loadFiles();

      return;
    }

    granted = await SimplePermissions.requestPermission(
        Permission.ReadExternalStorage);
    setState(() {
      _uiState = granted ? FilesPermission.granted : FilesPermission.notGranted;
    });

    if (_uiState == FilesPermission.granted) {
      _loadFiles();
    }
  }

  void _loadFiles() async {
    Directory path = await getApplicationDocumentsDirectory();
    if (Platform.isAndroid) {
      path = await getExternalStorageDirectory();
    }

    debugPrint("directory: ${path.path}");

    final extensions = ["mov", "mp4"];
    final files = await path
        .list()
        .where((entry) => (entry is File))
        .where((entry) =>
            extensions.contains(entry.path.split(".").last.toLowerCase()))
        .map((entry) => (entry as File))
        .toList();
    setState(() {
      _files = files;
    });
  }

  List<Widget> _buildColumn() {
    List<Widget> widgets = [
      Expanded(
        child: ListView(
          children: _files.map(_mapFileToTile).toList(),
        ),
      ),
    ];

    return widgets;
  }

  ListTile _mapFileToTile(File file) => ListTile(
        title: Text(file.uri.pathSegments.last),
        subtitle: Text(
          "Size: ${(file.statSync().size / 1024 / 1024).round()} Mb",
        ),
        onTap: () {
          Application.router.navigateTo(
            context,
            Routes.videoPlayer(file.path),
            transition: TransitionType.inFromRight,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Video Player")),
      body: Column(children: _buildColumn()),
    );
  }
}
