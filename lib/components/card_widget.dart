import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Widget child;

  CardWidget({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 279,
      height: 70,
      decoration: BoxDecoration(
        color: Color(0xFFCCE5E5),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Color(0xFF131313)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF131313),
            offset: Offset(5, 4),
          ),
        ],
      ),
      child: Center(child: child),
    );
  }
}
