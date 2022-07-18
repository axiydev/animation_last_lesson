/*
Created by Axmadjon Isaqov on 21:08:32 18.07.2022
© 2022 @axi_dev 
*/
import 'package:animation_last_lesson/page_transition/page_transition_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/moon_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/sun_widget.dart';
import 'package:animation_last_lesson/pages/moon_page_two/moon_page_two.dart';
import 'package:flutter/material.dart';

class MoonPageThree extends StatefulWidget {
  static const String path = '/moon_three';
  const MoonPageThree({super.key});

  @override
  State<MoonPageThree> createState() => _MoonPageThreeState();
}

class _MoonPageThreeState extends State<MoonPageThree>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size? _size;
  late bool? _isNight;
  late Animation<Offset> _moonAnimation;
  late Animation<Offset> _sunAnimation;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;

    _moonAnimation = Tween<Offset>(
            begin: Offset(-_size!.width / 2 - 200, 0), end: const Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _sunAnimation = Tween<Offset>(
            begin: const Offset(0, 0), end: Offset(_size!.width / 2 + 200, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceIn));
    _isNight = false;

    _moonAnimation.addListener(() {
      _moonAnimation.value.dx == 0 ? _changeDay(true) : _changeDay(false);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeDay(bool? isNight) {
    _isNight = isNight!;
    setState(() {});
  }

  void _navigateToPage() {
    Navigator.of(context)
        .push(CustomPageRouteBuilder(child: const MoonPageTwo()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: const Text("moon page three"),
      ),
      body: AnimatedContainer(
          height: _size!.height,
          width: _size!.width,
          curve: Curves.ease,
          color: _isNight! ? Colors.black : Colors.white,
          duration: const Duration(seconds: 2),
          alignment: Alignment.center,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _moonAnimation,
                builder: (context, child) => Transform.translate(
                  offset: _moonAnimation.value,
                  child: const MoonWidget(),
                ),
              ),
              AnimatedBuilder(
                animation: _sunAnimation,
                builder: (context, child) => Transform.translate(
                  offset: _sunAnimation.value,
                  child: const SunWidget(),
                ),
              ),
            ],
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'float1465',
            onPressed: _navigateToPage,
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'float355',
            onPressed: () {
              _changeDay;
              _controller.status == AnimationStatus.completed
                  ? _controller.reverse()
                  : _controller.forward();

              // Navigator.of(context).pushNamed(MoonPageThree.path);
            },
            child: const Icon(Icons.play_arrow),
          ),
        ],
      ),
    );
  }
}
