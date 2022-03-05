import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.red,
            centerTitle: true,
            title: const Text(
              'Home Screen',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Times',
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/welcome.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 10,
                    width: 10,
                  ),
      
                  Image.asset(
                    'assets/images/welcomee.png',
                    fit: BoxFit.cover,
                    scale: 2.0,
                  ),
                  //  Text(
                  //   'Welcome to my app ❤️',
                  //   style: TextStyle(
                  //     fontSize: 18,
                  //     color: Colors.red,
                  //     fontFamily: 'Times New Roman',
                  //   ),
                  // ),
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText(
                        'Welcome to my app ❤️',
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                      WavyAnimatedText(
                        'Follow me at GitHub @josephyaduvanshi .',
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                          fontFamily: 'Times New Roman',
                        ),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    onTap: () {
                      debugPrint("Joseph");
                    },
                  ),
                ],
              ),
            ),
          ),
          drawer: const Drawer(),
        ),
      ),
    );
  }
}
