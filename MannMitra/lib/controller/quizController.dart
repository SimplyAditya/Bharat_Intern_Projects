import 'package:antar_manthan/views/quiz.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuizController extends GetxController {
  List<RxInt> selectedOptionIndices = [];

  @override
  void onInit() {
    super.onInit();
    selectedOptionIndices = List.generate(
      12, 
      (_) => RxInt(-1),
    );
  }

  Future<void> storeRatingsInFirestore(List<Question> _questions) async {
    try {
      final firestore = FirebaseFirestore.instance;

      List<Map<String, dynamic>> ratingData = [];

      for (int i = 0; i < selectedOptionIndices.length; i++) {
        if (selectedOptionIndices[i].value != -1) {
          final questionIndex = i;
          final optionIndex = selectedOptionIndices[i].value;

          final rating = _questions[questionIndex]
              .options[optionIndex]
              .rating;

          ratingData.add({
            'questionIndex': questionIndex,
            'optionIndex': optionIndex,
            'rating': rating,
          });
        }
      }

      await firestore.collection('ratings').add({
        'ratings': ratingData,
        'timestamp': FieldValue.serverTimestamp(),
      });

      selectedOptionIndices.forEach((index) {
        index.value = -1;
      });
    } catch (error) {
      print('Error storing ratings: $error');
    }
  }

  void selectOption(int questionIndex, int optionIndex) {
    selectedOptionIndices[questionIndex].value = optionIndex;
  }

  bool isOptionSelected(int questionIndex, int optionIndex) {
    return selectedOptionIndices[questionIndex].value == optionIndex;
  }

  void clearSelection(int questionIndex) {
    selectedOptionIndices[questionIndex].value = -1;
  }


  
}
