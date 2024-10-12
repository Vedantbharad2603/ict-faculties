import 'package:flutter/material.dart';

class MarkAttendance extends StatefulWidget {
  const MarkAttendance({super.key});

  @override
  State<MarkAttendance> createState() => _MarkAttendanceState();
}

class _MarkAttendanceState extends State<MarkAttendance> {
  // List of 10 students with detailed information
  final List<Map<String, dynamic>> students = [
    {
      'id': '001',
      'enrollment_no': '924001',
      'first_name': 'John',
      'last_name': 'Doe',
      'class': '12th Grade',
      'batch': 'A',
      'isPresent': false,
    },
    {
      'id': '002',
      'enrollment_no': '924002',
      'first_name': 'Jane',
      'last_name': 'Smith',
      'class': '12th Grade',
      'batch': 'A',
      'isPresent': false,
    },
    {
      'id': '003',
      'enrollment_no': '924003',
      'first_name': 'Michael',
      'last_name': 'Johnson',
      'class': '12th Grade',
      'batch': 'B',
      'isPresent': false,
    },
    {
      'id': '004',
      'enrollment_no': '924004',
      'first_name': 'Emily',
      'last_name': 'Davis',
      'class': '12th Grade',
      'batch': 'B',
      'isPresent': false,
    },
    {
      'id': '005',
      'enrollment_no': '924005',
      'first_name': 'David',
      'last_name': 'Wilson',
      'class': '12th Grade',
      'batch': 'A',
      'isPresent': false,
    },
    {
      'id': '006',
      'enrollment_no': '924006',
      'first_name': 'Sarah',
      'last_name': 'Brown',
      'class': '12th Grade',
      'batch': 'A',
      'isPresent': false,
    },
    {
      'id': '007',
      'enrollment_no': '924007',
      'first_name': 'Daniel',
      'last_name': 'Jones',
      'class': '12th Grade',
      'batch': 'B',
      'isPresent': false,
    },
    {
      'id': '008',
      'enrollment_no': '924008',
      'first_name': 'Sophia',
      'last_name': 'Garcia',
      'class': '12th Grade',
      'batch': 'B',
      'isPresent': false,
    },
    {
      'id': '009',
      'enrollment_no': '924009',
      'first_name': 'Chris',
      'last_name': 'Martinez',
      'class': '12th Grade',
      'batch': 'A',
      'isPresent': false,
    },
    {
      'id': '010',
      'enrollment_no': '924010',
      'first_name': 'Anna',
      'last_name': 'Lopez',
      'class': '12th Grade',
      'batch': 'B',
      'isPresent': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            // ListView to display the attendance information inside cards
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ID: ${student['id']}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text('Enrollment No: ${student['enrollment_no']}'),
                          Text(
                              'Name: ${student['first_name']} ${student['last_name']}'),
                          Text('Class: ${student['class']}'),
                          Text('Batch: ${student['batch']}'),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Text(
                                'Present:',
                                style: TextStyle(fontSize: 16),
                              ),
                              Checkbox(
                                value: student['isPresent'],
                                onChanged: (value) {
                                  setState(() {
                                    student['isPresent'] = value ?? false;
                                  });
                                },
                                checkColor: Colors.white,
                                activeColor: Colors.green,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Save button
            Align(
              alignment: Alignment.centerRight,
              child: FloatingActionButton(
                onPressed: () {
                  // Handle save action
                },
                child: const Icon(Icons.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
