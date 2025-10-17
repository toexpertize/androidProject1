//assignment_submission_page.dart

import 'package:flutter/material.dart';
import 'package:file_selector/file_selector.dart';
import 'package:hive/hive.dart';
import 'package:lmsalfa/models/assignment_submission.dart';
import 'package:lmsalfa/models/user.dart';
import 'package:uuid/uuid.dart';

class AssignmentSubmissionPage extends StatefulWidget {
  final User user;
  final String courseId;
  final DateTime deadline;

  const AssignmentSubmissionPage({
    super.key,
    required this.user,
    required this.courseId,
    required this.deadline,
  });

  @override
  State<AssignmentSubmissionPage> createState() => _AssignmentSubmissionPageState();
}

class _AssignmentSubmissionPageState extends State<AssignmentSubmissionPage> {
  String? selectedFilePath;
  bool isSubmitted = false;

  void pickFile() async {
    final typeGroup = XTypeGroup(
      label: 'documents',
      extensions: ['pdf', 'doc', 'docx', 'jpg', 'png'],
    );

    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      setState(() {
        selectedFilePath = file.path;
      });
    }
  }

  void submitAssignment() {
    if (selectedFilePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a file first')),
      );
      return;
    }

    final now = DateTime.now();
    final status = now.isAfter(widget.deadline) ? 'late' : 'submitted';

    final submission = AssignmentSubmission(
      id: const Uuid().v4(),
      studentId: widget.user.id,
      courseId: widget.courseId,
      filePath: selectedFilePath!,
      submittedAt: now,
      deadline: widget.deadline,
      status: status,
      instructorFeedback: null,
    );

    final box = Hive.box<AssignmentSubmission>('submissions');
    box.put(submission.id, submission);

    setState(() {
      isSubmitted = true;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Assignment ${status == 'late' ? 'submitted late' : 'submitted'}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Submit Assignment')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Course ID: ${widget.courseId}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Deadline: ${widget.deadline.toLocal()}',
                style: const TextStyle(fontSize: 16, color: Colors.red)),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: pickFile,
              icon: const Icon(Icons.attach_file),
              label: const Text('Pick File'),
            ),
            if (selectedFilePath != null) ...[
              const SizedBox(height: 10),
              Text('Selected File: $selectedFilePath'),
            ],
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: isSubmitted ? null : submitAssignment,
              icon: const Icon(Icons.send),
              label: Text(isSubmitted ? 'Already Submitted' : 'Submit Assignment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSubmitted ? Colors.grey : Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}