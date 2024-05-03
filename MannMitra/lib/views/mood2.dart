import 'package:antar_manthan/controller/moodcontroller.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentScreen1 extends StatefulWidget {
  @override
  _AssessmentScreen1State createState() => _AssessmentScreen1State();
}

class _AssessmentScreen1State extends State<AssessmentScreen1> {
  double _sliderValue = 50; // Initial slider value
  String _emoji = '😐'; // Initial emoji
  String _moodText = 'I Feel Neutral'; // Initial mood text
  final MoodController moodController = Get.put(MoodController());

  void _updateEmojiAndMood(double value) {
    // Update the emoji and mood text based on the slider value
    if (value <= 33.3) {
      _emoji = '😞'; // Sad emoji
      _moodText = 'Poor';
    } else if (value <= 66.6) {
      _emoji = '😐'; // Neutral emoji
      _moodText = 'Good';
    } else {
      _emoji = '😊'; // Happy emoji
      _moodText = 'Excellent';
    }
    setState(() {});
  }

  void _storeSliderValue(double value) async {
    // Store the slider value in Firebase Firestore
    moodController.updateSliderValue2(value);
    try {
      await FirebaseFirestore.instance.collection('mood').add({
        'sliderValue1': value,
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
        backgroundColor: Color(0xfff8e4dc),
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
                '2 of 4',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Urbanist',
                  color: Color(0xffe8ae97),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        color: Color(0xfffde6de),
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Urbanist',
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B3425),
                  ),
                  children: [
                    TextSpan(text: 'How would you rate\n'),
                    TextSpan(text: 'your sleep quality?'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Vertical Slider with Text and Emojis
              Container(
                height: 400, // Adjust the height as needed
                child: SliderTheme(
                  data: SliderThemeData(
                    activeTrackColor:
                        Colors.brown, // Brown color for active track
                    thumbColor: Colors.brown, // Brown color for thumb
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 20.0,
                    ),
                  ),
                  child: RotatedBox(
                    quarterTurns: -1, // Rotate the slider vertically
                    child: Slider(
                      value: _sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                          _updateEmojiAndMood(value);
                        });
                      },
                      min: 0,
                      max: 100,
                      divisions: 2, // 3 stages (Poor, Good, Excellent)
                      label: _moodText,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Poor',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B3425))),
                  Text('   Good',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B3425))),
                  Text('Excellent',
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B3425))),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('😞', style: TextStyle(fontSize: 30)),
                  Text('😐', style: TextStyle(fontSize: 30)),
                  Text('😊', style: TextStyle(fontSize: 30)),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.mood3);
                    _storeSliderValue(
                        _sliderValue); // Handle the continue button press
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
                      SizedBox(width: 10), // Add spacing between text and icon
                      Icon(
                        Icons.arrow_forward,
                        size: 24,
                      ), // Arrow forward icon
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
