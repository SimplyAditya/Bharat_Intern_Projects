import 'package:antar_manthan/controller/authconroller.dart';
import 'package:antar_manthan/controller/quizController.dart';
import 'package:antar_manthan/controller/ratingcontroller1.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthController authController = Get.put(AuthController());
  final RatingController1 ratingController = Get.put(RatingController1());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          Card(
            elevation: 0.0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/avatar.jpg'),
                        radius: 40.0,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      Column(
                        children: [
                          Text(
                            'Hi, Bateman!',
                            style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF4b3425),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.health_and_safety_outlined,
                                size: 30.0,
                                color: Colors.purple,
                              ),
                              Text(
                                "80%",
                                style: GoogleFonts.urbanist(
                                  textStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF4b3425),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.0),
                              Icon(
                                Icons.emoji_emotions,
                                size: 30.0,
                                color: Colors.green,
                              ),
                              SizedBox(width: 5.0),
                              Text(
                                "Happy",
                                style: GoogleFonts.urbanist(
                                  textStyle: TextStyle(
                                    fontSize: 15.0,
                                    color: Color(0xFF4b3425),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Text(
              "Mann Mitra Metrics",
              style: GoogleFonts.urbanist(
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Color(0xFF4b3425),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 150,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [Color(0xFFF15A29), Color(0xFFFFA07A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.white,
                        size: 30.0,
                      ),
                      title: Transform.translate(
                        offset: Offset(-10, 10),
                        child: Text(
                          "Mood Score",
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      onTap: () {
                        Get.toNamed(RouteName.mood1);
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5.0),
                          Row(
                            children: [
                              Text(
                                "How are you feeling?",
                                style: GoogleFonts.urbanist(
                                    textStyle: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 61, 61, 61),
                                )),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Color.fromARGB(255, 61, 61, 61),
                                size: 24.0,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 217, 145, 236),
                      Color.fromARGB(255, 140, 83, 156)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons
                            .assessment_outlined, // Replace with your smiley icon
                        color: Colors.white,
                        size: 40.0, // Adjust the size as needed
                      ),
                      title: Text(
                        "GHA (General Health Assesment)",
                        style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                      onTap: () {
                        Get.toNamed(RouteName.start);
                      },
                    ),
                    Positioned(
                      bottom: 10, // Adjust the position as needed
                      right: 10, // Adjust the position as needed
                      child: Row(
                        children: [
                          Text(
                            "Assess Now",
                            style: GoogleFonts.urbanist(
                                textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 61, 61, 61),
                            )),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Color.fromARGB(255, 61, 61, 61),
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF9bb068),
                      Color.fromARGB(255, 224, 255, 153),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.article, // Replace with your smiley icon
                        color: Colors.white,
                        size: 40.0, // Adjust the size as needed
                      ),
                      title: Text(
                        "Mindful Insights",
                        style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                      onTap: () {
                        Get.toNamed(RouteName.article); // Handle card tap
                      },
                    ),
                    Positioned(
                      bottom: 10, // Adjust the position as needed
                      right: 10, // Adjust the position as needed
                      child: Row(
                        children: [
                          Text(
                            "Way to a Healthier Mind ",
                            style: GoogleFonts.urbanist(
                                textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 61, 61, 61),
                            )),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Color.fromARGB(255, 61, 61, 61),
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF4b3425),
                      Color.fromARGB(255, 245, 191, 155),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.person, // Replace with your smiley icon
                        color: Colors.white,
                        size: 40.0, // Adjust the size as needed
                      ),
                      title: Text(
                        "Mann Mitra AI assistant",
                        style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                      ),
                      onTap: () {
                        Get.toNamed(RouteName.chat); // Handle card tap
                      },
                    ),
                    Positioned(
                      bottom: 10, // Adjust the position as needed
                      right: 10, // Adjust the position as needed
                      child: Row(
                        children: [
                          Text(
                            "Way to a Healthier Mind ",
                            style: GoogleFonts.urbanist(
                                textStyle: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 61, 61, 61),
                            )),
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Color.fromARGB(255, 61, 61, 61),
                            size: 24.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mood),
            label: 'Mood',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'AI',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          switch (index) {
            case 0:
              Get.toNamed(
                  RouteName.homeScreen); // Navigate to the '/home' route
              break;
            case 1:
              Get.toNamed(RouteName.mood1); // Navigate to the '/mood' route
              break;
            case 2:
              Get.toNamed(RouteName.chat); // Navigate to the '/ai' route
              break;
          }
        },
      ),
    );
  }
}
