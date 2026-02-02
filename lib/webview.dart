// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// class HanyScreen extends StatefulWidget {
//   const HanyScreen({super.key});
//
//   @override
//   State<HanyScreen> createState() => _HanyScreenState();
// }
//
// class _HanyScreenState extends State<HanyScreen> {
//   late final WebViewController controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _requestPermissions();
//
//     controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(Colors.white)
//       ..loadRequest(Uri.parse("https://hevo.thsite.top"));
//   }
//
//   Future<void> _requestPermissions() async {
//     await [
//       Permission.camera,
//       Permission.storage,
//       Permission.photos,
//       Permission.videos,
//     ].request();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: WebViewWidget(controller: controller),
//       ),
//     );
//   }
// }
