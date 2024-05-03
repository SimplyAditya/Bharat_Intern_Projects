import 'package:antar_manthan/controller/moodcontroller.dart';
import 'package:antar_manthan/controller/ratingcontroller.dart';
import 'package:antar_manthan/controller/ratingcontroller1.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:antar_manthan/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodScreenResult extends StatefulWidget {
  @override
  State<MoodScreenResult> createState() => _MoodScreenResultState();
}

class _MoodScreenResultState extends State<MoodScreenResult> {
  final List<int> tileProgressValues = [60, 80, 40, 90, 20];
  final MoodController moodController = Get.put(MoodController());

  String moodText = 'Loading...'; // Initial mood text

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String mood = moodController.categorizeMood();
    String emoji(String mood) {
      if (mood == "Happy") {
        return "😀";
      } else if (mood == "Sad") {
        return "😔";
      } else {
        return "😐";
      }
    }

    return WillPopScope(
      onWillPop: () async {
        Get.offNamed(RouteName.homeScreen);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff9BB068),
          elevation: 0, // Remove elevation
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(
            'Mood Score',
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xffCFD9B5),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              child: CurvedClipPathWithBackButton(moodText: moodText),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                emoji(mood),
                style: TextStyle(
                  fontSize: 100.0,
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4B3425), // Change the text color as needed
                ),
              ),
            ),
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
      ),
    );
  }
}

class CurvedClipPathWithBackButton extends StatelessWidget {
  final String moodText;
  final MoodController moodController = Get.put(MoodController());
  CurvedClipPathWithBackButton({required this.moodText});

  @override
  Widget build(BuildContext context) {
    // Use 0 as the default rating

    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  ' You are feeling ${moodController.categorizeMood()}!',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B3425),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        )),
                        children: [
                          TextSpan(text: ""),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double w = size.width;
    double h = size.height;
    final path = Path();
    path.lineTo(0, h);
    path.quadraticBezierTo(
      w * 0.5, // 3. Point
      h - 100, // 3. Point
      w,
      h, // 4. Point
    );
    path.lineTo(w, 0); // 5. Point
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
