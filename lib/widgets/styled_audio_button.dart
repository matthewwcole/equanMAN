import 'package:flutter/material.dart';

class AudioControlButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  const AudioControlButton({
    super.key,
    required this.label,
    required this.onPressed,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isActive
            ? Theme.of(context).primaryColor
            : Colors.grey,
        foregroundColor: Colors.white,
        fixedSize: const Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}