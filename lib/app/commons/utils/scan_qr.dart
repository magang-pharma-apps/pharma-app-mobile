import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanQr extends StatefulWidget {
  final Function(String) setResult;

  const ScanQr({
    required this.setResult,
    super.key,
  });

  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr>
    with SingleTickerProviderStateMixin {
  late final MobileScannerController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  bool _isTorchOn = false;

  @override
  void initState() {
    super.initState();
    _controller = MobileScannerController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 0,
      end: 280,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _toggleCamera() {
    _controller.switchCamera();
  }

  void _toggleTorch() {
    setState(() {
      _isTorchOn = !_isTorchOn;
      _controller.toggleTorch();
    });
  }

  void _cancelScan() async {
    await _controller.stop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: (BarcodeCapture capture) async {
              final List<Barcode> barcodes = capture.barcodes;
              final barcode = barcodes.first;

              if (barcode.rawValue != null) {
                widget.setResult(barcode.rawValue!);
                await _controller.stop();
                Navigator.of(context).pop();
              }
            },
          ),
          Center(
            child: Container(
              width: 280,
              height: 280,
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Positioned(
                        top: _animation.value,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: 260,
                          height: 2,
                          color: Colors.red,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          ClipPath(
            clipper: InvertedClipper(),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.flashlight_on, color: Colors.white, size: 40),
                    onPressed: _toggleTorch,
                  ),
                  IconButton(
                    icon: const Icon(Icons.flip_camera_android, color: Colors.white, size: 40),
                    onPressed: _toggleCamera,
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 40),
                    onPressed: _cancelScan,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: 280, height: 280),
        Radius.circular(16),
      ))
      ..fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}