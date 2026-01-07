import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DigitalClock extends StatefulWidget {
  final TextStyle? timeStyle;
  final TextStyle? dateStyle;
  final CrossAxisAlignment crossAxisAlignment;

  const DigitalClock({
    super.key,
    this.timeStyle,
    this.dateStyle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  late Timer _timer;
  late DateTime _currentTime;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    final dateFormat = DateFormat('EEEE, MMM d');

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: widget.crossAxisAlignment,
      children: [
        Text(
          timeFormat.format(_currentTime),
          style: widget.timeStyle ??
              const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.w200,
                color: Colors.white,
              ),
        ),
        Text(
          dateFormat.format(_currentTime),
          style: widget.dateStyle ??
              const TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
        ),
      ],
    );
  }
}
