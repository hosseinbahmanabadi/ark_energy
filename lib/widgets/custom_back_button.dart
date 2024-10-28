import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomBackButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: Color(0xFFFDFDFD), // Background color
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF131313)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF131313),
                offset: Offset(5, 4),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.arrow_back,
              color: Color(0xFF131313),
              size: 20
            ),
          ),
        ),
      ),
    );
  }
}
