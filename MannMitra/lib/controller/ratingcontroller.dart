import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RatingController extends GetxController {
  RxInt totalRatings = RxInt(0); // Use RxInt for reactive updates
  RxString normalText = RxString("NORMAL"); // Add RxString for "NORMAL" text

  @override
  void onInit() {
    super.onInit();
    // Fetch ratings when the controller is initialized
    fetchRatingsFromFirestore();
  }

  

  Future<void> fetchRatingsFromFirestore() async {
    try {
      final firestore = FirebaseFirestore.instance;
      final ratingsCollection = firestore.collection('ratings');

      // Query the 'ratings' collection to get documents sorted by timestamp in descending order
      final querySnapshot =
          await ratingsCollection.orderBy('timestamp', descending: true).get();

      // Check if there are any documents in the query result
      if (querySnapshot.docs.isNotEmpty) {
        final latestDocument =
            querySnapshot.docs.first; // Get the latest document
        final data = latestDocument.data() as Map<String, dynamic>;
        final ratings = data['ratings'] as List<dynamic>;

        // Initialize the totalRatings variable
        int sum = 0;

        // Iterate through the ratings array and calculate the sum
        for (final ratingData in ratings) {
          final rating = ratingData['rating'] as int;
          print("jfdjsdfkdskjfdsf");
          print(rating);
          sum += rating;
        }
        print("jfdjsdfkdskjfdsf");
        print(sum);
        // Update the totalRatings variable with the sum of ratings from the latest document
        totalRatings.value = sum;

        // Update the normalText based on the totalRatings value
        updateNormalText(sum);
      } else {
        // No documents found, set totalRatings to 0 or any default value
        totalRatings.value = 0;
        // Set normalText to "NORMAL" by default
        normalText.value = "NORMAL";
      }
    } catch (error) {
      print('Error fetching ratings: $error');
    }
  }

  // Function to update normalText based on the totalRatings value
  void updateNormalText(int totalRatings) {
    if (totalRatings >= 0 && totalRatings <= 5) {
      normalText.value = "Not Depressed";
    } else if (totalRatings >= 6 && totalRatings <= 10) {
      normalText.value = "Mild Depression";
    } else if (totalRatings >= 11 && totalRatings <= 20) {
      normalText.value = "Moderate Depression";
    } else if (totalRatings >= 21 && totalRatings <= 30) {
      normalText.value = "Severe Depression";
    } else if (totalRatings >= 31 && totalRatings <= 36) {
      normalText.value = "Very Depressed";
    } else {
      normalText.value = "NORMAL"; // Default value
    }
  }
}
