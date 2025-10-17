import 'package:flutter/material.dart';
import 'package:lmsalfa/models/lesson.dart';
import 'package:lmsalfa/models/user.dart'; // ✅ Added for currentUser

class QuizScreen extends StatefulWidget {
  final Lesson lesson;
  final User? currentUser; // ✅ Optional user for future tracking

  const QuizScreen({
    super.key,
    required this.lesson,
    this.currentUser,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is Flutter?',
      'options': ['A database', 'A UI toolkit', 'A backend server', 'A language'],
      'answerIndex': 1,
    },
    {
      'question': 'Which widget is used for layout?',
      'options': ['Text', 'Column', 'Button', 'Image'],
      'answerIndex': 1,
    },
    {
      'question': 'What language does Flutter use?',
      'options': ['Java', 'Kotlin', 'Dart', 'Swift'],
      'answerIndex': 2,
    },
  ];

  final Map<int, int> _selectedAnswers = {};
  bool _submitted = false;

  int get _score {
    int score = 0;
    for (var i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i]['answerIndex']) {
        score++;
      }
    }
    return score;
  }

  void _submitQuiz() {
    setState(() => _submitted = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('✅ You scored $_score / ${_questions.length}')),
    );

    // ✅ Future: Save score to Hive or user profile
    // if (widget.currentUser != null) { ... }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Quiz: ${widget.lesson.title}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: _questions.length,
          itemBuilder: (_, index) {
            final question = _questions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Q${index + 1}: ${question['question']}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...List.generate(question['options'].length, (optIndex) {
                      final isSelected = _selectedAnswers[index] == optIndex;
                      final isCorrect = _submitted &&
                          optIndex == question['answerIndex'];
                      final isWrong = _submitted &&
                          isSelected &&
                          optIndex != question['answerIndex'];

                      return ListTile(
                        title: Text(question['options'][optIndex]),
                        leading: Radio<int>(
                          value: optIndex,
                          groupValue: _selectedAnswers[index],
                          onChanged: _submitted
                              ? null
                              : (val) => setState(() =>
                          _selectedAnswers[index] = val!),
                        ),
                        tileColor: isCorrect
                            ? Colors.green.shade100
                            : isWrong
                            ? Colors.red.shade100
                            : null,
                      );
                    }),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          icon: const Icon(Icons.check),
          label: const Text('Submit Quiz'),
          onPressed: _submitted ? null : _submitQuiz,
        ),
      ),
    );
  }
}