import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mcu_manager/flutter_mcu_manager.dart';
import 'package:flutter_mcu_manager/flutter_mcu_manager_platform_interface.dart';
import 'package:flutter_mcu_manager/flutter_mcu_manager_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMcuManagerPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMcuManagerPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
  
  @override
  Future<String?> startDFU({required String address, required String filePath, bool fileInAsset = false, FirmwareUpgradeMode mode = FirmwareUpgradeMode.testAndConfirm, int? estimatedSwapTime, bool? eraseAppSettings, int? pipelineDepth, int? reassemblyBufferSize, UpgradeCallback? upgradeDidStart, UpgradeCallback? upgradeDidComplete, UpgradeStateChangeCallback? upgradeStateDidChange, UpgradeStateCallback? upgradeDidCancel, UpgradeFailCallback? upgradeDidFail, UpgradeProgressCallback? uploadProgressDidChange}) {
    throw UnimplementedError();
  }
}

void main() {
  final FlutterMcuManagerPlatform initialPlatform = FlutterMcuManagerPlatform.instance;

  test('$MethodChannelFlutterMcuManager is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMcuManager>());
  });

  test('getPlatformVersion', () async {
    FlutterMcuManager flutterMcuManagerPlugin = FlutterMcuManager();
    MockFlutterMcuManagerPlatform fakePlatform = MockFlutterMcuManagerPlatform();
    FlutterMcuManagerPlatform.instance = fakePlatform;

    expect(await flutterMcuManagerPlugin.getPlatformVersion(), '42');
  });
}
