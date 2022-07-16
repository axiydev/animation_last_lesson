import 'package:animation_last_lesson/pages/moon_page/widget/moon_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/sun_widget.dart';
import 'package:flutter/material.dart';

class MoonPageTwo extends StatefulWidget {
  static const String path = '/moon_two';
  const MoonPageTwo({super.key});

  @override
  State<MoonPageTwo> createState() => _MoonPageTwoState();
}

class _MoonPageTwoState extends State<MoonPageTwo>
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

  get _changeDay {
    _isNight = !_isNight!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AnimatedContainer(
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
                ))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            _changeDay;
            _controller.status == AnimationStatus.completed
                ? _controller.reverse()
                : _controller.forward();
          },
          label: const Text("play"),
        ));
  }
}
