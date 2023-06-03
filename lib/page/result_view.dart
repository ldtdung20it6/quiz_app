import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/data/database.dart';
import 'package:quiz_app/models/quiz.dart';

class ResultView extends StatefulWidget {
  final pointLength;
  const ResultView({super.key, required this.pointLength});

  @override
  State<ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  var currentQuestionIndex = 0;

  gotoNextQuestion() {
    currentQuestionIndex++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF252c4a),
        body: SafeArea(
            child: FutureBuilder<List<Quiz>>(
                future: DBHelper().getQuiz(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                      'Error: ${snapshot.error}',
                      style: const TextStyle(color: Colors.white),
                    ));
                  } else {
                    Quiz quiz = snapshot.data![currentQuestionIndex];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: const Icon(Icons.close),
                                color: Colors.white,
                                iconSize: 36),
                          ),
                          Text(
                            "Question ${currentQuestionIndex + 1} / ${widget.pointLength}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 24),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                              width: Get.width * 0.8,
                              child: Text(quiz.question.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20))),
                          SizedBox(height: Get.height * 0.1),
                          const Text(
                            'Correct Answer:',
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(height: 10),
                          Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: Get.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(48),
                              ),
                              child: Text(quiz.correct_answer.toString())),
                          GestureDetector(
                            onTap: () {
                              currentQuestionIndex < widget.pointLength - 1
                                  ? setState(() {
                                      gotoNextQuestion();
                                    })
                                  : setState(() {
                                      Get.back();
                                    });
                            },
                            child: Container(
                                margin: const EdgeInsets.only(bottom: 20),
                                alignment: Alignment.center,
                                width: Get.width - 100,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(48),
                                ),
                                child: currentQuestionIndex <
                                        widget.pointLength - 1
                                    ? const Text('Next')
                                    : const Text('Cancel')),
                          ),
                        ],
                      ),
                    );
                  }
                })));
  }
}
