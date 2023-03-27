import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:gdsc_clientx/utils/postVisionApi.dart';
import 'package:vector_math/vector_math_64.dart';
import '../../mock.dart';
import '../../model/warning.dart';
import '../../model/position.dart';
import '../general/eButton.dart';
import '../../views/warningListPage.dart';
import 'package:image/image.dart' as img;

class ScreenshotWidget extends StatefulWidget {
  ScreenshotWidget({Key? key}) : super(key: key);
  @override
  _ScreenshotWidgetState createState() => _ScreenshotWidgetState();
  final List<Warning> warningList = Mock.getWarningList;
}

class _ScreenshotWidgetState extends State<ScreenshotWidget> {
  ARSessionManager? arSessionManager;
  ARObjectManager? arObjectManager;
  ARAnchorManager? arAnchorManager;

  List<ARNode> nodes = [];
  List<ARAnchor> anchors = [];

  @override
  void dispose() {
    super.dispose();
    arSessionManager!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (Container(
        child: Stack(children: [
      ARView(
        onARViewCreated: onARViewCreated,
        planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
      ),
      Align(
        alignment: FractionalOffset.bottomCenter,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          eButton(buttonPressedVoidBack: onTakeScreenshot, buttonText: "Scan"),
          eButton(
            buttonPressedVoidBack: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return WarningListPage(
                    warningList: widget.warningList,
                  );
                },
              ),
            ),
            buttonText: "SHOW WARNING LIST",
          ),
        ]),
      )
    ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager!.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          showWorldOrigin: true,
        );
    this.arObjectManager!.onInitialize();

    this.arSessionManager!.onPlaneOrPointTap = onPlaneOrPointTapped;
    this.arObjectManager!.onNodeTap = onNodeTapped;
  }

  Future<void> onTakeScreenshot() async {
    // DUMMY
    final painter = await loadDummyImage();

    // REAL
    // final imageProvider = await arSessionManager!.snapshot();
    // if (!context.mounted) {
    //   return;
    // }
    // final painter = await convertImageToPainter(context, imageProvider);

    // Detect object positions
    final positions = await detectObjectPositions(painter);
    print(positions);

    // image need to be sent to Google Vision API
    warningMarkRender(Mock.objectsPosition);
  }

  /// [warningPositions] is a [Position] list which has already filtered by the detector result.
  Future<void> warningMarkRender(List<Position> warningPositions) async {
    // Add marks
    // warningPositions.map((positionValue) => );
    var newAnchor = ARPlaneAnchor(
        transformation: Matrix4(0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1,
            0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1));

    bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
    if (didAddAnchor!) {
      anchors.add(newAnchor);
      // Add note to anchor
      var newNode = ARNode(
          type: NodeType.webGLB,
          uri:
              "https://raw.githubusercontent.com/KhronosGroup/glTF-Sample-Models/master/2.0/Lantern/glTF/Lantern.gltf",
          scale: Vector3(0.2, 0.2, 0.2),
          position: Vector3(0.0, 0.0, 0.0),
          rotation: Vector4(1.0, 0.0, 0.0, 0.0));
      bool? didAddNodeToAnchor =
          await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);
      if (didAddNodeToAnchor!) {
        nodes.add(newNode);
      } else {
        arSessionManager!.onError("Adding Node to Anchor failed");
      }
    }
    // Create anchors
    // Shows them in ARCore
  }

  /// [onNodeTapped] is the function which will be used in touching the screen.
  Future<void> onNodeTapped(List<String> nodes) async {
    var number = nodes.length;
    arSessionManager!.onError("Tapped $number node(s)");
  }

  /// [onPlaneOrPointTapped] is the function which implement the tapping warning signs feature.
  /// [ARNode] is the anchor.
  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null) {
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool? didAddAnchor = await arAnchorManager!.addAnchor(newAnchor);
      if (didAddAnchor != null && didAddAnchor) {
        anchors.add(newAnchor);
        // Add note to anchor
        var newNode = ARNode(
            type: NodeType.webGLB,
            uri:
                "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
            scale: Vector3(0.2, 0.2, 0.2),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        bool? didAddNodeToAnchor =
            await arObjectManager!.addNode(newNode, planeAnchor: newAnchor);

        if (didAddNodeToAnchor != null && didAddNodeToAnchor) {
          nodes.add(newNode);
        } else {
          arSessionManager!.onError("Adding Node to Anchor failed");
        }
      } else {
        arSessionManager!.onError("Adding Anchor failed");
      }
    }
  }
}
