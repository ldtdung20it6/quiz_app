import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/page/quiz_page.dart';
import 'package:quiz_app/page/result_view.dart';

class ResultPage extends StatelessWidget {
  final point;
  final pointLength;
  final second;
  ResultPage({
    super.key,
    required this.point,
    required this.second,
    required this.pointLength,
  });

  static const String PLAY_AGAIN = 'play_again';
  static const String VIEW_RESULT = 'view_result';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252c4a),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () {
                  Get.to(() => const HomePage());
                },
                icon: const Icon(Icons.close),
                color: Colors.white,
                iconSize: 36),
          ),
          Container(
              width: Get.width * 0.9,
              height: Get.height * 0.4,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(14)),
              child: renderViewScore()),
        ],
      )),
    );
  }

  Widget renderButtonType(TYPE, TEXT) {
    return Container(
        width: Get.width * 0.3,
        height: Get.height * 0.06,
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(48)),
        child: TYPE == PLAY_AGAIN
            ? GestureDetector(
                onTap: () => Get.to(() => const QuizPage()),
                child: Center(
                    child: Text(
                  TEXT,
                  style: const TextStyle(color: Colors.white),
                )),
              )
            : GestureDetector(
                onTap: () => Get.to(() => ResultView(
                      pointLength: pointLength,
                    )),
                child: Center(
                    child: Text(
                  TEXT,
                  style: const TextStyle(color: Colors.white),
                )),
              ));
  }

  Widget renderScore() {
    return Text(
        '${point}/${pointLength} correct answers in ${second} seconds!!',
        style: const TextStyle(fontSize: 18));
  }

  Widget renderViewScore() {
    return pointLength / 2 < point
        ? Column(
            children: [
              Image.asset(
                'assets/images/congratulations.png',
                width: Get.width * 0.2,
                height: Get.height * 0.2,
              ),
              const Text(
                'Congratulations!!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'You are amazing!!',
                style: TextStyle(fontSize: 18),
              ),
              renderScore(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  renderButtonType(PLAY_AGAIN, 'Play again'),
                  renderButtonType(VIEW_RESULT, 'View Results')
                ],
              ),
            ],
          )
        : Column(
            children: [
              Image.asset(
                'assets/images/completed.jpg',
                width: Get.width * 0.2,
                height: Get.height * 0.2,
              ),
              const Text(
                'Completed!!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Better luck next time!!',
                style: TextStyle(fontSize: 18),
              ),
              renderScore(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  renderButtonType(PLAY_AGAIN, 'Play again'),
                  renderButtonType(VIEW_RESULT, 'View Results')
                ],
              ),
            ],
          );
  }
}
