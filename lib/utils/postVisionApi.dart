import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:google_vision/google_vision.dart';
import 'package:google_vision/google_vision.dart' as google_vision;
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

Future<Painter> loadDummyImage(
    {String path = 'src/img/sample.jpeg',
    String temporaryFileName = 'sample.jpg'}) async {
  final imageFile =
      await getFileFromAsset(path, temporaryFileName: temporaryFileName);

  final image = Painter.fromFilePath(imageFile);
  return image;
}

Future<Painter> convertImageToPainter(
    BuildContext context, ImageProvider<Object> imageProvider) async {
  final bytes = await imageProvider.getBytes(context);
  if (bytes == null) {
    throw Exception('Failed to load image bytes.');
  }
  final compressedBytes = await FlutterImageCompress.compressWithList(
    bytes,
    minHeight: 1920,
    minWidth: 1080,
    format: CompressFormat.jpeg,
  );
  final painter = Painter(compressedBytes);
  return painter;
}

Future<AnnotatedResponses> detectObjectPositions(Painter painter) async {
  final jwtFromAsset = await getFileFromAsset('assets/google-credential.json',
      temporaryFileName: "credential.json");

  final googleVision = await GoogleVision.withJwt(jwtFromAsset);

  final requests = AnnotationRequests(requests: [
    AnnotationRequest(image: google_vision.Image(painter: painter), features: [
      Feature(maxResults: 10, type: 'FACE_DETECTION'),
      Feature(maxResults: 10, type: 'OBJECT_LOCALIZATION')
    ])
  ]);

  final annotatedResponses = await googleVision.annotate(requests: requests);

  return annotatedResponses;

  // for (var annotatedResponse in annotatedResponses.responses) {
  //   for (var faceAnnotation in annotatedResponse.faceAnnotations) {
  //     GoogleVision.drawText(
  //         cropped,
  //         faceAnnotation.boundingPoly.vertices.first.x + 2,
  //         faceAnnotation.boundingPoly.vertices.first.y + 2,
  //         'Face - ${faceAnnotation.detectionConfidence}');

  //     GoogleVision.drawAnnotations(
  //         cropped, faceAnnotation.boundingPoly.vertices);
  //   }
  // }
}

Future<String> getFileFromAsset(String assetFileName,
    {String? temporaryFileName}) async {
  final byteData = await rootBundle.load(assetFileName);

  final buffer = byteData.buffer;

  final fileName = temporaryFileName ?? assetFileName;

  final filePath = await getTempFile(fileName);

  try {
    await File(filePath).delete();
  } catch (_) {
    print("file not found");
  }

  await File(filePath).writeAsBytes(
      buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return filePath;
}

Future<String> getTempFile([String? fileName]) async {
  final tempDir = await getTemporaryDirectory();

  return '${tempDir.path}${Platform.pathSeparator}${fileName ?? UniqueKey().toString()}';
}

extension ImageTool on ImageProvider {
  Future<Uint8List?> getBytes(BuildContext context,
      {ImageByteFormat format = ImageByteFormat.rawRgba}) async {
    final imageStream = resolve(createLocalImageConfiguration(context));
    final Completer<Uint8List?> completer = Completer<Uint8List?>();
    final ImageStreamListener listener = ImageStreamListener(
      (imageInfo, synchronousCall) async {
        final bytes = await imageInfo.image.toByteData(format: format);
        if (!completer.isCompleted) {
          completer.complete(bytes?.buffer.asUint8List());
        }
      },
    );
    imageStream.addListener(listener);
    final imageBytes = await completer.future;
    imageStream.removeListener(listener);
    return imageBytes;
  }
}
