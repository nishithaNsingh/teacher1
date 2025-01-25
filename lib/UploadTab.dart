import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class EmployeeDetailsForm extends StatefulWidget {
  @override
  _EmployeeDetailsFormState createState() => _EmployeeDetailsFormState();
}

class _EmployeeDetailsFormState extends State<EmployeeDetailsForm> {
  final PageController _controller = PageController();

  // Personal Details
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController linkedInController = TextEditingController();
  // Controllers for journal publications
  final journalIntlController = TextEditingController();
  final journalNatController = TextEditingController();
  final journalRegController = TextEditingController();

  // Controllers for conference publications
  final confIntlController = TextEditingController();
  final confNatController = TextEditingController();
  final confRegController = TextEditingController();

  // Controllers for article publications
  final articleAuthorController = TextEditingController();
  final articleTitleController = TextEditingController();
  final articleJournalController = TextEditingController();
  final articleISSNController = TextEditingController();

  // Controllers for conferences, seminars, and workshops
  final presentedNatController = TextEditingController();
  final presentedRegController = TextEditingController();
  final attendedNatController = TextEditingController();
  final attendedRegController = TextEditingController();
  final organizedNatController = TextEditingController();
  final organizedRegController = TextEditingController();

  // Controllers for funded projects
  final projectsCompletedNumController = TextEditingController();
  final projectsCompletedAmtController = TextEditingController();
  final projectsOngoingNumController = TextEditingController();
  final projectsOngoingAmtController = TextEditingController();

  // Controller for citations
  final citationsController = TextEditingController();

  // Controllers for patent details
  final patentDetailsController = TextEditingController();
  final patentYearController = TextEditingController();
  final patentStatusController = TextEditingController();

  // Controllers for compensation and notice period
  final currentSalaryController = TextEditingController();
  final expectedSalaryController = TextEditingController();
  final noticePeriodController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to prevent memory leaks
    journalIntlController.dispose();
    journalNatController.dispose();
    journalRegController.dispose();
    confIntlController.dispose();
    confNatController.dispose();
    confRegController.dispose();
    articleAuthorController.dispose();
    articleTitleController.dispose();
    articleJournalController.dispose();
    articleISSNController.dispose();
    presentedNatController.dispose();
    presentedRegController.dispose();
    attendedNatController.dispose();
    attendedRegController.dispose();
    organizedNatController.dispose();
    organizedRegController.dispose();
    projectsCompletedNumController.dispose();
    projectsCompletedAmtController.dispose();
    projectsOngoingNumController.dispose();
    projectsOngoingAmtController.dispose();
    citationsController.dispose();
    patentDetailsController.dispose();
    patentYearController.dispose();
    patentStatusController.dispose();
    currentSalaryController.dispose();
    expectedSalaryController.dispose();
    noticePeriodController.dispose();
    super.dispose();
  }

 
  // Education Details
  final List<Map<String, dynamic>> educationDetails = [];

  // Experience Details
  final List<Map<String, dynamic>> experienceDetails = [];

  // Publications
  final TextEditingController publicationController = TextEditingController();

  void _addEducation() {
    educationDetails.add({
      'degree': '',
      'university': '',
      'cgpa': '',
    });
    setState(() {});
  }

  void _addExperience() {
    experienceDetails.add({
      'organization': '',
      'fromDate': '',
      'toDate': '',
      'isPresent': false,
      'designation': '',
      'description': '',
      'image': null,
    });
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = DateFormat('yyyy-MM-dd').format(picked);
    }
  }

  Future<void> _pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        experienceDetails[index]['image'] = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Employee Details Form'),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      backgroundColor: Colors.grey[200],
      body: PageView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildPersonalDetailsPage(),
          _buildEducationDetailsPage(),
          _buildExperienceDetailsPage(),
          _buildPublicationPage(),
          _buildSubmitPage(),
        ],
      ),
    );
  }Widget _buildPersonalDetailsPage() {
  bool isSameAddress = false; // Track checkbox state
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();

  return _buildPage(
    title: 'Personal Details',
    children: [
      // Title Dropdown (Mr, Dr, Miss)
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Title',
          border: OutlineInputBorder(),
        ),
        items: ['Mr.', 'Dr.', 'Miss']
            .map((title) => DropdownMenuItem(
                  value: title,
                  child: Text(title),
                ))
            .toList(),
        onChanged: (value) {
          // Handle title selection
        },
      ),
      SizedBox(height: 16),

      // First Name
      _buildTextField(controller: firstNameController, label: 'First Name'),

      // Middle Name
      _buildTextField(controller: middleNameController, label: 'Middle Name'),

      // Last Name
      _buildTextField(controller: lastNameController, label: 'Last Name'),

      // Gender Dropdown
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Gender',
          border: OutlineInputBorder(),
        ),
        items: ['Male', 'Female', 'Other']
            .map((gender) => DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                ))
            .toList(),
        onChanged: (value) {
          // Handle gender selection
        },
      ),
      SizedBox(height: 16),

      // Date of Birth
      _buildDateField(controller: dobController, label: 'Date of Birth'),

      // Place of Birth
      _buildTextField(controller: ageController, label: 'Place of Birth'),

      // Marital Status Dropdown
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Marital Status',
          border: OutlineInputBorder(),
        ),
        items: ['Single', 'Married', 'Divorced']
            .map((status) => DropdownMenuItem(
                  value: status,
                  child: Text(status),
                ))
            .toList(),
        onChanged: (value) {
          // Handle marital status selection
        },
      ),
      SizedBox(height: 16),

      // Country Dropdown
      DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Country',
          border: OutlineInputBorder(),
        ),
        items: [
          'India',
          'United States',
          'Canada',
          'United Kingdom',
          'Australia',
          'Germany',
          'France'
        ]
            .map((country) => DropdownMenuItem(
                  value: country,
                  child: Text(country),
                ))
            .toList(),
        onChanged: (value) {
          // Handle country selection
        },
      ),
      SizedBox(height: 16),

      // State
      _buildTextField(controller: TextEditingController(), label: 'State'),

      // City
      _buildTextField(controller: TextEditingController(), label: 'City'),

      // Pin Code
      _buildTextField(controller: TextEditingController(), label: 'Pin Code'),

      // Current Address
      _buildTextField(
        controller: currentAddressController,
        label: 'Current Address',
      ),

      // Checkbox: Same as Current Address
      Row(
        children: [
          Checkbox(
            value: isSameAddress,
            onChanged: (value) {
              isSameAddress = value ?? false;
              if (isSameAddress) {
                permanentAddressController.text = currentAddressController.text;
              } else {
                permanentAddressController.clear();
              }
            },
          ),
          Text('Same as Current Address'),
        ],
      ),

      // Permanent Address
      _buildTextField(
        controller: permanentAddressController,
        label: 'Permanent Address',
      ),

      // Aadhaar Card Number
      _buildTextField(
        controller: TextEditingController(),
        label: 'Aadhaar Card Number',
      ),

      // PAN Card Number
      _buildTextField(
        controller: TextEditingController(),
        label: 'PAN Card Number',
      ),

      // Email
      _buildTextField(controller: emailController, label: 'Email'),

      // Mobile
      _buildTextField(controller: mobileController, label: 'Mobile'),

      // WhatsApp
      _buildTextField(controller: whatsappController, label: 'WhatsApp'),

      // LinkedIn URL
      _buildTextField(controller: linkedInController, label: 'LinkedIn URL'),
    ],
    onNext: () => _controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
  );
}



  Widget _buildEducationDetailsPage() {
    return _buildPage(
      title: 'Education Details',
      children: [
        for (int i = 0; i < educationDetails.length; i++) _buildEducationCard(i),
       ElevatedButton.icon(
  onPressed: _addEducation,
  icon: Icon(Icons.school, color: Colors.white),
  label: Text(
    'Add Education',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    shadowColor: Colors.blue.withOpacity(0.5),
    elevation: 10,
  ),
),

      ],
      onNext: () => _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      onBack: () => _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  Widget _buildExperienceDetailsPage() {
    return _buildPage(
      title: 'Experience Details',
      children: [
        for (int i = 0; i < experienceDetails.length; i++) _buildExperienceCard(i),
        ElevatedButton.icon(
  onPressed: _addExperience,
  icon: Icon(Icons.work, color: Colors.white),
  label: Text(
    'Add Experience',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.deepOrangeAccent,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    shadowColor: Colors.deepOrange.withOpacity(0.5),
    elevation: 10,
  ),
),

      ],
      onNext: () => _controller.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
      onBack: () => _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }
Widget _buildPublicationPage() {
  return _buildPage(
    title: 'Publications & Other Details',
    children: [
      _buildSectionHeader('Number of Journal Publications'),
      _buildCustomField(label: 'International', controller: journalIntlController),
      _buildCustomField(label: 'National', controller: journalNatController),
      _buildCustomField(label: 'Regional', controller: journalRegController),

      _buildSectionHeader('Number of Conference Publications'),
      _buildCustomField(label: 'International', controller: confIntlController),
      _buildCustomField(label: 'National', controller: confNatController),
      _buildCustomField(label: 'Regional', controller: confRegController),

      _buildSectionHeader('Article Publications in Journals'),
      _buildCustomField(label: 'Author', controller: articleAuthorController),
      _buildCustomField(label: 'Title of Article', controller: articleTitleController),
      _buildCustomField(label: 'Name of Journal', controller: articleJournalController),
      _buildCustomField(label: 'ISSN', controller: articleISSNController),

      _buildSectionHeader('Conferences, Seminars, Workshops'),
      _buildCustomField(label: 'Presented (National)', controller: presentedNatController),
      _buildCustomField(label: 'Presented (Regional)', controller: presentedRegController),
      _buildCustomField(label: 'Attended (National)', controller: attendedNatController),
      _buildCustomField(label: 'Attended (Regional)', controller: attendedRegController),
      _buildCustomField(label: 'Organized (National)', controller: organizedNatController),
      _buildCustomField(label: 'Organized (Regional)', controller: organizedRegController),

      _buildSectionHeader('Funded Projects (Last 3 Years)'),
      _buildCustomField(label: 'Completed Projects (Number)', controller: projectsCompletedNumController),
      _buildCustomField(label: 'Completed Projects (Amount in INR)', controller: projectsCompletedAmtController),
      _buildCustomField(label: 'Ongoing Projects (Number)', controller: projectsOngoingNumController),
      _buildCustomField(label: 'Ongoing Projects (Amount in INR)', controller: projectsOngoingAmtController),

      _buildSectionHeader('Citations (Last 3 Years)'),
      _buildCustomField(label: 'Number of Citations', controller: citationsController),

      _buildSectionHeader('Patent Details'),
      _buildCustomField(label: 'Patent Details', controller: patentDetailsController),
      _buildCustomField(label: 'Year', controller: patentYearController),
      _buildCustomField(label: 'Status', controller: patentStatusController),

      
    ],
    onNext: () => _controller.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
    onBack: () => _controller.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16.0),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildCustomField({
  required String label,
  required TextEditingController controller,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    ),
  );
}


  Widget _buildSubmitPage() {
    return _buildPage(
      title: 'Submit',
      children: [
        ElevatedButton.icon(
  onPressed: () {
    // Submit logic here
  },
  icon: Icon(Icons.check_circle, color: Colors.white),
  label: Text(
    'Submit',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.green,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    shadowColor: Colors.green.withOpacity(0.5),
    elevation: 10,
  ),
),

      ],
      onBack: () => _controller.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      ),
    );
  }

  Widget _buildPage({
    required String title,
    required List<Widget> children,
    VoidCallback? onNext,
    VoidCallback? onBack,
  }) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ...children,
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (onBack != null)
                  ElevatedButton.icon(
  onPressed: onBack,
  icon: Icon(Icons.arrow_back, color: Colors.white),
  label: Text(
    'Back',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    shadowColor: Colors.blueGrey.withOpacity(0.5),
    elevation: 10,
  ),
),

                if (onNext != null)
                ElevatedButton.icon(
  onPressed: onNext,
  icon: Icon(Icons.arrow_forward, color: Colors.white),
  label: Text(
    'Next',
    style: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.purpleAccent,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    shadowColor: Colors.purple.withOpacity(0.5),
    elevation: 10,
  ),
),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () => _selectDate(context, controller),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
      ),
    );
  }
Widget _buildEducationCard(int index) {
  final education = educationDetails[index];
  final educationLabels = [
    '10th/SSLC',
    'Higher Secondary/PUC',
    'Graduation',
    'Post Graduation',
    'Ph.D.',
    'Other Qualifications',
    'Government Exams'
  ];

  return Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    elevation: 4,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Education ${index + 1} - ${educationLabels[index]}",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),

          // Institution Name
          if (index < 6)
            _buildTextField(
              controller: TextEditingController(text: education['institutionName']),
              label: 'Institution Name',
            ),
          if (index < 6) SizedBox(height: 16),

          // Board/University
          if (index < 6)
            _buildTextField(
              controller: TextEditingController(text: education['boardUniv']),
              label: 'Board/University',
            ),
          if (index < 6) SizedBox(height: 16),

          // Education Mode (only for Graduation, Post Graduation, Ph.D., and Other Qualifications)
          if (index > 1 && index < 6)
            Column(
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Education Mode',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Full-Time', 'Part-Time', 'Distance']
                      .map((mode) => DropdownMenuItem(
                            value: mode,
                            child: Text(mode),
                          ))
                      .toList(),
                  onChanged: (value) {
                    education['eduMode'] = value;
                  },
                ),
                SizedBox(height: 16),
              ],
            ),

          // Division/Grade
          if (index < 6)
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Division/Grade',
                border: OutlineInputBorder(),
              ),
              items: ['First Division', 'Second Division', 'Third Division']
                  .map((grade) => DropdownMenuItem(
                        value: grade,
                        child: Text(grade),
                      ))
                  .toList(),
              onChanged: (value) {
                education['divisionGrade'] = value;
              },
            ),
          if (index < 6) SizedBox(height: 16),

          // Percentage of Marks
          if (index < 6)
            _buildTextField(
              controller: TextEditingController(text: education['percentage']),
              label: 'Percentage of Marks',
            ),
          if (index < 6) SizedBox(height: 16),

          // Year
          if (index < 6)
            _buildTextField(
              controller: TextEditingController(text: education['year']),
              label: 'Year',
            ),
          if (index < 6) SizedBox(height: 16),

          // Specialization (optional, for higher education levels)
          if (index > 1 && index < 6)
            _buildTextField(
              controller: TextEditingController(text: education['specialization']),
              label: 'Specialization',
            ),

          // Government Exams Section
          if (index == 6) ...[
            Text(
              'Government Exams',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),

            // GATE
            Row(
              children: [
                Text("GATE: ", style: TextStyle(fontSize: 14)),
                Spacer(),
                DropdownButton<String>(
                  value: education['gate'] ?? 'No',
                  items: ['Yes', 'No']
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    education['gate'] = value;
                  },
                ),
              ],
            ),
            SizedBox(height: 8),

            // NET
            Row(
              children: [
                Text("NET: ", style: TextStyle(fontSize: 14)),
                Spacer(),
                DropdownButton<String>(
                  value: education['net'] ?? 'No',
                  items: ['Yes', 'No']
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    education['net'] = value;
                  },
                ),
              ],
            ),
            SizedBox(height: 8),

            // UGC-CSIR
            Row(
              children: [
                Text("UGC-CSIR: ", style: TextStyle(fontSize: 14)),
                Spacer(),
                DropdownButton<String>(
                  value: education['ugcCsir'] ?? 'No',
                  items: ['Yes', 'No']
                      .map((option) => DropdownMenuItem(
                            value: option,
                            child: Text(option),
                          ))
                      .toList(),
                  onChanged: (value) {
                    education['ugcCsir'] = value;
                  },
                ),
              ],
            ),
            SizedBox(height: 8),

            // SLET (Any State)
            
          ],
        ],
      ),
    ),
  );
}
Widget _buildExperienceCard(int index) {
  final experience = experienceDetails[index];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Experience ${index + 1}"),
          SizedBox(height: 16),

          // Experience Type Dropdown
          DropdownButtonFormField<String>(
            value: experience['experienceType'],
            decoration: InputDecoration(
              labelText: 'Experience Type',
              border: OutlineInputBorder(),
            ),
            items: [
              'Full-Time',
              'Part-Time',
              'Internship',
              'Freelance',
              'Contract'
            ]
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                experience['experienceType'] = value!;
              });
            },
          ),
          SizedBox(height: 16),

          // Nature of Job Dropdown
          DropdownButtonFormField<String>(
            value: experience['natureOfJob'],
            decoration: InputDecoration(
              labelText: 'Nature of Job',
              border: OutlineInputBorder(),
            ),
            items: [
              'Technical',
              'Management',
              'Operations',
              'Administrative',
              'Other'
            ]
                .map((nature) => DropdownMenuItem(
                      value: nature,
                      child: Text(nature),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                experience['natureOfJob'] = value!;
              });
            },
          ),
          SizedBox(height: 16),

          // Organization Field
          _buildTextField(
            controller: TextEditingController(text: experience['organization']),
            label: 'Organization',
          ),
          SizedBox(height: 16),

          // From Date Field
          _buildDateField(
            controller: TextEditingController(text: experience['fromDate']),
            label: 'From Date',
          ),
          SizedBox(height: 16),

          // To Date Field (conditionally displayed)
          if (!experience['isPresent'])
            _buildDateField(
              controller: TextEditingController(text: experience['toDate']),
              label: 'To Date',
            ),
          SizedBox(height: 16),

          // Currently Working Here Checkbox
          CheckboxListTile(
            value: experience['isPresent'],
            onChanged: (value) {
              setState(() {
                experience['isPresent'] = value!;
              });
            },
            title: Text('Currently Working Here'),
          ),
          SizedBox(height: 16),

          // Designation Field
          _buildTextField(
            controller: TextEditingController(text: experience['designation']),
            label: 'Designation',
          ),
          SizedBox(height: 16),

          // Roles & Responsibilities Field
          _buildTextField(
            controller: TextEditingController(text: experience['description']),
            label: 'Roles & Responsibilities',
            maxLines: 3,
          ),
          SizedBox(height: 16),

          // Image Field (optional)
          if (experience['image'] != null)
            Image.file(
              experience['image'],
              height: 150,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          SizedBox(height: 16),

          // Upload Image Button
          ElevatedButton.icon(
            onPressed: () => _pickImage(index),
            icon: Icon(Icons.image),
            label: Text("Upload Image (Optional)"),
          ),
        ],
      ),
    ),
  );
}
}