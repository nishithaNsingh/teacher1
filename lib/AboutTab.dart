import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'About the App',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        elevation: 10,
        shadowColor: Colors.deepPurpleAccent.withOpacity(0.5),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Header Text
              Text(
                "Welcome to Teacher Manager",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurpleAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Body Text
              Text(
                "This app is designed to efficiently manage and display teacher details. "
                "It allows users to input teacher profiles, including their qualifications, "
                "subjects taught, and years of experience. The app ensures a smooth experience "
                "for administrators to track and access teacher data. With its user-friendly design "
                "and robust functionality, this app simplifies data organization and enhances productivity.",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 30),
              // Decorative Divider
              Divider(
                color: Colors.deepPurpleAccent,
                thickness: 2,
                indent: 40,
                endIndent: 40,
              ),
              SizedBox(height: 20),
              // Footer
              Text(
                "Thank you for using Teacher Manager!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
