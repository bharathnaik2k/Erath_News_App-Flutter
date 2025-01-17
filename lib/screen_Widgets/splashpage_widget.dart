import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  void naviFun(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1800), () {
      Navigator.of(context).pushReplacementNamed("/HomeScreen");
    });
  }

  @override
  Scaffold build(BuildContext context) {
    naviFun(context);
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 74, 94, 0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.newspaper,
              size: 75,
              color: Colors.white,
            ),
            Text(
              "Erath News",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            )
          ],
        ),
      ),
    );
  }
}
