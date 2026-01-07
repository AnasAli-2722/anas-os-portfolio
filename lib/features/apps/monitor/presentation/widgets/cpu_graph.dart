import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class CpuGraph extends StatefulWidget {
  final Color color;
  const CpuGraph({super.key, required this.color});

  @override
  State<CpuGraph> createState() => _CpuGraphState();
}

class _CpuGraphState extends State<CpuGraph> {
  final List<double> _dataPoints = List.filled(30, 0.0);
  late Timer _timer;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) { // Faster updates
      if (mounted) {
        setState(() {
          _dataPoints.removeAt(0);
          // Generate a value between 0.2 and 0.8 to keep it centered but moving
          double newValue = 0.2 + (_random.nextDouble() * 0.6);
          // Add some noise based on previous value to make it look like a real graph
          double prevValue = _dataPoints.last;
          newValue = (prevValue + newValue) / 2; 
          _dataPoints.add(newValue);
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GraphPainter(_dataPoints, widget.color),
      size: Size.infinite,
    );
  }
}

class _GraphPainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _GraphPainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    // Ensure we have enough width per point
    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;
      // Invert Y so 1.0 is at top (0) and 0.0 is at bottom (height)
      // Add a clamp to ensure it stays within bounds
      final value = data[i].clamp(0.0, 1.0);
      final y = size.height - (value * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

    // Fill below
    final fillPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    return true; // Always repaint when data changes
  }
}
