import 'package:flutter/material.dart';

class GradientStarButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;

  const GradientStarButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  State<GradientStarButton> createState() => _GradientStarButtonState();
}

class _GradientStarButtonState extends State<GradientStarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
    widget.onPressed();
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        transform: Matrix4.diagonal3Values(_isPressed ? 1.1 : 1.0, _isPressed ? 1.1 : 1.0, 1.0),
        transformAlignment: Alignment.center,
        child: Container(
          width: 13 * 16.0, // 13rem
          height: 3 * 16.0, // 3rem
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5 * 16.0), // 5rem
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFFDB3B),
                Color(0xFFFE53BB),
                Color(0xFF8F51EA),
                Color(0xFF0044FF),
              ],
            ),
            border: Border.all(
              color: Colors.transparent,
              width: 4,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF212121),
              borderRadius: BorderRadius.circular(5 * 16.0),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  fontFamily: "Avalors Personal Use",
                  fontSize: 12,
                  letterSpacing: 5,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 4.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
