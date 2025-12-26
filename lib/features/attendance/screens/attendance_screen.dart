import 'package:flutter/material.dart';
import 'package:fullcycle/shared/widgets/custom_button.dart';
import 'package:mobile_scanner/mobile_scanner.dart'; // for QR scanning

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final _controller = TextEditingController();
  String? scannedCode;
  bool isAttendanceOk = false;

  void _checkAttendance(String code) {
    setState(() {
      if (code == "12345") {
        isAttendanceOk = true;
      } else {
        isAttendanceOk = false;
      }
    });
  }

  void _scanQr() async {
    showDialog(
      context: context,
      builder: (_) => Scaffold(
        body: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                if (barcode.rawValue != null) {
                  Navigator.pop(context); // close scanner
                  _checkAttendance(barcode.rawValue!);
                }
              },
            ),
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تحضير المشارك")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // manual input
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Enter Code",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () => _checkAttendance(_controller.text),
                ),
              ),
            ),
            const SizedBox(height: 20),
            CustomElevatedButton(
              onTap: () {
                _scanQr();
              },
              buttonText: ("Scan QR"),
            ),

            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'تم الحضور',
                  style: TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  width: 20,
                ),
                if (isAttendanceOk)
                  const Icon(Icons.done, size: 50, color: Colors.green)
                else
                  const Icon(Icons.error, size: 50, color: Colors.red)
              ],
            )
          ],
        ),
      ),
    );
  }
}
