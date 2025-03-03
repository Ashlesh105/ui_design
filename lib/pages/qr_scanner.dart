import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

import '../classes/scanner_custompaint.dart';

class QrScanner extends StatefulWidget {
  const QrScanner({super.key});

  @override
  State<QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner> {
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  HashSet<String> scannedData = HashSet<String>();
  final TextEditingController urlController = TextEditingController();
  late double height, width;

  @override
  void dispose() {
    controller.dispose();
    urlController.dispose();
    super.dispose();
  }

  Future<void> scanImage(XFile image) async {
    final result = await controller.analyzeImage(image.path);
    if (result != null && result.barcodes.isNotEmpty) {
      for (final barcode in result.barcodes) {
        if (barcode.rawValue != null) {
          setState(() {
            scannedData.add(barcode.rawValue.toString());
          });
        }
      }
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Scan QR Code')),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (BarcodeCapture capture) {
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  setState(() {
                    scannedData.add(barcode.rawValue.toString());
                  });
                }
              }
            },
          ),
          ScannerOverlay(
            widthPercentage: 0.7,
            heightPercentage: 0.7,
            gapPercentage: 0.08,
          ),
          Positioned(
            top: height * 0.48,
            left: width * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  final getImage = await ImagePicker().pickImage(
                    source: ImageSource.gallery,
                  );
                  if (getImage != null) {
                    await scanImage(getImage);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.image, color: Colors.black),
                    SizedBox(width: width * 0.02),
                    Text(
                      'Upload from gallery',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomSheetContent(scannedData.toList()),
        ],
      ),
    );
  }

  Widget _buildBottomSheetContent(List<String> data) {
    return DraggableScrollableSheet(
      expand: true,
      initialChildSize: 0.25,
      maxChildSize: 0.5,
      builder: (context, scrollController) {
        return Container(
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: height*0.02,
              ),
              const Text(
                'Scanned Data:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        scrollPadding: EdgeInsets.all(MediaQuery.of(context).viewInsets.bottom,
                        ),
                        controller: urlController,
                        decoration: InputDecoration(
                          labelText: 'Enter URL',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.green,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.launch),
                      onPressed: () {
                        _launchURL(urlController.text);
                        urlController.clear();
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  controller: scrollController,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index]),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        // To keep the Row as small as possible
                        children: [
                          IconButton(
                            onPressed: () {
                              Clipboard.setData(
                                ClipboardData(text: data[index]),
                              );
                            },
                            icon: Icon(Icons.copy_all),
                          ),
                          IconButton(
                            onPressed: () {
                              _launchURL(data[index]);
                            },
                            icon: Icon(Icons.launch),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not launch URL')));
    }
  }
}
