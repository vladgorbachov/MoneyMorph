import 'package:flutter/material.dart';

class GlossyEffect extends StatefulWidget {
  final Widget child;

  const GlossyEffect({Key? key, required this.child}) : super(key: key);

  @override
  _GlossyEffectState createState() => _GlossyEffectState();
}

class _GlossyEffectState extends State<GlossyEffect> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            widget.child,
            Positioned.fill(
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.3 * _controller.value),
                        Colors.white.withOpacity(0.1 * _controller.value),
                        Colors.transparent,
                      ],
                      stops: const [0, 0.3, 0.6],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}