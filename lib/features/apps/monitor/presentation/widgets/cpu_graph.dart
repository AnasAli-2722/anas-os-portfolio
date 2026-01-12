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
    _timer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      if (mounted) {
        setState(() {
          _dataPoints.removeAt(0);

          double newValue = 0.2 + (_random.nextDouble() * 0.6);

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

    final stepX = size.width / (data.length - 1);

    for (int i = 0; i < data.length; i++) {
      final x = i * stepX;


      final value = data[i].clamp(0.0, 1.0);
      final y = size.height - (value * size.height);
      
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);

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
    return true;
  }
}

