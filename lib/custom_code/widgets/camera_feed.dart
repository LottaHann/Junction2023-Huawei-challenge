// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:camera/camera.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart'; // Added permission_handler
import 'package:image/image.dart' as img;
import 'package:google_ml_kit/google_ml_kit.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';

class CameraFeed extends StatefulWidget {
  const CameraFeed({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _CameraFeedState createState() => _CameraFeedState();
}

class _CameraFeedState extends State<CameraFeed> {
  CameraController? _controller;
  Timer? _timer;
  PoseDetector _poseDetector = GoogleMlKit.vision.poseDetector();
  List<Pose> _detectedPoses = [];
  Uint8List? imageBytes;
  double _imageWidth = 0;
  double _imageHeight = 0;
  double? _widthScaleFactor;
  double? _heightScaleFactor;

  int reps = 0;
  bool isGoingDown = true;
  double lastShoulderHeight = 0;
  bool hasStarted = false;
  double initShoulderHeight = 0;
  double toleranceMargin = 50; // Set this value based on your needs
  String debugInfo = '';

  void _updateDebugInfo(String newDebugInfo) {
    setState(() {
      debugInfo = newDebugInfo;
    });
  }

  void countReps(double liveShoulderHeight) {
    if (initShoulderHeight == 0) {
      initShoulderHeight = liveShoulderHeight;
    }

    if (hasStarted ||
        liveShoulderHeight < (initShoulderHeight - toleranceMargin)) {
      hasStarted = true;
      if (isGoingDown) {
        if (liveShoulderHeight > lastShoulderHeight) {
          isGoingDown = false;
        }
      } else {
        if (liveShoulderHeight < lastShoulderHeight) {
          reps += 1;
          isGoingDown = true; // Reset for next rep
        }
      }
    }
    lastShoulderHeight = liveShoulderHeight; // Update for next frame
  }

  Future<void> _detectPose(String path) async {
    try {
      final InputImage inputImage = InputImage.fromFile(File(path));
      final List<Pose> poses = await _poseDetector.processImage(inputImage);

      final Set<PoseLandmarkType> requiredLandmarks = {
        PoseLandmarkType.leftShoulder,
        PoseLandmarkType.rightShoulder,
        PoseLandmarkType.leftElbow,
        PoseLandmarkType.rightElbow,
        PoseLandmarkType.leftWrist,
        PoseLandmarkType.rightWrist,
        PoseLandmarkType.leftHip,
        PoseLandmarkType.rightHip,
      };

      // Filtering landmarks
      for (var pose in poses) {
        pose.landmarks
            .removeWhere((key, value) => !requiredLandmarks.contains(key));
      }

      setState(() {
        _detectedPoses = poses;
      });

      Pose? detectedPose = poses.isNotEmpty ? poses.first : null;
      if (detectedPose != null) {
        var leftShoulder =
            detectedPose.landmarks[PoseLandmarkType.leftShoulder];
        var rightShoulder =
            detectedPose.landmarks[PoseLandmarkType.rightShoulder];
        if (leftShoulder != null && rightShoulder != null) {
          double liveShoulderHeight =
              (leftShoulder.y + rightShoulder.y) * 0.5 * _heightScaleFactor!;
          countReps(liveShoulderHeight);
        }
      }
    } catch (e) {
      print('Error detecting pose: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _requestCameraPermission(); // Request camera permission before initializing
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      _initializeCamera();
    } else {
      // Handle the case where the user denied camera permission
      print('Camera permission denied');
    }
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    //final firstCamera = cameras.first; <= old version. Picks first camera in list
    final CameraDescription firstCamera = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.front);
    _controller = CameraController(
      firstCamera,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    await _controller?.initialize();
    _startImageCapture();
  }

  void _startImageCapture() {
    _timer = Timer.periodic(Duration(milliseconds: 30), (Timer t) async {
      if (_controller != null && _controller!.value.isInitialized) {
        final XFile imageFile = await _controller!.takePicture();
        final path = imageFile.path;

        await _calculateScaleFactors(
            File(path),
            Size(widget.width ?? MediaQuery.of(context).size.width,
                widget.height ?? MediaQuery.of(context).size.height));

        await _detectPose(path);
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    _poseDetector.close();
    super.dispose();
  }

  Future<void> _calculateScaleFactors(File imageFile, Size widgetSize) async {
    final Completer<Size> completer = Completer<Size>();
    final ImageStream stream =
        Image.file(imageFile).image.resolve(const ImageConfiguration());
    stream.addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        // Original image size
        final Size originalImageSize =
            Size(info.image.width.toDouble(), info.image.height.toDouble());
        _imageWidth = originalImageSize.width;
        _imageHeight = originalImageSize.height;

        // Calculating the scaled height based on the aspect ratio of the original image
        double scaledHeight;
        if (originalImageSize.width / originalImageSize.height >
            widgetSize.width / widgetSize.height) {
          scaledHeight = widgetSize.width *
              originalImageSize.height /
              originalImageSize.width;
        } else {
          scaledHeight = widgetSize.height;
        }

        // Set the scale factors
        _widthScaleFactor = widgetSize.width / _imageWidth;
        _heightScaleFactor = scaledHeight / _imageHeight;

        completer.complete(originalImageSize);
      }),
    );

    await completer.future; // Wait for the image size to be obtained
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          _controller?.value.isInitialized ?? false
              ? CameraPreview(_controller!)
              : Center(child: CircularProgressIndicator()),
          Text(
            'Reps: $reps', // This line displays the rep count
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (_detectedPoses.isNotEmpty)
            CustomPaint(
              painter: PosePainter(
                  _detectedPoses, _widthScaleFactor, _heightScaleFactor),
              child: Container(
                width: widget.width ?? double.infinity,
                height: widget.height ?? double.infinity,
              ),
            ),
        ],
      ),
    );
  }
}

class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final double? widthScaleFactor;
  final double? heightScaleFactor;

  PosePainter(this.poses, this.widthScaleFactor, this.heightScaleFactor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    for (var pose in poses) {
      for (var landmark in pose.landmarks.values) {
        var scaledX = landmark.x * widthScaleFactor!;
        var scaledY = landmark.y * heightScaleFactor!;

        canvas.drawCircle(Offset(scaledX, scaledY), 3, paint);
      }
    }

    final linePaint = Paint()
      ..color = Color(0xffffc24b)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    for (var pose in poses) {
      // Define connections based on the Pose Landmark types
      var connections = {
        PoseLandmarkType.leftWrist: PoseLandmarkType.leftElbow,
        PoseLandmarkType.leftElbow: PoseLandmarkType.leftShoulder,
        PoseLandmarkType.leftShoulder: PoseLandmarkType.rightShoulder,
        PoseLandmarkType.rightShoulder: PoseLandmarkType.rightElbow,
        PoseLandmarkType.rightElbow: PoseLandmarkType.rightWrist,
        // Add more connections as needed
      };

      // Draw connections
      connections.forEach((startType, endType) {
        var startLandmark = pose.landmarks[startType];
        var endLandmark = pose.landmarks[endType];
        if (startLandmark != null && endLandmark != null) {
          var start = Offset(startLandmark.x * widthScaleFactor!,
              startLandmark.y * heightScaleFactor!);
          var end = Offset(endLandmark.x * widthScaleFactor!,
              endLandmark.y * heightScaleFactor!);
          canvas.drawLine(start, end, linePaint);
        }
      });
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return oldDelegate.poses != poses;
  }
}
