import 'package:flutter/material.dart';
import 'package:quizeler/screen/quize_page.dart';
import 'package:quizeler/screen/widget/quizecard_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          QuizCardButton(
            title: "Colour Prediction",
            icon: Icons.palette,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizPage("Colour Prediction")),
              );
            },
          ),
          QuizCardButton(
            title: "Wildlife Quiz",
            icon: Icons.pets,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage("Wildlife")),
              );
            },
          ),
          QuizCardButton(
            title: "Math Quiz",
            icon: Icons.calculate,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage("Math")),
              );
            },
          ),
          QuizCardButton(
            title: "Word Check Quiz",
            icon: Icons.text_fields,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => QuizPage("Word Check")),
              );
            },
          ),
        ],
      ),
    );
  }
}
