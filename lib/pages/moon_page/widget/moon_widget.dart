import 'package:animation_last_lesson/consts/my_consts.dart';
import 'package:flutter/material.dart';

class MoonWidget extends StatelessWidget {
  const MoonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [
            Colors.grey[100]!.withOpacity(0.5),
            Colors.grey[200]!.withOpacity(0.4),
            Colors.grey[300]!.withOpacity(0.3),
            Colors.grey[500]!.withOpacity(0.2),
            Colors.black.withOpacity(0.3)
          ])),
      alignment: Alignment.center,
      child: Image.asset(
        MyConsts.moon,
        width: 100,
        height: 100,
      ),
    );
  }
}
