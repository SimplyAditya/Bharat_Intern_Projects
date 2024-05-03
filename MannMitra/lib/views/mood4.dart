// Import necessary packages and classes
import 'package:antar_manthan/controller/moodcontroller.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssessmentScreen4 extends StatefulWidget {
  @override
  _AssessmentScreen4State createState() => _AssessmentScreen4State();
}

class _AssessmentScreen4State extends State<AssessmentScreen4> {
  int _selectedNumber = 1; // Initial selected number
  final MoodController moodController = Get.put(MoodController());
  String _description =
      "You are feeling very calm and relaxed."; // Initial description

  void _updateDescription(int number) {
    switch (number) {
      case 1:
        _description = "You are feeling very calm and relaxed.";
        break;
      case 2:
        _description = "You are moderately relaxed with slight tension.";
        break;
      case 3:
        _description = "You are moderately stressed.";
        break;
      case 4:
        _description = "You are highly stressed with significant tension.";
        break;
      case 5:
        _description = "You are extremely stressed.";
        break;
      default:
        _description = "";
        break;
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
                '4 of 4',
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
                    TextSpan(text: 'your stress level'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Select one answer:',
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 15,
                  color: Color(0xff4B3425),
                ),
              ),
              SizedBox(height: 20),
              // Display selected number with large font size
              Text(
                '$_selectedNumber',
                style: TextStyle(
                  fontSize: 80, // Large font size
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist',
                  color: Color(0xff4B3425),
                ),
              ),
              SizedBox(height: 20),
              // Horizontal list of numbers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, (index) {
                  final number = index + 1;
                  final isSelected = number == _selectedNumber;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedNumber = number;
                        _updateDescription(number); // Update the description
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.green : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        number.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Urbanist',
                          fontWeight: FontWeight.bold,
                          color: isSelected ? Colors.white : Color(0xff4B3425),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20),
              // Display description based on the selected number
              Text(
                _description,
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontSize: 16,
                  color: Color(0xff4B3425),
                ),
              ),
              SizedBox(height: 40),
              // Continue button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(RouteName.result);
                    moodController.updateSelectedNumber(_selectedNumber);

                    moodController.storeDataInFirestore();

                    moodController
                        .fetchAndDisplayMood(); // Handle the continue button press
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
                        'Submit',
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
}
