import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MoodController extends GetxController {
  double sliderValue1 = 50.0;
  double sliderValue2 = 50.0;
  int selectedOption = 0;
  int selectedNumber = 1;
  String moodEmoji = ''; // Initial emoji

  void updateSliderValue1(double value) {
    sliderValue1 = value;
    update();
  }

  void updateSliderValue2(double value) {
    sliderValue2 = value;
    update();
  }

  void updateSelectedOption(int option) {
    selectedOption = option;
    update();
  }

  void updateSelectedNumber(int number) {
    selectedNumber = number;
    update();
  }

  Future<void> storeDataInFirestore() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore.collection('new').add({
        'sliderValue1': sliderValue1,
        'sliderValue2': sliderValue2,
        'selectedOption': selectedOption,
        'selectedNumber': selectedNumber,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Error saving data to Firestore: $e');
    }
  }

  Future<void> fetchAndDisplayMood() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore
        .collection('new')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final lastDocument = querySnapshot.docs.first;
      final data = lastDocument.data() as Map<String, dynamic>;

      // Print all data fetched from Firestore
      print("Timestamp: ${data['timestamp']}");
      print("Selected Option: ${data['selectedOption']}");
      print("Selected Number: ${data['selectedNumber']}");
      print("Slider Value 1: ${data['sliderValue1']}");
      print("Slider Value 2: ${data['sliderValue2']}");

      // Update the values in the controller
      updateSelectedOption(data['selectedOption']);
      updateSliderValue1(data['sliderValue1']);
      updateSliderValue2(data['sliderValue2']);
      updateSelectedNumber(data['selectedNumber']);

      // Get the categorized mood and update the emoji
    }
  }

  String categorizeMood() {
    if ((sliderValue1 == 0) ||
        (sliderValue2 == 0) ||
        selectedOption == 1 ||
        selectedNumber == 5) {
      return 'Sad';
    } else if ((sliderValue1 == 100) ||
        (sliderValue2 == 100) ||
        selectedOption == 3 ||
        selectedNumber == 1) {
      return 'Happy';
    } else {
      return 'Neutral';
    }
  }
}
