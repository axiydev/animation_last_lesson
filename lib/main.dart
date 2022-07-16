import 'package:animation_last_lesson/pages/home_page/home_page.dart';
import 'package:animation_last_lesson/pages/moon_page/moon_page.dart';
import 'package:animation_last_lesson/pages/moon_page_two/moon_page_two.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  //database
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        HomePage.path: (context) => const HomePage(),
        MoonPage.path: (context) => const MoonPage(),
        MoonPageTwo.path: (context) => const MoonPageTwo()
      },
      initialRoute: MoonPageTwo.path,
    );
  }
}
