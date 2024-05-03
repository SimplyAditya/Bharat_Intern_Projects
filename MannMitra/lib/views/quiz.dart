import 'dart:convert';

import 'package:antar_manthan/controller/quizController.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Question {
  final int id;
  final String question;
  final List<Option> options;

  Question({
    required this.id,
    required this.question,
    required this.options,
  });
}

class Option {
  final String text;
  final int rating;

  Option({
    required this.text,
    required this.rating,
  });
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  PageController _pageController = PageController();
  final QuizController quizController = Get.put(QuizController());
  String btnText = 'Next';

  List<Question> _questions = [];
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    loadQuestions().then((questions) {
      setState(() {
        _questions = questions;
        print("Number of questions loaded: ${_questions.length}");
      });
    });
  }

  Future<List<Question>> loadQuestions() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString('assets/questions.json');
    List<dynamic> jsonList = json.decode(data);

    List<Question> questions = [];
    for (var questionJson in jsonList) {
      List<Option> options = [];
      for (var optionJson in questionJson['options']) {
        options.add(Option(
          text: optionJson['text'],
          rating: optionJson['rating'],
        ));
      }

      questions.add(Question(
        id: questionJson['id'],
        question: questionJson['question'],
        options: options,
      ));
    }

    return questions;
  }

  void _nextQuestion() {
    if (_currentPage < _questions.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    } else {
      // User has completed the quiz, store ratings in Firestore
      quizController.storeRatingsInFirestore(_questions);

      // Handle navigation to another page here (replace '/result' with your desired route)
      Get.toNamed(RouteName.mood);
    }

    // Update the button text
    setState(() {
      btnText = _currentPage < _questions.length - 1 ? 'Next' : 'Finish';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/quizbg.png',
            ),
            fit: BoxFit.cover,
            scale: 1.5,
          ),
        ),
        child: PageView.builder(
          controller: _pageController, // Attach the _pageController
          itemCount: _questions.length,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                        ),
                        IconButton(
                          onPressed: () {
                            Get.back(); // Go back to the previous screen
                          },
                          icon: Icon(
                            Icons.arrow_back, // Use the back arrow icon
                            color: Color(0xFF4b3425), // Set the color to 4b3425
                          ),
                        ),
                        Text(
                          "Question ${_currentPage + 1} of ${_questions.length}",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4b3425),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _questions[_currentPage].question,
                      style: GoogleFonts.urbanist(
                        textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4b3425),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: _questions[_currentPage]
                        .options
                        .asMap()
                        .entries
                        .map((entry) {
                      int optionIndex = entry.key;
                      Option option = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              quizController.selectOption(
                                _currentPage,
                                optionIndex,
                              );
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (states) {
                                if (states.contains(MaterialState.pressed) ||
                                    quizController.isOptionSelected(
                                      _currentPage,
                                      optionIndex,
                                    )) {
                                  return Color(
                                      0xFF4b3425); // Pressed or selected color
                                }
                                return Colors.white; // Default color
                              },
                            ),
                          ),
                          child: Text(
                            option.text,
                            style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: quizController.isOptionSelected(
                                        _currentPage, optionIndex)
                                    ? Colors
                                        .white // Change text color to white when selected
                                    : Color(0xFF4b3425), // Default text color
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (btnText == 'Finish') {
                        // Handle navigation to another page here (replace '/result' with your desired route)
                        Get.toNamed(RouteName.mood);
                      } else {
                        _nextQuestion();
                      }
                    },
                    child: Text(btnText),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
