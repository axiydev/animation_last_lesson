import 'package:animation_last_lesson/consts/my_consts.dart';
import 'package:flutter/material.dart';

class SunWidget extends StatelessWidget {
  const SunWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            Colors.orange[100]!.withOpacity(0.5),
            Colors.orange[200]!.withOpacity(0.4),
            Colors.orange[300]!.withOpacity(0.3),
            Colors.orange[500]!.withOpacity(0.2),
            Colors.white.withOpacity(0.3)
          ])),
      alignment: Alignment.center,
      child: Image.asset(
        MyConsts.sun,
        width: 100,
        height: 100,
      ),
    );
  }
}
