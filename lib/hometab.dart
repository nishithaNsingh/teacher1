import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Banner Section
            Container(
              height: 200,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://images.ctfassets.net/wv75stsetqy3/3g3eYc9JHErfxMlj0I5Rg1/8944869cbe75632964eebfe9bc784eb8/Italy_Country_Guide.jpg?q=60&fit=fill&fm=webp",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                alignment: Alignment.center,
                color: Colors.black.withOpacity(0.6),
                child: const Text(
                  "Welcome to Your Profile",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Main Sections
            _buildSection(
              context,
              title: "Personal Data(sample-data)",
              description: "Your personal details.",
              imageUrl:
                  "https://st2.depositphotos.com/1004274/9740/v/450/depositphotos_97408692-stock-illustration-personal-data-protection-icon-flat.jpg",
              details: '''
First Name: John
Middle Name: Edward
Last Name: Doe
Date of Birth: January 15, 1990
Age: 35
Email: john.doe@example.com
Mobile: +1 123-456-7890
WhatsApp: +1 123-456-7890
LinkedIn URL: https://www.linkedin.com/in/johndoe
Address: 123 Main Street, Springfield, IL, 62704
              ''',
            ),
            _buildSection(
              context,
              title: "Experience.(sample-data)",
              description: "Your professional work history.",
              imageUrl:
                  "https://images.unsplash.com/photo-1527689368864-3a821dbccc34?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8d29yayUyMGV4cGVuY2V8ZW58MHx8MHx8fDA%3D",
              details: '''
Designation: Software Engineer
Company: Google
From: July 2020
To: Present
Roles and Responsibilities:
- Developed scalable backend services for Google Cloud Platform.
- Optimized performance for key applications, reducing latency by 15%.
- Collaborated with cross-functional teams to deliver innovative solutions.

Designation: Intern - Machine Learning
Company: Microsoft
From: January 2020
To: June 2020
Roles and Responsibilities:
- Built predictive models for Azure AI.
- Implemented data pipelines for training datasets.
- Delivered a presentation to the leadership team on emerging trends in machine learning.
              ''',
            ),
            _buildSection(
              context,
              title: "Education..(sample-data)",
              description: "Your academic background.",
              imageUrl:
                  "https://plus.unsplash.com/premium_photo-1682125773446-259ce64f9dd7?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8ZWR1Y2F0aW9ufGVufDB8fDB8fHww",
              details: '''
Degree Name: Bachelor of Engineering (BE)
University: Indian Institute of Technology (IIT), Bombay
Branch: Computer Science and Engineering
Specialization: Artificial Intelligence and Machine Learning

Degree Name: Master of Technology (M.Tech)
University: Anna University, Chennai
Branch: Electronics and Communication Engineering (ECE)
Specialization: VLSI Design
              ''',
            ),
            _buildSection(
              context,
              title: "Publications-(sample-data)",
              description: "Your academic contributions.",
              imageUrl:
                  "https://plus.unsplash.com/premium_vector-1682303174219-9018338d4b5d?w=352&dpr=1&h=367&auto=format&fit=crop&q=60&ixlib=rb-4.0.3",
              details: '''
Title: Neural Networks and Their Applications
Journal: AI Research Today
Date: June 2020
Contributions: Published a detailed paper on advancements in neural networks and real-world applications.
              ''',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title,
      required String description,
      required String imageUrl,
      required String details}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(title: title, details: details),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade700, Colors.pink.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String title;
  final String details;

  const DetailScreen({Key? key, required this.title, required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Text(
                  details,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.5,
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

void main() => runApp(const MaterialApp(home: HomeScreen()));
