/*
Created by Axmadjon Isaqov on 21:08:40 18.07.2022
© 2022 @axi_dev 
*/
import 'package:animation_last_lesson/page_transition/page_transition_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/moon_page.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/moon_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/sun_widget.dart';
import 'package:animation_last_lesson/pages/moon_page_three/moon_page_three.dart';
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
        .push(CustomPageRouteBuilder(child: const MoonPageThree()));
  }

  _navigatePreviusOtherPage() {
    Navigator.of(context).push(CustomPageRouteBuilder(child: const MoonPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: const Text("moon page two"),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedCrossFade(
            crossFadeState: _isNight!
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstCurve: Curves.linear,
            secondCurve: Curves.linear,
            firstChild: Container(
              key: const ValueKey<String>('first'),
              height: _size!.height,
              width: _size!.width,
              color: Colors.black,
            ),
            secondChild: Container(
              key: const ValueKey<String>('second'),
              height: _size!.height,
              width: _size!.width,
              color: Colors.white,
            ),
            duration: const Duration(milliseconds: 400),
            reverseDuration: const Duration(milliseconds: 400),
          ),
          Stack(
            fit: StackFit.expand,
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
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'float9899',
            onPressed: _navigatePreviusOtherPage,
            child: const Icon(Icons.arrow_back_ios),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'float35',
            onPressed: () {
              _controller.status == AnimationStatus.completed
                  ? _controller.reverse()
                  : _controller.forward();

              // Navigator.of(context).pushNamed(MoonPageThree.path);
            },
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'float146',
            onPressed: _navigateToPage,
            child: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }
}
