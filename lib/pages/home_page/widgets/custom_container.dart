/*
Created by Axmadjon Isaqov on 21:09:29 18.07.2022
© 2022 @axi_dev 
*/
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final bool? isBig;
  const CustomContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.isBig});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(isBig! ? 100 : 100)),
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
    );
  }
}
