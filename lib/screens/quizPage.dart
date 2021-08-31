import 'dart:developer';

import 'package:QuizApp/Component/TriviaButton.dart';
import 'package:QuizApp/bloc/bloc.dart';
import 'package:QuizApp/models/QuizModel.dart';
import 'package:QuizApp/screens/homePage.dart';
import 'package:QuizApp/screens/scorePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  QuizBloc _quizBloc;
  String _character;
  int count = 1;
  bool nextbutton = true;
  bool previousButton = false;
  int total = 0;
  int question = 1;

  void initState() {
    _quizBloc = BlocProvider.of<QuizBloc>(context);
    _quizBloc.add(FetchQuizEvent(id: count));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: _buildQuizBloc(),
    ));
  }

  Widget _buildQuizBloc() {
    return Container(
      child: BlocListener<QuizBloc, QuizState>(
        listener: (context, state) {
          if (state is QuizErrorState) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: BlocBuilder<QuizBloc, QuizState>(
          builder: (context, state) {
            if (state is QuizInitialState) {
              print('category initial state');
            } else if (state is QuizLoadingState) {
              print('Category Loading State');
            } else if (state is QuizLoadedState) {
              return quizDisplay(context, state.details);
            } else if (state is QuizErrorState) {
              return Container(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget quizDisplay(BuildContext context, List<ResultModel> quiz) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text('Trivia App'.toUpperCase(),
                style: Theme.of(context).textTheme.headline4),
          )),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("${question.toString()}."),
                SizedBox(
                  width: 10,
                ),
                Flexible(child: Text(quiz[0].question)),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Radio(
                    value: quiz[0].correctAnswer,
                    groupValue: _character,
                    onChanged: (value) {
                      setState(() {
                        _character = value;
                        total += 10;
                      });
                    },
                  ),
                  Text(quiz[0].correctAnswer),
                ],
              )),
          Container(
            height: 150,
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: quiz[0].incorrectAnswers.length,
                itemBuilder: (context, index) {
                  final item = quiz[0].incorrectAnswers[index];
                  return Row(
                    children: [
                      Radio(
                        value: item,
                        groupValue: _character,
                        onChanged: (value) {
                          setState(() {
                            _character = value;
                            total += 0;
                          });
                        },
                      ),
                      Row(
                        children: [
                          Text(item),
                        ],
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                // Previous button for going to previous question

                Align(
                  alignment: Alignment.bottomLeft,
                  child: previousButton
                      ? SizedBox(
                          width: 160,
                          child: FlatButton(
                              color: Colors.yellow[700],
                              onPressed: () {
                                setState(() {
                                  count--;
                                  _quizBloc.add(FetchQuizEvent(id: count));
                                  question--;
                                });
                                log(count.toString());
                                log(total.toString());
                                if (count == 1) {
                                  setState(() {
                                    previousButton = false;
                                  });
                                }
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Icon(Icons.arrow_back),
                                  ),
                                  SizedBox(width: 30),
                                  Align(
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('previous'.toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.blue[700])),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      : Text(''),
                ),

                // next button for going to previous question

                Align(
                  alignment: Alignment.bottomRight,
                  child: nextbutton
                      ? TriviaButton(
                          icon: Icons.arrow_forward,
                          onPressed: () {
                            setState(() {
                              count++;
                              _quizBloc.add(FetchQuizEvent(id: count));
                              previousButton = true;
                              question++;
                            });
                            log(count.toString());
                            log(total.toString());
                            if (count == 11) {
                              setState(() {
                                nextbutton = false;
                                Navigator.push<void>(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        ScorePage(
                                      total: total,
                                    ),
                                  ),
                                );
                              });
                            }
                          },
                          text: 'Next',
                          width: 150,
                        )
                      : ScorePage(
                          total: total,
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
