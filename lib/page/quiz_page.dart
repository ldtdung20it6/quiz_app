import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/data/database.dart';
import 'package:quiz_app/data/get_quiz.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/page/result_page.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  var currentQuestionIndex = 0;
  int seconds = 1;
  int id = 0;
  Timer? timer;
  late Future quiz;

  int points = 0;

  var isLoaded = false;

  var optionsList = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  @override
  void initState() {
    super.initState();
    DBHelper().delete();
    DBHelper();
    quiz = getQuiz().get();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds++;
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF252c4a),
      body: SafeArea(
          child: FutureBuilder(
        future: quiz,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data["results"];
            if (isLoaded == false) {
              optionsList = data[currentQuestionIndex]["incorrect_answers"];
              optionsList.add(data[currentQuestionIndex]["correct_answer"]);
              optionsList.shuffle();
              isLoaded = true;
            }
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
                    "Question ${currentQuestionIndex + 1} / ${data.length}",
                    style: const TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: Get.width * 0.8,
                      child: Text(
                          data[currentQuestionIndex]["question"].toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20))),
                  SizedBox(height: Get.height * 0.1),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: optionsList.length,
                      itemBuilder: (BuildContext context, int index) {
                        var answer =
                            data[currentQuestionIndex]["correct_answer"];
                        return GestureDetector(
                          onTap: () {
                            id = id +1;
                            setState(() {
                              if (answer.toString() ==
                                  optionsList[index].toString()) {
                                optionsColor[index] = Colors.green;
                                points = points + 1;
                                
                                Quiz quiz = Quiz(currentQuestionIndex,currentQuestionIndex.toString(), data[currentQuestionIndex]["question"], data[currentQuestionIndex]["correct_answer"]);
                                DBHelper().save(quiz);
                              } else {
                                optionsColor[index] = Colors.red;

                                Quiz quiz = Quiz(currentQuestionIndex,currentQuestionIndex.toString(), data[currentQuestionIndex]["question"], data[currentQuestionIndex]["correct_answer"]);
                                DBHelper().save(quiz);
                              }
                              if (currentQuestionIndex < data.length - 1) {
                                Future.delayed(const Duration(milliseconds: 500), () {
                                  gotoNextQuestion();
                                });
                              } else {
                                timer!.cancel();
                                Get.to(() => ResultPage(point: points,second: seconds,pointLength: data.length));
                              }
                            });
                          },
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              alignment: Alignment.center,
                              width: Get.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(48),
                              ),
                              child: Text(optionsList[index].toString())),
                        );
                      })
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      )),
    );
  }
}
