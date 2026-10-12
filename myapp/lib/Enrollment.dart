
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserRegistration extends StatelessWidget {
  UserRegistration({super.key});

  final name = TextEditingController();
  final sec = TextEditingController();
  final cour = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Registration',  style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green
          )
        )
        
      ),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('Step 1: Registration Form', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          )),

          TextField(
            controller: name,
            decoration: InputDecoration(labelText: 'Name',
            border: OutlineInputBorder(),
            ),
          ),

          TextField(
            controller: sec,
            decoration: InputDecoration(labelText: 'Section',
            border: OutlineInputBorder(),
            ),
          ),

          TextField(
            controller: cour,
            decoration: InputDecoration(labelText: 'Course',
            border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (name.text.isEmpty ||
                  sec.text.isEmpty ||
                  cour.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fill in all fields')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectEnrollment(
                      name.text,
                      sec.text,
                      cour.text,
                    ),
                  ),
                );
              }
            },
            child: Text('Next', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.green)),
          ),
        ],
      ),
    );
  }
}


class SubjectEnrollment extends StatelessWidget {
  final String name;
  final String sec;
  final String cour;

  SubjectEnrollment(
    this.name,
    this.sec,
    this.cour, {
    super.key,
  });

  final sub1 = TextEditingController();
  final time1 = TextEditingController();
  final sub2 = TextEditingController();
  final time2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject Enrollment', style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green)
      )),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('Step 2: Subject Enrollment', style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold
          )),

          TextField(
            controller: sub1,
            decoration: InputDecoration(labelText: 'Subject 1', 
            border: OutlineInputBorder(),
            ),
            
          ),

          TextField(
            controller: time1,
            decoration: InputDecoration(labelText: 'Time 1',
            border: OutlineInputBorder(),
            ),
          ),

          TextField(
            controller: sub2,
            decoration: InputDecoration(labelText: 'Subject 2',
            border: OutlineInputBorder(),
            ),
          ),

          TextField(
            controller: time2,
            decoration: InputDecoration(labelText: 'Time 2',
            border: OutlineInputBorder(),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              if (sub1.text.isEmpty ||
                  time1.text.isEmpty ||
                  sub2.text.isEmpty ||
                  time2.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Fill in all fields')),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubjectVerification(
                      name,
                      sec,
                      cour,
                      sub1.text,
                      time1.text,
                      sub2.text,
                      time2.text,
                    ),
                  ),
                );
              }
            },
            child: Text('Next',  style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.green) ),
          ),
        ],
      ),
    );
  }
}


class SubjectVerification extends StatelessWidget {
  final String name;
  final String sec;
  final String cour;
  final String sub1;
  final String time1;
  final String sub2;
  final String time2;

  SubjectVerification(
    this.name,
    this.sec,
    this.cour,
    this.sub1,
    this.time1,
    this.sub2,
    this.time2, {
    super.key,
  });

  Future<void> saveData(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('students').add({
        'name': name,
        'section': sec,
        'course': cour,
        'subject1': sub1,
        'time1': time1,
        'subject2': sub2,
        'time2': time2,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subject Verification',  style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.green) 
            )),

      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('Step 3: Subject Verifications',  style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            )),

          SizedBox(height: 20),

          Text('Name: $name'),
          Text('Section: $sec'),
          Text('Course: $cour'),

          Divider(),

          Text('Subject 1: $sub1'),
          Text('Time 1: $time1'),
          Text('Subject 2: $sub2'),
          Text('Time 2: $time2'),

          SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              saveData(context);
            },
            child: Text('Save to Firebase',  style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green)
            ),
          ),
        ],
      ),
    );
  }
}
