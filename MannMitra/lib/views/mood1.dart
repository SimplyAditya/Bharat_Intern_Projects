import 'package:antar_manthan/controller/moodcontroller.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssessmentScreen extends StatefulWidget {
  @override
  _AssessmentScreenState createState() => _AssessmentScreenState();
}

class _AssessmentScreenState extends State<AssessmentScreen> {
  double _sliderValue = 50; // Initial slider value
  String _emoji = '😐'; // Initial emoji
  String _moodText = 'I Feel Neutral'; // Initial mood text
  final MoodController moodController = Get.put(MoodController());

  void _updateEmojiAndMood(double value) {
    // Update the emoji and mood text based on the slider value
    if (value <= 25) {
      _emoji = '😞'; // Sad emoji
      _moodText = 'I Feel Sad';
    } else if (value <= 50) {
      _emoji = '😐'; // Neutral emoji
      _moodText = 'I Feel Neutral';
    } else {
      _emoji = '😊'; // Happy emoji
      _moodText = 'I Feel Happy';
    }
  }

  void _storeSliderValue(double value) async {
    // Store the slider value in Firebase Firestore
    moodController.updateSliderValue1(value);
    try {
      await FirebaseFirestore.instance.collection('mood').add({
        'sliderValue': value,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving slider value: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Color(0xfff8e4dc), // Make the app bar background transparent
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff4B3425),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Assessment',
          style: TextStyle(
            color: Color(0xff4B3425),
            fontFamily: 'Urbanist',
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Color(0xfff8e4dc),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                '1 of 4',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Urbanist',
                  color: Color(0xffe8ae97), // Transparent text color
                ),
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background Image
          Opacity(
            opacity: 0.5, // Adjust the opacity as needed
            child: Image.asset(
              'assets/images/1.jpeg', // Replace with your image path
              fit: BoxFit.cover, // Adjust the fit as needed
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Content

          Transform.translate(
            offset: Offset(0, 160),
            child: Container(
              color:
                  Colors.transparent, // Make the content background transparent
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 30.0,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B3425),
                        ),
                        children: [
                          TextSpan(text: 'How would you describe\n'),
                          TextSpan(text: 'your mood?'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _moodText,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4B3425),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _emoji,
                    style: TextStyle(fontSize: 60),
                  ),
                  SizedBox(height: 20),
                  Slider(
                    value: _sliderValue,
                    onChanged: (value) {
                      setState(() {
                        _sliderValue = value;
                        _updateEmojiAndMood(value);
                      });
                    },
                    min: 0,
                    max: 100,
                    divisions: 2,
                    activeColor:
                        Colors.brown, // Change the slider color to brown
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        _storeSliderValue(_sliderValue);
                        Get.toNamed(RouteName
                            .mood2); // Handle the continue button press
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.brown, // Button background color
                        onPrimary: Colors.white, // Text color
                        padding: EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 20, // Adjust the width as needed
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          SizedBox(
                              width: 10), // Add spacing between text and icon
                          Icon(
                            Icons.arrow_forward,
                            size: 24,
                          ), // Arrow forward icon
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
