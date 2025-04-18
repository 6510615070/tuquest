import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatelessWidget {
  const QrPage({Key? key}) : super(key: key);
  Widget generateQRCode(String input) {
    return QrImageView(
      data: input,
      version: QrVersions.min,
      backgroundColor: Colors.white,
      errorCorrectionLevel: QrErrorCorrectLevel.M,
      size: 200.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("QR Code")),
      body: Center(
        child: generateQRCode("1234asdfffffff"),
      ),
    );
  }
}
