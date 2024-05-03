// Import necessary packages and classes
import 'package:antar_manthan/controller/moodcontroller.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentScreen3 extends StatefulWidget {
  @override
  _AssessmentScreen3State createState() => _AssessmentScreen3State();
}

class _AssessmentScreen3State extends State<AssessmentScreen3> {
  double _sliderValue = 50; // Initial slider value
  String _emoji = '😐'; // Initial emoji
  String _moodText = 'I Feel Neutral'; // Initial mood text
  int _selectedOption = 0; // Selected radio button option, 0 by default
  final MoodController moodController = Get.put(MoodController());

  void _storeSelectedOption() async {
    // Store the selected option index value in Firebase Firestore
    try {
      await FirebaseFirestore.instance.collection('mood').add({
        'selectedOption': _selectedOption,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving selected option: $e');
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
                '3 of 4',
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
                    TextSpan(text: 'Are you experiencing any\n'),
                    TextSpan(text: 'physical symptoms of\n'),
                    TextSpan(text: 'distress?'),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Text(
                'Select one answer:',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 15,
                  color: Color(0xff4B3425),
                ),
              ),
              SizedBox(height: 20),
              // Radio buttons wrapped in Containers
              Column(
                children: [
                  _buildOptionContainer(
                    optionText: 'Yes, Very painful',
                    optionValue: 1,
                  ),
                  _buildOptionContainer(
                    optionText: 'Yes, but just a bit',
                    optionValue: 2,
                  ),
                  _buildOptionContainer(
                    optionText: 'No physical pain at all',
                    optionValue: 3,
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.mood4);

                    _storeSelectedOption(); // Handle the continue button press
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionContainer(
      {required String optionText, required int optionValue}) {
    final isSelected = _selectedOption == optionValue;
    final bgColor = isSelected ? Colors.green : Colors.white;

    return GestureDetector(
      onTap: () {
        // Update the selected option in the controller
        moodController.updateSelectedOption(optionValue);
        setState(() {
          _selectedOption = optionValue;
        });
      },
      child: Container(
        width: 300, // Set your desired width
        height: 70, // Set your desired height
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10), // Add border-radius
        ),
        child: RadioListTile(
          title: Text(
            optionText,
            style: TextStyle(
              color: isSelected ? Colors.white : Color(0xff4B3425),
              fontFamily: 'Urbanist', // Set font family
              fontWeight: FontWeight.bold, // Make text bold
            ),
          ),
          value: optionValue,
          groupValue: _selectedOption,
          onChanged: (int? value) {
            moodController.updateSelectedOption(optionValue);
            setState(() {
              _selectedOption = optionValue;
            }); // This is not needed as we handle it in the GestureDetector onTap
          },
        ),
      ),
    );
  }
}
