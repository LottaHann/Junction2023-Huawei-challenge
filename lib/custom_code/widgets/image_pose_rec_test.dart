// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:ui' as ui; // Added for ui.Image
import 'dart:io'; // For File
import 'dart:async';
import 'package:image_picker/image_picker.dart'; // To pick an image from the file system
import 'package:google_mlkit_pose_detection/google_mlkit_pose_detection.dart';

class ImagePoseRecTest extends StatefulWidget {
  final double? width;
  final double? height;

  const ImagePoseRecTest({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  _ImagePoseRecTestState createState() => _ImagePoseRecTestState();
}

class _ImagePoseRecTestState extends State<ImagePoseRecTest> {
  final ImagePicker _picker = ImagePicker();
  final PoseDetector _poseDetector =
      PoseDetector(options: PoseDetectorOptions());
  String _status = 'Waiting to start...';
  File? _imageFile; // New variable to store the picked image file
  List<Pose> _detectedPoses = []; // New variable to store detected poses
  bool _imagePicked = false; // New variable to track if image is picked
  double? _widthScaleFactor;
  double? _heightScaleFactor;
  String _debugInfo = '';
  double _imageWidth = 0;
  double _imageHeight = 0;

  void _updateDebugInfo(String newDebugInfo) {
    setState(() {
      _debugInfo = newDebugInfo;
    });
  }

  Future<void> detectPose() async {
    setState(() {
      _status = 'Picking image...';
    });

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) {
      setState(() {
        _status = 'Image pick cancelled.';
      });
      return; // User canceled the picker
    }

    // Calculate the scale factors here
    await _calculateScaleFactors(
        File(image.path),
        Size(widget.width ?? MediaQuery.of(context).size.width,
            widget.height ?? MediaQuery.of(context).size.height));

    setState(() {
      _status = 'Detecting pose...';
    });

    final InputImage inputImage = InputImage.fromFilePath(image.path);
    try {
      final List<Pose> poses = await _poseDetector.processImage(inputImage);
      setState(() {
        _imageFile = File(image.path); // Store the image file
        _detectedPoses = poses; // Store the detected poses

        if (poses.isEmpty) {
          _status = 'No poses detected.';
        } else {
          _status = 'Poses detected';
        }
      });
    } catch (e) {
      setState(() {
        _status = 'Error detecting pose: $e';
      });
    }
  }

  @override
  void dispose() {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Pose Detection Test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Show button only if image is not picked
            if (!_imagePicked)
              Container(
                width: widget.width ?? double.infinity,
                height: widget.height ?? double.infinity,
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    detectPose();
                    setState(() {
                      _imagePicked = true; // Set to true after image is picked
                    });
                  },
                  child: Text('Detect Pose from Image'),
                ),
              ),
            if (_imageFile != null)
              Expanded(
                // Use Expanded to fill available space
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    // Image
                    Image.file(
                      _imageFile!,
                      width: MediaQuery.of(context).size.width, // Full width
                      fit: BoxFit
                          .fitWidth, // Fit the width, maintain aspect ratio
                    ),

                    // Custom Paint
                    CustomPaint(
                      painter: PosePainter(
                          _detectedPoses,
                          _imageFile,
                          _widthScaleFactor,
                          _heightScaleFactor,
                          _updateDebugInfo),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: (_imageHeight / _imageWidth) *
                            MediaQuery.of(context)
                                .size
                                .width, // Height based on image aspect ratio
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class PosePainter extends CustomPainter {
  final List<Pose> poses;
  final File? imageFile;
  final double? widthScaleFactor;
  final double? heightScaleFactor;
  final Function(String) updateDebugInfo;

  PosePainter(this.poses, this.imageFile, this.widthScaleFactor,
      this.heightScaleFactor, this.updateDebugInfo);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 5
      ..style = PaintingStyle.fill;

    updateDebugInfo("getting to if statement");
    if (widthScaleFactor != null && heightScaleFactor != null) {
      updateDebugInfo("factors not null");
      for (var pose in poses) {
        updateDebugInfo("found poses");
        for (var landmark in pose.landmarks.values) {
          updateDebugInfo("found landmarks");
          var scaledX = landmark.x * widthScaleFactor!;
          var scaledY = landmark.y * heightScaleFactor!;
          canvas.drawCircle(Offset(scaledX, scaledY), 4, paint);

          // Update debug info with the first landmark's original and scaled coordinates
          if (pose == poses.first && landmark == pose.landmarks.values.first) {
            String debugInfo =
                'Original X: ${landmark.x}, Original Y: ${landmark.y}, '
                'Scaled X: $scaledX, Scaled Y: $scaledY';
            updateDebugInfo(debugInfo);
          }
        }
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
