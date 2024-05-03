import 'package:antar_manthan/views/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(247, 244, 242, 1),
      body: SignUpWidget(),
    );
  }
}

class SignUpWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(painter: BackgroundPainter()),
          buildSignUp(),
        ],
      );

  Widget buildSignUp() => Column(
        children: [
          const Spacer(
            flex: 3,
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: 175,
              child: Text('Welcome to \nMannMitra!',
                  style: GoogleFonts.urbanist(
                    textStyle: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            ),
          ),
          SizedBox(
            height: 115,
          ),
          Image.asset("assets/images/logo.png"),
          SizedBox(
            height: 15,
          ),
          GoogleSignupButtonWidget(),
          const Spacer(
            flex: 2,
          ),
        ],
      );
}

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
}

class BackgroundPainter extends CustomPainter {
  final Paint brownpaint;
  final Paint greenpaint;
  final Paint yellowpaint;

  BackgroundPainter()
      : brownpaint = Paint()..color = Color.fromRGBO(75, 52, 37, 1),
        greenpaint = Paint()..color = Color.fromRGBO(155, 176, 104, 1),
        yellowpaint = Paint()..color = Color.fromRGBO(255, 206, 92, 1);

  @override
  void paint(Canvas canvas, Size size) {
    paintBlue(size, canvas);
    paintDark(size, canvas);
    paintOrange(size, canvas);
  }

  void paintBlue(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);

    _addPointsToPath(path, [
      Point(
        size.width * 0.35,
        size.height * 0.35,
      ),
      Point(
        size.width,
        size.height * 0.6,
      ),
      Point(
        size.width,
        size.height * 0.55,
      ),
    ]);

    canvas.drawPath(path, brownpaint);
  }

  void paintDark(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.48);

    _addPointsToPath(
      path,
      [
        Point(
          size.width * 0.5,
          size.height * 0.65,
        ),
        Point(
          size.width * 0.7,
          size.height * 0.2,
        ),
        Point(
          size.width,
          size.height * 0.15,
        ),
      ],
    );

    canvas.drawPath(path, greenpaint);
  }

  void paintOrange(Size size, Canvas canvas) {
    final path = Path();

    path.moveTo(size.width * 0.75, 0);
    path.lineTo(0, 0);
    path.lineTo(0, size.height * 0.2);

    _addPointsToPath(path, [
      Point(
        size.width * 0.2,
        size.height * 0.25,
      ),
      Point(
        size.width * 0.35,
        size.height * 0.1,
      ),
      Point(
        size.width * 0.65,
        size.height * 0.06,
      ),
      Point(
        size.width * 0.75,
        0,
      ),
    ]);

    canvas.drawPath(path, yellowpaint);
  }

  void _addPointsToPath(Path path, List<Point> points) {
    if (points.length < 3) {
      throw UnsupportedError('Need 3+ points to create a path.');
    }

    for (var i = 0; i < points.length - 2; i++) {
      final xDiff = (points[i].x + points[i + 1].x) / 2;
      final yDiff = (points[i].y + points[i + 1].y) / 2;
      path.quadraticBezierTo(points[i].x, points[i].y, xDiff, yDiff);
    }

    final secondLastPoint = points[points.length - 2];
    final lastPoint = points[points.length - 1];
    path.quadraticBezierTo(
        secondLastPoint.x, secondLastPoint.y, lastPoint.x, lastPoint.y);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class GoogleSignupButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          enableFeedback: true,
          onTap: () {
            signInWithGoogle(context);
          },
          child: Container(
            width: 210,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 221, 217, 1),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.asset("assets/images/Vector.png"),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Continue with Google",
                  style: TextStyle(
                      color: Color.fromRGBO(75, 52, 37, 1),
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      );

  Future<void> signInWithGoogle(BuildContext context) async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);

    if (userCredential.user != null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }
}
