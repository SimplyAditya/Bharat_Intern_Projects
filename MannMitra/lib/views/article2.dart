import 'package:flutter/material.dart';

class Article {
  final String title;
  final String shortDescription;
  final String author;
  final String content;
  final List<String> tags;

  Article({
    required this.title,
    required this.shortDescription,
    required this.author,
    required this.content,
    required this.tags,
  });
}

class MyApp extends StatelessWidget {
  final Article article = Article(
    title: 'Understanding Mental Health',
    shortDescription:
        'Learn about the importance of mental health and well-being.',
    author: 'Dr. Jane Smith',
    content: '''
      Mental health is a critical aspect of our overall well-being. It includes
      emotional, psychological, and social well-being. Good mental health allows
      us to lead fulfilling lives, handle stress, maintain healthy relationships, 
      and make informed choices.

      Unfortunately, mental health issues are prevalent, and they affect people 
      from all walks of life. Conditions like anxiety, depression, and bipolar 
      disorder can significantly impact one's daily life. However, it's essential 
      to remember that mental health is treatable, and seeking help is a sign of 
      strength.

      Remember, you're not alone, and there is help available for those who need it.
    ''',
    tags: ['Mental Health', 'Well-being'],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF4B3525),
        scaffoldBackgroundColor: Color(0xFFF7F4F2),
        fontFamily: 'Urbanist',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Article Page',
            style: TextStyle(fontFamily: 'Urbanist'),
          ),
          backgroundColor: Color(0xFF4B3525),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4B3525),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.tag),
                        SizedBox(width: 4.0),
                        Text(
                          article.tags[0],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFFF7F4F2),
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 16.0),
                    Row(
                      children: [
                        Icon(Icons.tag),
                        SizedBox(width: 4.0),
                        Text(
                          article.tags[1],
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color(0xFFF7F4F2),
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      article.title,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      article.shortDescription,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'By ${article.author}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4B3525),
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/mind.jpeg',
                      width: double.infinity,
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      article.content,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Urbanist',
                      ),
                      textAlign: TextAlign.center,
                    ), // Align text in the center
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
