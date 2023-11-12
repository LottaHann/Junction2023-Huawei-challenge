// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

class CameraStream extends StatefulWidget {
  const CameraStream({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraStreamState createState() => _CameraStreamState();
}

class _CameraStreamState extends State<CameraStream> {
  CameraController? _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller?.initialize();
    _startImageCapture();
  }

  void _startImageCapture() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer t) async {
      if (_controller != null) {
        if (_controller!.value.isInitialized) {
          final image = await _controller!.takePicture();
          await _saveImage(image);
        }
      }
    });
  }

  Future<void> _saveImage(XFile image) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath =
        '${directory.path}/${DateTime.now().toIso8601String()}.jpg';
    await image.saveTo(imagePath);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: _controller?.value.isInitialized ?? false
          ? CameraPreview(_controller!)
          : Center(child: CircularProgressIndicator()),
    );
  }
}
