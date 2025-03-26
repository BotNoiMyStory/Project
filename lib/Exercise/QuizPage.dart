import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class QuizPage extends StatefulWidget {
  final String quranName;
  final String userName;

  QuizPage({required this.quranName, required this.userName});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<dynamic> questions = [];
  bool isLoading = true;
  List<String> selectedAnswers = [];
  List<bool> answersChecked = [];
  List<bool> isCorrect = [];
  int attemptNumber = 1;

  @override
  void initState() {
    super.initState();
    print('Received Quran Name: ${widget.quranName}');
    print('Received User Name: ${widget.userName}');
    fetchQuizData();
  }

  Future<void> fetchQuizData() async {
    final url =
        Uri.parse('https://webmastergame.shop/AppQuran/quranquizall.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      try {
        var data = json.decode(response.body);
        var filteredData = data
            .where((item) => item['quran_name'] == widget.quranName)
            .toList();

        if (filteredData.isNotEmpty) {
          var questionsData = filteredData[0]['quiz_question']['questions'];
          setState(() {
            questions = questionsData;
            selectedAnswers = List.generate(questions.length, (index) => '');
            answersChecked = List.generate(questions.length, (index) => false);
            isCorrect = List.generate(questions.length, (index) => false);
            isLoading = false;
          });
        } else {
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool checkAnswer(int index, String selectedOption) {
    var correctAnswer = questions[index]['correct_answer'];
    return correctAnswer != null &&
        correctAnswer
            .trim()
            .toLowerCase()
            .startsWith(selectedOption.trim().toLowerCase());
  }

  void submitScore() async {
    int score = 0;
    for (int i = 0; i < questions.length; i++) {
      if (isCorrect[i]) {
        score++;
      }
    }

    var result = {
      'quran_name': widget.quranName,
      'username': widget.userName,
      'attempt_number': attemptNumber,
      'attempt_date': DateTime.now().toIso8601String(),
      'total_score': score,
      'total_questions': questions.length,
      'answers': List.generate(questions.length, (index) {
        return {
          'question_text': questions[index]['question_text'] ?? 'No Question',
          'selected_answer': selectedAnswers[index],
          'is_correct': isCorrect[index],
        };
      }),
    };

    // ส่งข้อมูลไปยัง PHP
    final url = Uri.parse('https://webmastergame.shop/AppQuran/answer.php');
    final response = await http.post(
      url,
      body: jsonEncode(result), // ส่งข้อมูลในรูปแบบ JSON
      headers: {'Content-Type': 'application/json'}, // ระบุประเภทข้อมูลที่ส่ง
    );

    if (response.statusCode == 200) {
      // หากบันทึกสำเร็จ
      print('ข้อมูลถูกบันทึกแล้ว');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ผลคะแนน'),
            content: Text('คะแนนที่ได้: $score / ${questions.length}'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text('ตกลง'),
              ),
            ],
          );
        },
      );
    } else {
      // หากมีข้อผิดพลาด
      print('เกิดข้อผิดพลาดในการบันทึกข้อมูล');
    }

    setState(() {
      attemptNumber++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
            padding: const EdgeInsets.only(top: 23),
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  MdiIcons.arrowLeft,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'แบบฝึกหัด - ${widget.quranName}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Google-Font',
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ])),
        backgroundColor: Color(0xFF006400),
        toolbarHeight: 80,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : questions.isEmpty
              ? Center(child: Text('No Questions Available'))
              : ListView.builder(
                  itemCount: questions.length,
                  itemBuilder: (context, index) {
                    var question = questions[index];
                    var options = (question['options'] as Map<String, dynamic>?)
                            ?.map((key, value) =>
                                MapEntry(key, value.toString())) ??
                        {};

                    return Card(
                      margin: EdgeInsets.all(10),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              question['question_text'] ?? 'No Question',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            ...options.entries.map((entry) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    if (!answersChecked[index]) {
                                      setState(() {
                                        selectedAnswers[index] = entry.key;
                                        answersChecked[index] = true;
                                        isCorrect[index] =
                                            checkAnswer(index, entry.key);
                                      });
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      Radio<String>(
                                        value: entry.key,
                                        groupValue: selectedAnswers[index],
                                        onChanged: answersChecked[index]
                                            ? null
                                            : (String? value) {
                                                setState(() {
                                                  selectedAnswers[index] =
                                                      value!;
                                                  answersChecked[index] = true;
                                                  isCorrect[index] =
                                                      checkAnswer(index, value);
                                                });
                                              },
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${entry.key}. ${entry.value}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                            SizedBox(height: 10),
                            answersChecked[index]
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: isCorrect[index]
                                          ? Colors.green[100]
                                          : Colors.red[100],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isCorrect[index]
                                            ? Colors.green
                                            : Colors.red,
                                        width: 2,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          isCorrect[index]
                                              ? MdiIcons.checkCircle
                                              : MdiIcons.cancel,
                                          color: isCorrect[index]
                                              ? Colors.green
                                              : Colors.red,
                                          size: 24,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          isCorrect[index]
                                              ? 'คำตอบถูกต้อง'
                                              : 'คำตอบไม่ถูกต้อง',
                                          style: TextStyle(
                                              color: isCorrect[index]
                                                  ? Colors.green
                                                  : Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: GestureDetector(
          onTap: submitScore, // เรียกใช้ submitScore()
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              'ยืนยันคำตอบ',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFFF6400),
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
