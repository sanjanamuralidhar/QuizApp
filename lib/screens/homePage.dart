import 'package:QuizApp/Component/TriviaButton.dart';
import 'package:QuizApp/screens/quizPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Trivia App'.toUpperCase(),
                  style: Theme.of(context).textTheme.headline4),
              TriviaButton(
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => QuizPage(),
                    ),
                  );
                },
                text: 'Take Trivia',
                width: 160,
              )
            ],
          ),
        ),
      ),
    );
  }
}
