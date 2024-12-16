import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quizeler/Quize.dart';
import 'package:quizeler/QuizeBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class QuizPage extends StatefulWidget {
  final String section; // Pass section to load respective quiz

  QuizPage(this.section);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int questionNumber = 0;
  late QuizeBrain quizeBrain;
  late List<Quize> currentQuiz;
  late int _timeRemaining;
  late Timer _timer;
  int totalscore = 0;

  @override
  void initState() {
    super.initState();
    quizeBrain = QuizeBrain();
    currentQuiz = quizeBrain.getQuizzes(widget.section);
    _timeRemaining = 30; // Initialize the timer
    _startTimer(); // Start the timer
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0 && _timeRemaining <= 30) {
          _timeRemaining--;
        } else {
          _timer.cancel();
          // Handle time's up logic
          Alert(
            context: context,
            title: "Game Over",
            desc: "Time's up!",
            buttons: [
              DialogButton(
                child: Text(
                  "Restart",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    questionNumber = 0;
                    scoreKeeper.clear();
                    _timeRemaining = 30;
                    _startTimer();
                  });
                },
              )
            ],
          ).show();
        }
      });
    });
  }

  @override
  void dispose() {
    _timeRemaining = 0;
    _timer.cancel(); // Cancel the timer to prevent memory leaks
    super.dispose();
  }

  void checkAnswer(bool userAnswer) {
    setState(() {
      if (questionNumber < currentQuiz.length - 1) {
        if (userAnswer == currentQuiz[questionNumber].mAnswer) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.green));
        } else {
          totalscore -= 1;
          scoreKeeper.add(Icon(Icons.close, color: Colors.red));
        }
        questionNumber++;
      } else {
        for (var i = 0; i < scoreKeeper.length + 1; i++) {
          totalscore += 1;
        }
        Alert(
          context: context,
          title: "Quiz Completed!",
          desc:
              "You've answered all the questions \n Your Score: ${currentQuiz.length} / ${totalscore}.",
          closeFunction: () {
            setState(() {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            });
          },
          buttons: [
            DialogButton(
              child: Text(
                "Restart",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  questionNumber = 0;
                  scoreKeeper.clear();
                  _timeRemaining = 30;
                  totalscore = 0;
                });
              },
            )
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("${widget.section} Quiz"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 40,
            ),
            // Question Card
            Expanded(
              flex: 5,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  // Question Card
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    width: 300,
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      top: 60.0,
                      bottom: 60.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 1,
                          blurRadius: 10,
                        )
                      ],
                    ),
                    child: Text(
                      currentQuiz[questionNumber].mQuize,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  // Circular Timer Overlapping the Card
                  Positioned(
                    top: -1, // Overlap value
                    left: 0,
                    right: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: CircularProgressIndicator(
                            value: _timeRemaining / 30,
                            strokeWidth: 8,
                            color: Colors.teal,
                            backgroundColor:
                                const Color.fromARGB(255, 173, 230, 217),
                          ),
                        ),
                        Text(
                          "$_timeRemaining",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // True Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => checkAnswer(true),
                child: Text(
                  'True',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            // False Button
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => checkAnswer(false),
                child: Text(
                  'False',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
            ),
            // Score Keeper
            Container(
              height: 40.0,
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
