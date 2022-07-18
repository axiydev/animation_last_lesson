/*
Created by Axmadjon Isaqov on 16:57:04 16.07.2022
© 2022 
*/
///[@axi_dev]
import 'package:animation_last_lesson/page_transition/page_transition_widget.dart';
import 'package:animation_last_lesson/pages/home_page/widgets/custom_container.dart';
import 'package:animation_last_lesson/pages/moon_page/moon_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String path = '/home_page';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController? _animationController;

  late Animation<double?> _fromLeftAnim;
  late Animation<double?> _fromTopAnim;
  late Animation<double?> _fromSecondLeftAnim;
  late Animation<double?> _fromSecondTopAnim;
  late double _width;
  late double _height;
  late bool _isBig;
  Size? size;
  @override
  void initState() {
    //birinchi ishga tushadigan funksiya
    print('init state');

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    //ikkinchi ishga tushadigan funksiya
    print("did change dependency");
    size = MediaQuery.of(context).size;

    _fromLeftAnim = Tween<double?>(begin: 80, end: 220).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.ease));
    _fromTopAnim = Tween<double?>(begin: 250, end: 100).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.ease));
    _fromSecondLeftAnim = Tween<double?>(begin: 220, end: 80).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.ease));
    _fromSecondTopAnim = Tween<double?>(begin: 100, end: 250).animate(
        CurvedAnimation(parent: _animationController!, curve: Curves.ease));
    _width = 100;
    _height = 100;
    _isBig = false;
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    print('did update widget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    //widgetdan chiqib ketganimizda ishga tushadigan funksiya

    //animation controllerni dispose qildik
    _animationController!.dispose();
    print("dispose");
    super.dispose();
  }

  void _changeSizeContainer() {
    _height = _isBig ? 100 : 200;
    _width = _isBig ? 100 : 200;
    _isBig = !_isBig;
    setState(() {});
  }

  _navigateOtherPage() {
    Navigator.of(context).push(CustomPageRouteBuilder(child: const MoonPage()));
  }

  void _changePosition() {
    _isBig = !_isBig;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        bottomOpacity: 0.0,
        title: const Text("home page"),
      ),
      body: _body,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'float',
            onPressed: () {
              _animationController!.repeat(reverse: true);
            },
            child: const Icon(Icons.play_arrow),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            heroTag: 'float1',
            onPressed: _navigateOtherPage,
            child: const Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

  Widget get _body {
    return Builder(builder: (context) {
      return SizedBox(
          width: size!.width,
          height: size!.height,
          child: Stack(
            children: [
              //birichi container
              AnimatedBuilder(
                  animation: _fromLeftAnim,
                  builder: (context, child) {
                    return _animatedPosition(
                        top: 100, left: _fromLeftAnim.value!);
                  }),
              //ikkinchi kontainer
              AnimatedBuilder(
                  animation: _fromTopAnim,
                  builder: (context, child) {
                    return _animatedPosition(
                        top: _fromTopAnim.value!, left: 80);
                  }),
              //uchinchi container
              AnimatedBuilder(
                  animation: _fromSecondTopAnim,
                  builder: (context, child) {
                    return _animatedPosition(
                        top: _fromSecondTopAnim.value!, left: 220);
                  }),
              //tortinchi kontainer
              AnimatedBuilder(
                  animation: _fromSecondLeftAnim,
                  builder: (context, child) {
                    return _animatedPosition(
                        top: 250, left: _fromSecondLeftAnim.value!);
                  }),
            ],
          ));
    });
  }

  Widget _animatedPosition({required double top, required double left}) {
    return Positioned(
        top: top,
        left: left,
        child: CustomContainer(height: _height, width: _width, isBig: _isBig));
  }
}
