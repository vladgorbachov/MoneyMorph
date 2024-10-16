import 'package:flutter/material.dart';

class RGBBorderBox extends StatefulWidget {
  final Widget child;

  const RGBBorderBox({Key? key, required this.child}) : super(key: key);

  @override
  _RGBBorderBoxState createState() => _RGBBorderBoxState();
}

class _RGBBorderBoxState extends State<RGBBorderBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
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
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.black,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: Stack(
              children: [
                widget.child,
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.5),
                            Colors.orange.withOpacity(0.5),
                            Colors.yellow.withOpacity(0.5),
                            Colors.green.withOpacity(0.5),
                            Colors.blue.withOpacity(0.5),
                            Colors.indigo.withOpacity(0.5),
                            Colors.purple.withOpacity(0.5),
                            Colors.red.withOpacity(0.5),
                          ],
                          stops: const [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1],
                          begin: Alignment(-1.0 + _controller.value * 2, 0),
                          end: Alignment(_controller.value * 2, 0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}