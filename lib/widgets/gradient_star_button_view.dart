import 'package:flutter/material.dart';

class GradientStarButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label; // renamed from 'text'
  final bool isActive; // added

  const GradientStarButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.isActive,
  });

  @override
  State<GradientStarButton> createState() => _GradientStarButtonState();
}

class _GradientStarButtonState extends State<GradientStarButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPointerDown(PointerDownEvent event) {
    setState(() => _isPressed = true);
    widget.onPressed();
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        transform: Matrix4.diagonal3Values(
          _isPressed ? 1.1 : 1.0,
          _isPressed ? 1.1 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // Gradient border glows when active, muted when inactive
            gradient: LinearGradient(
              colors: widget.isActive
                  ? const [
                      Color(0xFFFFDB3B),
                      Color(0xFFFE53BB),
                      Color(0xFF8F51EA),
                      Color(0xFF0044FF),
                    ]
                  : const [
                      Colors.grey,
                      Colors.grey,
                    ],
            ),
            border: Border.all(color: Colors.transparent, width: 4),
          ),
          child: Container(
            decoration: BoxDecoration(
              // Active: slightly lighter dark to show selection
              color: widget.isActive
                  ? const Color(0xFF2E2E2E)
                  : const Color(0xFF212121),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Text(
                widget.label, // renamed from widget.text
                style: TextStyle(
                  fontFamily: "Avalors Personal Use",
                  fontSize: 12,
                  letterSpacing: 5,
                  color: Colors.white,
                  // Glow on text when active
                  shadows: [
                    Shadow(
                      blurRadius: widget.isActive ? 8.0 : 0.0,
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