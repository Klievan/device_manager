import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_mcu_manager/flutter_mcu_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _deviceManagerPlugin = FlutterMcuManager();
  String _platformVersion = 'Unknown'; // Declare the variable here

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion =
        'DFU in progress'; // Set an initial value or fetch actual platform version
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      debugPrint("Starting DFU");
      await _deviceManagerPlugin.startDFU(
        address: "C2:48:1A:45:2F:6E",
        filePath: "assets/app_update.bin",
        fileInAsset: true,
        estimatedSwapTime: 37000,
        mode: FirmwareUpgradeMode.testAndConfirm,
        uploadProgressDidChange: (bytesSent, totalImageSize) =>
            print("Upload progress did change: $bytesSent / $totalImageSize"),
        upgradeDidComplete: () {
          print("Upgrade completed");
          platformVersion = 'DFU Completed'; // Update the value on completion
        },
        upgradeDidFail: (state, error) {
          print("Upgrade failed with state $state and error $error");
          platformVersion = 'DFU Failed'; // Update the value on failure
        },
        upgradeStateDidChange: (previousState, newState) =>
            print("State changed from $previousState to $newState"),
      );
    } on PlatformException {
      debugPrint("DFU failed");
      platformVersion = 'DFU failed';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion =
          platformVersion; // Update the state to reflect changes in the UI
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Row(
          children: [
            Center(
              child: Text(
                  'Running on: $_platformVersion\n'), // Use the _platformVersion variable
            ),
            TextButton(
              onPressed: () async {
                // Add functionality here if needed
              },
              child: const Text("This is a test"),
            ),
          ],
        ),
      ),
    );
  }
}
