import 'package:flutter/material.dart';

// Giant, high-contrast button
class BigButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;
  final Color color;

  const BigButton({
    super.key, 
    required this.text, 
    required this.icon, 
    required this.onPressed,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 80), // Tall button
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 5,
        ),
        onPressed: onPressed,
        icon: Icon(icon, size: 40),
        label: Text(
          text,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

// High visibility text field
class BigTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final int maxLines;

  const BigTextField({
    super.key, 
    required this.label, 
    required this.controller, 
    this.isPassword = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 22), // Large input text
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 20, color: Colors.black87),
          border: const OutlineInputBorder(borderSide: BorderSide(width: 2.0)),
          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2.0, color: Colors.grey)),
          focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 3.0, color: Colors.blue)),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    );
  }
}