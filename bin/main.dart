
import 'dart:async';
import 'dart:core';
import 'package:flutter_driver/flutter_driver.dart';
import 'package:fuchsia_remote_debug_protocol/fuchsia_remote_debug_protocol.dart';
import 'package:fuchsia_remote_debug_protocol/logging.dart';

Future<Null> main(List<String> args) async {
  Logger.globalLevel = LoggingLevel.info;
  
  if (args.isEmpty) {
    print('Expects an IP address and/or network interface');
    return;
  }
  
  final String address = args[0];
  final String interface = args.length > 1 ? args[1] : '';

  final String sshConfigPath = '../fuchsia/out/x64rel/ssh-keys/ssh_config';
  
  final FuchsiaRemoteConnection connection = await FuchsiaRemoteConnection.connect(address, interface, sshConfigPath);
  
  final Pattern isolatePattern = 'todo_list';
  
  print('Finding $isolatePattern');
  
  final List<IsolateRef> refs = await connection.getMainIsolatesByPattern(isolatePattern);
  
  final IsolateRef ref = refs.first;
  
  print('Driving ${ref.name}');
  
  final FlutterDriver driver = await FlutterDriver.connect(
      dartVmServiceUrl: ref.dartVm.uri.toString(),
      isolateNumber: ref.number,
      printCommunication: true,
      logCommunicationToFile: false,
  );
      
  for (int i = 0; i < 5; ++i) {
    await driver.scroll(
      find.byType('Scaffold'), 
      0.0, 
      -300.0,
      const Duration(milliseconds: 300),
    );
    
    await new Future<Null>.delayed(const Duration(milliseconds: 500));
    
    await driver.scroll(
      find.byType('Scaffold'), 
      300.0, 
      300.0,
      const Duration(milliseconds: 300),
    );
  }
  
  await driver.close();
  await connection.stop();
}
