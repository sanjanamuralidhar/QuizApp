import 'package:QuizApp/models/QuizModel.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class QuizState extends Equatable {}

class QuizInitialState extends QuizState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

class QuizLoadingState extends QuizState {
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [];
}

// ignore: must_be_immutable
class QuizLoadedState extends QuizState {

  List<ResultModel> details;

  QuizLoadedState({@required this.details});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [details];
}

// ignore: must_be_immutable
class QuizErrorState extends QuizState {

  String message;

 QuizErrorState({@required this.message});

  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => [message];
}