import 'dart:async';

import 'package:QuizApp/models/QuizModel.dart';

import 'httpManager.dart';

abstract class ApiRepository {
  Future<QuizModel> getQuestions({id: 0});
}

class Api1 implements ApiRepository {
  @override
  Future<QuizModel> getQuestions({id: 0}) async {
    final result = await httpManager.get(
        url: 'https://opentdb.com/api.php?amount=' + id.toString());
    print(
        "assets/data/itemcategory.json [[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[[$result");
    return QuizModel.fromJson(result);
  }
}
