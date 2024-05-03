import 'package:antar_manthan/routes/routeNames.dart';
import 'package:antar_manthan/views/FifthScreen.dart';
import 'package:antar_manthan/views/FourthScreen.dart';
import 'package:antar_manthan/views/SecondScreen.dart';
import 'package:antar_manthan/views/ThirdScreen.dart';
import 'package:antar_manthan/views/article.dart';
import 'package:antar_manthan/views/article2.dart';
import 'package:antar_manthan/views/assistant.dart';
import 'package:antar_manthan/views/firstScreen.dart';
import 'package:antar_manthan/views/home.dart';
import 'package:antar_manthan/views/login_screen.dart';
import 'package:antar_manthan/views/mood1.dart';
import 'package:antar_manthan/views/mood2.dart';
import 'package:antar_manthan/views/mood3.dart';
import 'package:antar_manthan/views/mood4.dart';
import 'package:antar_manthan/views/result.dart';
import 'package:antar_manthan/views/Quizstart.dart';
import 'package:antar_manthan/views/quiz.dart';
import 'package:antar_manthan/views/result1.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AppRoutes {
  static appRoutes() => [
        GetPage(
          name: RouteName.homeScreen,
          page: () => HomeScreen(),
        ),
        GetPage(
          name: RouteName.mood,
          page: () => MoodScreen(),
        ),
        GetPage(
          name: RouteName.loginScreen,
          page: () => SignUp(),
        ),
        GetPage(
          name: RouteName.start,
          page: () => StartScreen(),
        ),
        GetPage(
          name: RouteName.quiz,
          page: () => QuizScreen(),
        ),
        GetPage(
          name: RouteName.mood1,
          page: () => AssessmentScreen(),
        ),
        GetPage(
          name: RouteName.mood2,
          page: () => AssessmentScreen1(),
        ),
        GetPage(
          name: RouteName.mood3,
          page: () => AssessmentScreen3(),
        ),
        GetPage(
          name: RouteName.mood4,
          page: () => AssessmentScreen4(),
        ),
        GetPage(
          name: RouteName.result,
          page: () => MoodScreenResult(),
        ),
        GetPage(
          name: RouteName.article,
          page: () => CustomAppBarPage(),
        ),
        GetPage(
          name: RouteName.article1,
          page: () => MyApp(),
        ),
        GetPage(
          name: RouteName.first,
          page: () => HomePageWidget(),
        ),
        GetPage(
          name: RouteName.second,
          page: () => SecondScreen(),
        ),
        GetPage(
          name: RouteName.third,
          page: () => ThirdScreen(),
        ),
        GetPage(
          name: RouteName.forth,
          page: () => FourthScreen(),
        ),
        GetPage(
          name: RouteName.fifth,
          page: () => FifthScreen(),
        ),
         GetPage(
          name: RouteName.chat,
          page: () => ChatScreen(),
        ),
      ];
}
