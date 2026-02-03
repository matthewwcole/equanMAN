import 'package:flutter/material.dart';

class NeumorphicButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isPlaying;

  const NeumorphicButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isPlaying = false,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

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
    bool isPressed = _isPressed || widget.isPlaying;
    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
          boxShadow: isPressed
          ? [
              // Inner shadow
              BoxShadow(
                color: Colors.grey..shade500,
                offset: const Offset(-5, -5),
                blurRadius: 15,
                spreadRadius: 1,
                //inset: true,
              ),
              const BoxShadow(
                color: Colors.white,
                offset: Offset(5, 5),
                blurRadius: 15,
                spreadRadius: 1,
                //inset: true,
              ),
          ]
        : [
            // Outer shadow
            BoxShadow(
              color: Colors.grey.shade500,
              offset: const Offset(5, 5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-5, -5),
              blurRadius: 15,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ),
      );
  }
}