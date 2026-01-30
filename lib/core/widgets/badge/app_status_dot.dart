import 'package:flutter/material.dart';

class AppStatusDot extends StatelessWidget {
  final bool? isOnline;
  const AppStatusDot({super.key,this.isOnline = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOnline! ? Colors.green : Colors.grey
      ),
    );
  }
}
