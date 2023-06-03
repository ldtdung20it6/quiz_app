import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:quiz_app/page/quiz_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Get.close(exit(0));
                    },
                    icon: const Icon(Icons.logout),
                    color: Colors.orange,
                    iconSize: 36),
              ),
              Column(
                children: [
                  SvgPicture.asset('assets/images/logo.svg'),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: Get.width * 0.3,
                    height: Get.height * 0.06,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(48)),
                    child: GestureDetector(
                      onTap: () => Get.to(() => const QuizPage()),
                      child: const Center(
                          child: Text(
                        'Start Quiz',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
              Text('')
            ],
          ),
        ),
      ),
    );
  }
}
