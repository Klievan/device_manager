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
