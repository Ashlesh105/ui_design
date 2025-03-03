import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final MobileScannerController controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates
  );
  String? scannedResult;
  final TextEditingController urlController = TextEditingController();
  late double height,width;


  @override
  void dispose() {
    controller.dispose();
    urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: width,
      height: height*0.4,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.blue,
        // actions: [
        //   ToggleFlashlightButton(controller: controller),
        // ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Center(
            child: MobileScanner(
              fit: BoxFit.contain,
              controller: controller,
              // scanWindow: scanWindow,
              onDetect: (BarcodeCapture capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  print(barcode.rawValue);
                  setState(() {
                    scannedResult = barcode.rawValue;
                  });
                  _showBottomSheet(context, barcode.rawValue ?? 'No data');
                }
              },
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Expanded(
          //         child: TextField(
          //           controller: urlController,
          //           decoration: InputDecoration(
          //             labelText: 'Enter URL',
          //             border: OutlineInputBorder(
          //               borderSide: const BorderSide(color: Colors.blue, width: 2.0), // Customize color and width
          //               borderRadius: BorderRadius.circular(10.0), // Optional: Add rounded corners
          //             ),
          //             focusedBorder: OutlineInputBorder( // Border when the TextField is focused
          //               borderSide: const BorderSide(color: Colors.green, width: 2.0),
          //               borderRadius: BorderRadius.circular(10.0),
          //             ),
          //             enabledBorder: OutlineInputBorder( // Border when the TextField is enabled but not focused
          //               borderSide: const BorderSide(color: Colors.blue, width: 1.0),
          //               borderRadius: BorderRadius.circular(10.0),
          //             ),
          //           ),
          //         ),
          //       ),
          //       IconButton(
          //         icon: const Icon(Icons.arrow_forward),
          //         onPressed: () {
          //           _launchURL(urlController.text);
          //         },
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
  void _showBottomSheet(BuildContext context, String data) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Scanned Data:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(data),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch URL')),
      );
    }
  }
}


// class ToggleFlashlightButton extends StatelessWidget {
//   const ToggleFlashlightButton({required this.controller, super.key});
//
//   final MobileScannerController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: controller,
//       builder: (context, state, child) {
//         if (!state.isInitialized || !state.isRunning) {
//           return const SizedBox.shrink();
//         }
//
//         switch (state.torchState) {
//           case TorchState.auto:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_auto,color: Colors.black,),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.off:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_off,color: Colors.black,),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.on:
//             return IconButton(
//               color: Colors.white,
//               iconSize: 32.0,
//               icon: const Icon(Icons.flash_on,color: Colors.black,),
//               onPressed: () async {
//                 await controller.toggleTorch();
//               },
//             );
//           case TorchState.unavailable:
//             return const SizedBox.square(
//               dimension: 48.0,
//               child: Icon(
//                 Icons.no_flash,
//                 size: 32.0,
//                 color: Colors.grey,
//               ),
//             );
//         }
//       },
//     );
//   }
// }