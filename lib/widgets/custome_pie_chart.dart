import 'dart:async'; // Import Timer
import 'package:flutter/material.dart';

import '../classes/rounded_piechart_painter_class.dart';

class AnimatedRoundedPieChart extends StatefulWidget {
  final double pendingTests;
  final double completedTests;

  const AnimatedRoundedPieChart({
    Key? key,
    required this.pendingTests,
    required this.completedTests,
  }) : super(key: key);

  @override
  _AnimatedRoundedPieChartState createState() =>
      _AnimatedRoundedPieChartState();
}

class _AnimatedRoundedPieChartState extends State<AnimatedRoundedPieChart>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  Timer? _delayTimer; // Timer for delay

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000), // Adjust animation speed
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedRoundedPieChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.pendingTests != widget.pendingTests ||
        oldWidget.completedTests != widget.completedTests) {
      _delayTimer?.cancel(); // Cancel any existing delay timer
      _delayTimer = Timer(const Duration(milliseconds: 500), () { // Add a 500ms delay
        _animationController.reset();
        _animationController.forward();
        _delayTimer = null; // Clear the timer
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _delayTimer?.cancel(); // Cancel timer on dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.38,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: RoundedPieChartPainter(
              animationValue: _animation.value,
              spacingAngle: 0.4,
              sections: [
                widget.pendingTests,
                widget.completedTests,
              ],
              colors: [
                const Color.fromRGBO(137, 187, 253, 1.0),
                const Color.fromRGBO(5, 92, 208, 1.0),
              ],
              strokeWidth: 18.0,
            ),
          );
        },
      ),
    );
  }
}