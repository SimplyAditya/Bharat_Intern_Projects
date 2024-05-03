import 'package:antar_manthan/routes/routeNames.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0, // Remove elevation
        backgroundColor: Color(0xFFFE824B), // Set app bar background color
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipper(), // Custom wave clipper
            child: Container(
              height: 138,
              color: Color(0xFFFE824B), // Change wave clipper color
              alignment: Alignment.topCenter,
              child: Text(
                "Our Articles", // Keep "Our Articles" text
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "All Articles",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Number of tiles
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    width: 200.0,
                    height: 10,
                    constraints: BoxConstraints(maxHeight: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 170.0, // Decrease the image height
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0),
                            ),
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/image_$index.jpeg'), // Replace with your image paths
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.article1);
                            },
                            child: Text(
                              "15 mindful tips in the age of AI you should do today.",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Urbanist',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Suggested Topics",
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Urbanist',
                        fontWeight: FontWeight.w300, // Lighter font weight
                      ),
                    ),
                  ),
                  Text(
                    "See All",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontFamily: 'Urbanist',
                      fontWeight: FontWeight.w300, // Lighter font weight
                      color: Colors.blue, // Custom color for "See All"
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 120.0, // Set the height of the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Number of circular tiles
              itemBuilder: (context, index) {
                // You can use different icons and colors as needed
                final icons = [
                  Icons.accessibility,
                  Icons.sentiment_very_satisfied,
                  Icons.local_hospital,
                  Icons.mood,
                  Icons.sentiment_dissatisfied,
                ];
                final colors = [
                  Colors.red,
                  Colors.green,
                  Colors.blue,
                  Colors.yellow,
                  Colors.purple,
                ];

                return Container(
                  width: 100.0, // Width of each circular tile
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: colors[index],
                        radius: 40.0, // Radius of the circle
                        child: Icon(
                          icons[index],
                          size: 30.0, // Size of the icon
                          color: Colors.white, // Color of the icon
                        ),
                      ),
                      SizedBox(height: 8.0), // Space between icon and text
                      Text(
                        // Updated text
                        [
                          "Stress",
                          "Anxiety",
                          "Health",
                          "Status",
                          "Depression",
                        ][index],
                        style: TextStyle(
                            fontSize: 12.0,
                            fontFamily: 'Urbanist',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 30);
    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstEndPoint = Offset(size.width / 2.25, size.height - 40);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);
    final secondControlPoint =
        Offset(size.width - (size.width / 3.25), size.height - 90);
    final secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
