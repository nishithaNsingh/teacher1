import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee Details Form',
      home: EmployeeDetailsForm(),
    );
  }
}

class EmployeeDetailsForm extends StatefulWidget {
  @override
  _EmployeeDetailsFormState createState() => _EmployeeDetailsFormState();
}

class _EmployeeDetailsFormState extends State<EmployeeDetailsForm> {
  final PageController _controller = PageController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

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

  // Education Details
  final List<Map<String, dynamic>> educationDetails = [];

  // Experience Details
  final List<Map<String, dynamic>> experienceDetails = [];

  // Publications
  final TextEditingController journalIntlController = TextEditingController();
  final TextEditingController journalNatController = TextEditingController();
  final TextEditingController journalRegController = TextEditingController();
  final TextEditingController confIntlController = TextEditingController();
  final TextEditingController confNatController = TextEditingController();
  final TextEditingController confRegController = TextEditingController();
  final TextEditingController articleAuthorController = TextEditingController();
  final TextEditingController articleTitleController = TextEditingController();
  final TextEditingController articleJournalController = TextEditingController();
  final TextEditingController articleISSNController = TextEditingController();
  final TextEditingController presentedNatController = TextEditingController();
  final TextEditingController presentedRegController = TextEditingController();
  final TextEditingController attendedNatController = TextEditingController();
  final TextEditingController attendedRegController = TextEditingController();
  final TextEditingController organizedNatController = TextEditingController();
  final TextEditingController organizedRegController = TextEditingController();
  final TextEditingController projectsCompletedNumController = TextEditingController();
  final TextEditingController projectsCompletedAmtController = TextEditingController();
  final TextEditingController projectsOngoingNumController = TextEditingController();
  final TextEditingController projectsOngoingAmtController = TextEditingController();
  final TextEditingController citationsController = TextEditingController();
  final TextEditingController patentDetailsController = TextEditingController();
  final TextEditingController patentYearController = TextEditingController();
  final TextEditingController patentStatusController = TextEditingController();
  final TextEditingController currentSalaryController = TextEditingController();
  final TextEditingController expectedSalaryController = TextEditingController();
  final TextEditingController noticePeriodController = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    dobController.dispose();
    ageController.dispose();
    emailController.dispose();
    mobileController.dispose();
    whatsappController.dispose();
    linkedInController.dispose();
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

  Future<void> _submitForm() async {
    try {
      // Create a map of the employee details
      Map<String, dynamic> employeeData = {
        'personalDetails': {
          'firstName': firstNameController.text,
          'middleName': middleNameController.text,
          'lastName': lastNameController.text,
          'dob': dobController.text,
          'age': ageController.text,
          'email': emailController.text,
          'mobile': mobileController.text,
          'whatsapp': whatsappController.text,
          'linkedIn': linkedInController.text,
        },
        'educationDetails': educationDetails,
        'experienceDetails': experienceDetails,
        'publications': {
          'journalPublications': {
            'international': journalIntlController.text,
            'national': journalNatController.text,
            'regional': journalRegController.text,
          },
          'conferencePublications': {
            'international': confIntlController.text,
            'national': confNatController.text,
            'regional': confRegController.text,
          },
          'articlePublications': {
            'author': articleAuthorController.text,
            'title': articleTitleController.text,
            'journal': articleJournalController.text,
            'issn': articleISSNController.text,
          },
          'conferencesSeminarsWorkshops': {
            'presentedNational': presentedNatController.text,
            'presentedRegional': presentedRegController.text,
            'attendedNational': attendedNatController.text,
            'attendedRegional': attendedRegController.text,
            'organizedNational': organizedNatController.text,
            'organizedRegional': organizedRegController.text,
          },
          'fundedProjects': {
            'completedProjectsNumber': projectsCompletedNumController.text,
            'completedProjectsAmount': projectsCompletedAmtController.text,
            'ongoingProjectsNumber': projectsOngoingNumController.text,
            'ongoingProjectsAmount': projectsOngoingAmtController.text,
          },
          'citations': citationsController.text,
          'patentDetails': {
            'details': patentDetailsController.text,
            'year': patentYearController.text,
            'status': patentStatusController.text,
          },
        },
        'compensation': {
          'currentSalary': currentSalaryController.text,
          'expectedSalary': expectedSalaryController.text,
          'noticePeriod': noticePeriodController.text,
        },
      };

      // Add the data to Firestore
      await _firestore.collection('employees').add(employeeData);

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Employee details saved successfully!')),
      );
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save employee details: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Details Form'),
      ),
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
  }

  Widget _buildPersonalDetailsPage() {
    return _buildPage(
      title: 'Personal Details',
      children: [
        _buildTextField(controller: firstNameController, label: 'First Name'),
        _buildTextField(controller: middleNameController, label: 'Middle Name'),
        _buildTextField(controller: lastNameController, label: 'Last Name'),
        _buildDateField(controller: dobController, label: 'Date of Birth'),
        _buildTextField(controller: ageController, label: 'Age'),
        _buildTextField(controller: emailController, label: 'Email'),
        _buildTextField(controller: mobileController, label: 'Mobile'),
        _buildTextField(controller: whatsappController, label: 'WhatsApp'),
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
        ElevatedButton(
          onPressed: _addEducation,
          child: Text('Add Education'),
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
        ElevatedButton(
          onPressed: _addExperience,
          child: Text('Add Experience'),
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
      title: 'Publications',
      children: [
        _buildTextField(controller: journalIntlController, label: 'International Journals'),
        _buildTextField(controller: journalNatController, label: 'National Journals'),
        _buildTextField(controller: journalRegController, label: 'Regional Journals'),
        _buildTextField(controller: confIntlController, label: 'International Conferences'),
        _buildTextField(controller: confNatController, label: 'National Conferences'),
        _buildTextField(controller: confRegController, label: 'Regional Conferences'),
        _buildTextField(controller: articleAuthorController, label: 'Article Author'),
        _buildTextField(controller: articleTitleController, label: 'Article Title'),
        _buildTextField(controller: articleJournalController, label: 'Journal Name'),
        _buildTextField(controller: articleISSNController, label: 'ISSN'),
        _buildTextField(controller: presentedNatController, label: 'Presented National'),
        _buildTextField(controller: presentedRegController, label: 'Presented Regional'),
        _buildTextField(controller: attendedNatController, label: 'Attended National'),
        _buildTextField(controller: attendedRegController, label: 'Attended Regional'),
        _buildTextField(controller: organizedNatController, label: 'Organized National'),
        _buildTextField(controller: organizedRegController, label: 'Organized Regional'),
        _buildTextField(controller: projectsCompletedNumController, label: 'Completed Projects (Number)'),
        _buildTextField(controller: projectsCompletedAmtController, label: 'Completed Projects (Amount)'),
        _buildTextField(controller: projectsOngoingNumController, label: 'Ongoing Projects (Number)'),
        _buildTextField(controller: projectsOngoingAmtController, label: 'Ongoing Projects (Amount)'),
        _buildTextField(controller: citationsController, label: 'Citations'),
        _buildTextField(controller: patentDetailsController, label: 'Patent Details'),
        _buildTextField(controller: patentYearController, label: 'Patent Year'),
        _buildTextField(controller: patentStatusController, label: 'Patent Status'),
        _buildTextField(controller: currentSalaryController, label: 'Current Salary'),
        _buildTextField(controller: expectedSalaryController, label: 'Expected Salary'),
        _buildTextField(controller: noticePeriodController, label: 'Notice Period'),
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

  Widget _buildSubmitPage() {
    return _buildPage(
      title: 'Submit',
      children: [
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('Submit'),
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
                  ElevatedButton(
                    onPressed: onBack,
                    child: Text('Back'),
                  ),
                if (onNext != null)
                  ElevatedButton(
                    onPressed: onNext,
                    child: Text('Next'),
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

  Widget _buildEducationCard(int index) {
    final education = educationDetails[index];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Education ${index + 1}"),
            _buildTextField(
              controller: TextEditingController(text: education['degree']),
              label: 'Degree',
            ),
            _buildTextField(
              controller: TextEditingController(text: education['university']),
              label: 'University',
            ),
            _buildTextField(
              controller: TextEditingController(text: education['cgpa']),
              label: 'CGPA',
            ),
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
            _buildTextField(
              controller: TextEditingController(text: experience['organization']),
              label: 'Organization',
            ),
            _buildDateField(
              controller: TextEditingController(text: experience['fromDate']),
              label: 'From Date',
            ),
            if (!experience['isPresent'])
              _buildDateField(
                controller: TextEditingController(text: experience['toDate']),
                label: 'To Date',
              ),
            CheckboxListTile(
              value: experience['isPresent'],
              onChanged: (value) {
                setState(() {
                  experience['isPresent'] = value!;
                });
              },
              title: Text('Currently Working Here'),
            ),
            _buildTextField(
              controller: TextEditingController(text: experience['designation']),
              label: 'Designation',
            ),
            _buildTextField(
              controller: TextEditingController(text: experience['description']),
              label: 'Description',
              maxLines: 3,
            ),
            if (experience['image'] != null)
              Image.file(
                experience['image'],
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ElevatedButton(
              onPressed: () => _pickImage(index),
              child: Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
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
}