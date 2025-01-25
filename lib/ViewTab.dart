import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
    home: UserListPage(),
  ));
}

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  Map<String, dynamic>? selectedUser;
  String searchQuery = "";

  final List<Map<String, dynamic>> users = [
    {
      "name": "John Doe",
      "personal": {
        "firstName": "John",
        "middleName": "A.",
        "lastName": "Doe",
        "dob": "1990-01-01",
        "age": "33",
        "email": "john.doe@example.com",
        "mobile": "1234567890",
        "whatsapp": "9876543210",
        "linkedIn": "https://linkedin.com/in/johndoe",
      },
      "education": [
        {"degree": "B.Sc. Computer Science", "university": "XYZ University", "cgpa": "3.8"},
        {"degree": "M.Sc. Data Science", "university": "ABC University", "cgpa": "3.9"},
      ],
      "experience": [
        {
          "organization": "Tech Corp",
          "fromDate": "2015-01-01",
          "toDate": "2020-01-01",
          "isPresent": false,
          "designation": "Software Engineer",
          "description": "Worked on backend development and database management.",
        },
        {
          "organization": "Innovate Ltd",
          "fromDate": "2020-02-01",
          "isPresent": true,
          "designation": "Team Lead",
          "description": "Leading a team of developers in building scalable applications.",
        },
      ],
      "publications": "Published research on machine learning in reputed journals.",
    },
    {
      "name": "Jane Smith",
      "personal": {
        "firstName": "Jane",
        "middleName": "B.",
        "lastName": "Smith",
        "dob": "1992-05-15",
        "age": "31",
        "email": "jane.smith@example.com",
        "mobile": "9876543210",
        "whatsapp": "1234567890",
        "linkedIn": "https://linkedin.com/in/janesmith",
      },
      "education": [
        {"degree": "B.A. Psychology", "university": "DEF University", "cgpa": "3.7"},
      ],
      "experience": [
        {
          "organization": "Wellness Co.",
          "fromDate": "2016-05-01",
          "isPresent": true,
          "designation": "Counselor",
          "description": "Providing mental health support to clients.",
        },
      ],
      "publications": "Authored several articles on mental health and well-being.",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.pink.shade300, Colors.purple.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: selectedUser == null
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value.trim().toLowerCase();
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search username",
                          hintStyle: TextStyle(color: Colors.white70),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Expanded(child: _buildUserList()),
                  ],
                )
              : _buildUserDetails(selectedUser!),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    final filteredUsers = users
        .where((user) => user['name'].toLowerCase().contains(searchQuery))
        .toList();

    if (filteredUsers.isEmpty) {
      return Center(
        child: Text(
          "No user found",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedUser = user;
            });
          },
          child: Card(
            color: Colors.white.withOpacity(0.8),
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                user["name"],
                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildUserDetails(Map<String, dynamic> user) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        selectedUser = null;
                      });
                    },
                  ),
                  Text(
                    "Details",
                    style: TextStyle(
                        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    color: Colors.white.withOpacity(0.9),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSectionTitle("Personal Details"),
                          _buildTextRow(
                              "Name",
                              "${user['personal']['firstName']} ${user['personal']['middleName']} ${user['personal']['lastName']}"),
                          _buildTextRow("Date of Birth", user['personal']['dob']),
                          _buildTextRow("Age", user['personal']['age']),
                          _buildTextRow("Email", user['personal']['email']),
                          _buildTextRow("Mobile", user['personal']['mobile']),
                          SizedBox(height: 20),
                          _buildSectionTitle("Education"),
                          ...user['education']
                              .map<Widget>((edu) => _buildTextRow(
                                  edu['degree'],
                                  "${edu['university']} (CGPA: ${edu['cgpa']})"))
                              .toList(),
                          SizedBox(height: 20),
                          _buildSectionTitle("Experience"),
                          ...user['experience']
                              .map<Widget>((exp) => Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _buildTextRow("Organization", exp['organization']),
                                      _buildTextRow("From", exp['fromDate']),
                                      if (!exp['isPresent']) _buildTextRow("To", exp['toDate']),
                                      _buildTextRow("Designation", exp['designation']),
                                      _buildTextRow("Description", exp['description']),
                                    ],
                                  ))
                              .toList(),
                          SizedBox(height: 20),
                          _buildSectionTitle("Publications"),
                          Text(user['publications'],
                              style: TextStyle(color: Colors.black, fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text("$label:", style: TextStyle(color: Colors.black54)),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
