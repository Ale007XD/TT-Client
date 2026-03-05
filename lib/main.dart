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
      debugShowCheckedModeBanner: false,
      home: VPNHomePage(),
    );
  }
}

class VPNHomePage extends StatefulWidget {
  const VPNHomePage({super.key});

  @override
  State<VPNHomePage> createState() => _VPNHomePageState();
}

class _VPNHomePageState extends State<VPNHomePage> {

  final FlutterV2ray _vpn = FlutterV2ray();

  bool connected = false;

  Future<String> loadConfig() async {
    return rootBundle.loadString("assets/vpn_config.json");
  }

  Future<void> connectVPN() async {

    final config = await loadConfig();

    await _vpn.startV2Ray(
      remark: "DefaultServer",
      config: config,
    );

    setState(() {
      connected = true;
    });
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      connectVPN();
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
          onPressed: connectVPN,
          child: Text(
            connected ? "VPN Connected" : "Connect VPN",
          ),
        ),
      ),
    );
  }
}
