import 'package:flutter/material.dart';

class DrawnBubble extends StatefulWidget {
  final Color color;

  const DrawnBubble({
    Key key,
    @required this.color,
  }) : super(key: key);

  @override
  _DrawnBubbleState createState() => _DrawnBubbleState();
}

class _DrawnBubbleState extends State<DrawnBubble>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: const Duration(seconds: 5), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.expand(
        child: CustomPaint(
          painter: _BubblePainter(
            color: widget.color,
            bubbleSize: _animation.value,
          ),
        ),
      ),
    );
  }
}

class _BubblePainter extends CustomPainter {
  _BubblePainter({
    @required this.color,
    @required this.bubbleSize,
  });

  Color color;
  double bubbleSize;

  @override
  void paint(Canvas canvas, Size size) {
    final center = (Offset.zero & size).center;
    final radius = size.shortestSide * 0.5;

    final paint1 = Paint()..color = color.withOpacity(0.5 - 0.5 * bubbleSize);
    canvas.drawCircle(center, radius * bubbleSize, paint1);

    final paint2 = Paint()..color = color;
    canvas.drawCircle(center, radius * 0.05, paint2);
  }

  @override
  bool shouldRepaint(_BubblePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.bubbleSize != bubbleSize;
  }
}
