import 'package:flutter/material.dart';

class GlossyContainer extends StatelessWidget {
  final Widget child;
  final bool isKnob;

  const GlossyContainer({Key? key, required this.child, this.isKnob = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFD0D0D0),
            Color(0xFFE8E8E8),
            Color(0xFFF5F5F5),
            Color(0xFFE8E8E8),
            Color(0xFFD0D0D0),
          ],
        ),
        borderRadius: BorderRadius.circular(isKnob ? 100 : 20),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.5),
            offset: Offset(-5, -5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: Offset(5, 5),
            blurRadius: 10,
          ),
        ],
      ),
      child: child,
    );
  }
}