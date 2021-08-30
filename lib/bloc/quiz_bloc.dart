import 'package:QuizApp/api/api.dart';
import 'package:QuizApp/models/QuizModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {

  ApiRepository repository;
  int i = 0;

  QuizBloc({@required this.repository}) : super(null);

  @override
  // ignore: todo
  // TODO: implement initialState
  // ignore: override_on_non_overriding_member
  QuizState get initialState => QuizInitialState();

  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is FetchQuizEvent) {
      yield QuizLoadingState();
      try {
        QuizModel details = await repository.getQuestions(
          id:event.id
        );
        print('............bloc ......${details.results}');
        yield QuizLoadedState(details: details.results);
      } catch (e) {
        yield QuizErrorState(message: e.toString());
      }
    }
  }

}