import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RatingController1 extends GetxController {
  // Observable variables to store data
  RxInt selectedOption = 0.obs;
  RxInt selectedNumber = 0.obs;
  RxDouble sliderValue = 50.0.obs;
  RxDouble sliderValue1 = 50.0.obs;
  RxString moodText = ''.obs;
  RxString normalText = 'NORMAL'.obs; // Observable to store the mood text
  RxString emojiText = ''.obs; // Observable to store the emoji text

  // Firebase Firestore reference
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    // Fetch and update mood text when the controller is initialized
    fetchAndProcessMoodData();
  }

  // Fetch and process mood data from Firestore
  Future<void> fetchAndProcessMoodData() async {
    try {
      // Replace 'moody' with your actual Firebase collection name
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('moody')
          .orderBy('timestamp', descending: true)
          // Get only the latest document
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        final selectedNumber = data['selectedNumber'] ?? 0;
                                        
        print("sdfjk hsdfhsdjfhsdfhkjsdhfdskj");
        print("selectedNumber: $selectedNumber");

        // Determine mood text based on the 'selectedNumber' value
        moodText.value = determineMood(selectedNumber);

        // Determine emoji text based on the mood text
        emojiText.value = determineEmoji(moodText.value);
      } else {
        // Handle the case when no documents are found
        moodText.value = 'No data found';
        emojiText.value = '😐'; // Set a default emoji text
      }
    } catch (e) {
      print('Error fetching mood data: $e');
      moodText.value = 'Error';
      emojiText.value = '😐'; // Set a default emoji text in case of an error
    }
  }

  // Determine emoji text based on the mood text
  String determineEmoji(String moodText) {
    switch (moodText) {
      case 'Happy':
        return '😃';
      case 'Sad':
        return '😔';
      default:
        return '😐';
    }
  }

  // Determine mood text based on the 'selectedNumber' value
  String determineMood(int selectedNumber) {
    // Your logic to determine mood text goes here
    // You can use the 'selectedNumber' to calculate the mood
    // and return the appropriate text (e.g., 'Happy', 'Sad', 'Neutral', etc.)
    // Replace this with your actual mood calculation logic

    // Example logic:
    if (selectedNumber > 3) {
      return 'Happy';
    } else if (selectedNumber < 3 && selectedNumber > 0) {
      return 'Sad';
    } else {
      return 'Neutral';
    }
  }
}
