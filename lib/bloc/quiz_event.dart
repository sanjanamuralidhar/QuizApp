import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable{}

class FetchQuizEvent extends QuizEvent {
  final int id;

  FetchQuizEvent({this.id});
  @override
  // ignore: todo
  // TODO: implement props
  List<Object> get props => null;
}