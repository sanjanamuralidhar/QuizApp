import 'package:QuizApp/Component/TriviaButton.dart';
import 'package:QuizApp/screens/quizPage.dart';
import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget {
  final num total;
  const ScorePage({Key key, this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Center(
                  child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Text('Trivia App'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline4),
              )),
              SizedBox(height: 100),
              Text('Your Score is',
                  style: Theme.of(context).textTheme.headline6),
              Text("${total.toString()}/100",
                  style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 100),
              TriviaButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => QuizPage(),
                    ),
                  );
                },
                text: 'retake Trivia',
                width: 180,
              )
            ],
          ),
        ),
      ),
    );
  }
}
