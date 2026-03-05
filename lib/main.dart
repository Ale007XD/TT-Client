import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_v2ray/flutter_v2ray.dart';

void main() {
  runApp(const AlexTTClient());
}

class AlexTTClient extends StatelessWidget {
  const AlexTTClient({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: VPNPage(),
    );
  }
}

class VPNPage extends StatefulWidget {
  const VPNPage({super.key});

  @override
  State<VPNPage> createState() => _VPNPageState();
}

class _VPNPageState extends State<VPNPage> {

  final FlutterV2ray _vpn = FlutterV2ray();
  bool connected = false;

  Future<String> loadConfig() async {
    return await rootBundle.loadString('assets/vpn_config.json');
  }

  Future<void> connect() async {

    final config = await loadConfig();

    await _vpn.startV2Ray(
      remark: "Default",
      config: config,
    );

    setState(() {
      connected = true;
    });
  }

  @override
  void initState() {
    super.initState();

    // автоподключение
    Future.delayed(const Duration(seconds: 2), () {
      connect();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("AlexTTClient"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: connect,
          child: Text(connected ? "Connected" : "Connect"),
        ),
      ),
    );
  }
}
