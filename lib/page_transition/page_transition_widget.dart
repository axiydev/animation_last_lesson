/*
Created by Axmadjon Isaqov on 21:27:06 18.07.2022
© 2022 @axi_dev 
*/
import 'package:flutter/material.dart';

class CustomPageRouteBuilder extends PageRouteBuilder {
  Widget? child;

  CustomPageRouteBuilder({
    this.child,
  }) : super(
            transitionDuration: const Duration(milliseconds: 400),
            pageBuilder: (context, animation, secondaryAnimation) => child!,
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(
                      opacity: animation,
                      child: child,
                    ));
}
