import 'package:animation_last_lesson/pages/moon_page/widget/moon_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/sun_widget.dart';
import 'package:flutter/material.dart';

class MoonPage extends StatefulWidget {
  static const String path = '/moon';
  const MoonPage({super.key});

  @override
  State<MoonPage> createState() => _MoonPageState();
}

class _MoonPageState extends State<MoonPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Size? _size;
  late bool? _isNight;

  @override
  void didChangeDependencies() {
    _size = MediaQuery.of(context).size;
    _isNight = true;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
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
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 450),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.ease,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: child,
            ),
            child: _isNight! ? const MoonWidget() : const SunWidget(),
          ),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _changeDay,
          label: const Text("play"),
        ));
  }
}
