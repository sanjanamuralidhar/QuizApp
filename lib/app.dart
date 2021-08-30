import 'package:QuizApp/api/api.dart';
import 'package:QuizApp/bloc/bloc.dart';
import 'package:QuizApp/screens/homePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  QuizBloc quizBloc;

  @override
  void initState() {
    ///Bloc business logic
    quizBloc = QuizBloc(repository: Api1());
    super.initState();
  }

  @override
  void dispose() {
    quizBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<QuizBloc>(
          create: (context) => quizBloc,
        ),
      ],
      child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: HomePage()
                )
    );}}
