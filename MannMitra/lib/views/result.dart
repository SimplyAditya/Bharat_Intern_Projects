import 'package:antar_manthan/controller/ratingcontroller.dart';
import 'package:antar_manthan/routes/routeNames.dart';
import 'package:antar_manthan/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MoodScreen extends StatefulWidget {
  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  final List<int> tileProgressValues = [60, 80, 40, 90, 20];
  final RatingController ratingController = Get.put(RatingController());

  final List<Widget> _screens = [
    HomeScreen(),
    MoodScreen(),
  ];

  @override
  void dispose() {
    // Dispose of the RatingController when the screen is disposed
    Get.delete<RatingController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Obx(() => Text(
                    '${ratingController.normalText.value ?? "NORMAL"}',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Urbanist',
                      color: Color(0xff9BB068), // Transparent text color
                    ),
                  )),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            child: CurvedClipPathWithBackButton(),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Mental Score History',
              style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Urbanist',
                fontWeight: FontWeight.bold,
                color: Color(0xff4B3425), // Change the text color as needed
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5, // Reduced the number of tiles to 5
              itemBuilder: (BuildContext context, int index) {
                // Calculate the date based on the index
                int date = 10 + index;

                // Generate different text for each tile based on index
                String tileText = 'Anxious';

                // Get the progress value for this tile
                int progressValue = tileProgressValues[index];

                return SizedBox(
                  width: 220.0, // Set the desired width for each tile
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16.0), // Added horizontal padding
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xffF7F4F2), // Grey-colored tile
                        borderRadius:
                            BorderRadius.circular(12.0), // Added border radius
                      ),
                      height: 70.0,
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Container(
                            width: 60.0,
                            margin: EdgeInsets.all(8.0), // Added margin
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // White container for month and date
                              borderRadius: BorderRadius.circular(
                                  8.0), // Added border radius
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'SEPT',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '$date',
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              width: 8.0), // Added space between date and text
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  tileText, // Display different text in each tile
                                  style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Urbanist',
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            width: 24.0,
                            height: 24.0,
                            child: CircularProgressIndicator(
                              value: progressValue /
                                  100.0, // Adjust the progress value
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xff9BB068), // Progress bar color
                              ),
                              strokeWidth:
                                  8.0, // Adjust the thickness of the progress bar
                              backgroundColor: Colors
                                  .black, // Background color of the progress bar
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
              Get.toNamed(RouteName.mood); // Navigate to the '/mood' route
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

class CurvedClipPathWithBackButton extends StatelessWidget {
  final RatingController ratingController = Get.put(RatingController());

  String getRatingMessage(int rating) {
    if (rating >= 0 && rating <= 5) {
      return "Congratulations! Your rating suggests that you are not experiencing depression.\n"
          "It's great that you're feeling well. Continue with your healthy habits and maintain a positive outlook on life.";
    } else if (rating >= 6 && rating <= 10) {
      return "Your rating indicates mild symptoms of depression.\n"
          "Consider talking to a trusted friend or family member about your feelings. Engaging in enjoyable activities and practicing self-care can also help improve your mood.";
    } else if (rating >= 11 && rating <= 20) {
      return "Your rating suggests moderate depression.\n"
          "It's essential to seek support from a mental health professional or counselor. They can provide strategies and guidance to help you cope with your feelings.";
    } else if (rating >= 21 && rating <= 30) {
      return "Your rating indicates severe depression.\n"
          "Please reach out to a mental health specialist or therapist immediately. Depression at this level can be challenging to manage alone, and professional help is crucial.";
    } else if (rating >= 31 && rating <= 36) {
      return "Your rating reflects a very severe level of depression.\n"
          "Urgently seek assistance from a mental health expert or a crisis helpline. You don't have to face this alone, and there are resources available to support you.";
    } else {
      return "Invalid rating";
    }
  }

  @override
  Widget build(BuildContext context) {
    int rating =
        ratingController.totalRatings.value ?? 0; // Use 0 as the default rating
    String message = getRatingMessage(rating);

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Text(
                    ' ${ratingController.totalRatings.value ?? 0}',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4B3425),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Center(
                    child: Obx(
                      () => RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.urbanist(
                              textStyle: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          )),
                          children: [
                            TextSpan(
                                text: getRatingMessage(
                                    ratingController.totalRatings.value)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(
                  () => Visibility(
                    visible:
                        ratingController.totalRatings.value > 20 ? true : false,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          "Help is always available, don't hesitate!\nDial Now +91 9152987821",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            textStyle: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
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
