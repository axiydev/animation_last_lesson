/*
Created by Axmadjon Isaqov on 21:08:22 18.07.2022
© 2022 @axi_dev 
*/
import 'package:animation_last_lesson/page_transition/page_transition_widget.dart';
import 'package:animation_last_lesson/pages/home_page/home_page.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/moon_widget.dart';
import 'package:animation_last_lesson/pages/moon_page/widget/sun_widget.dart';
import 'package:animation_last_lesson/pages/moon_page_two/moon_page_two.dart';
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

  void _navigateToPage() {
    Navigator.of(context)
        .push(CustomPageRouteBuilder(child: const MoonPageTwo()));
  }

  get _changeDay {
    _isNight = !_isNight!;
    setState(() {});
  }

  _navigatePreviusOtherPage() {
    Navigator.of(context).push(CustomPageRouteBuilder(child: const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          bottomOpacity: 0.0,
          title: const Text("moon page"),
        ),
        body: AnimatedContainer(
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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'float989',
              onPressed: _navigatePreviusOtherPage,
              child: const Icon(Icons.arrow_back_ios),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 'float3',
              onPressed: () => _changeDay,
              child: const Icon(Icons.play_arrow),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 'float14',
              onPressed: _navigateToPage,
              child: const Icon(Icons.arrow_forward_ios),
            )
          ],
        ));
  }
}
