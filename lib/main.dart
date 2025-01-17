import 'package:flutter/material.dart';
import 'package:news_app/screen_Widgets/homepage_widget.dart';
import 'package:news_app/screen_Widgets/splashpage_widget.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  MaterialApp build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Kanit_Regular",
      ),
      initialRoute: "/SplashScreen",
      routes: {
        "/SplashScreen": (context) => const SplashScreen(),
        "/HomeScreen": (context) => const HomePage(),
      },
    );
  }
}
