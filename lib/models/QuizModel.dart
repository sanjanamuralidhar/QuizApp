import 'dart:convert';

class QuizModel {
  QuizModel({
    this.responseCode,
    this.results,
  });

  int responseCode;
  List<ResultModel> results;

  @override
  String toString() {
    return toJson().toString();
  }

  QuizModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return;
    responseCode = json['responseCode'];
    results = _setList(json['results']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    if (responseCode != null) json['responseCode'] = responseCode;
    if (results != null) json['results'] = results;
    return json;
  }

  static List<ResultModel> _setList(list) {
    if (list != null) {
      final Iterable refactorFeature = list;
      return refactorFeature.map((item) {
        return ResultModel.fromJson(item);
      }).toList();
    }
    return null;
  }

  static List<QuizModel> listFromJson(List<dynamic> json) {
    return json == null
        ? List<QuizModel>()
        : json.map((value) => QuizModel.fromJson(value)).toList();
  }
}

class ResultModel {
  ResultModel({
    this.category,
    this.type,
    this.difficulty,
    this.question,
    this.correctAnswer,
    this.incorrectAnswers,
  });

  String category;
  Type type;
  Difficulty difficulty;
  String question;
  String correctAnswer;
  List<String> incorrectAnswers;

  @override
  String toString() {
    return toJson().toString();
  }

  factory ResultModel.fromJson(Map<String, dynamic> json) => ResultModel(
        category: json["category"],
        type: typeValues.map[json["type"]],
        difficulty: difficultyValues.map[json["difficulty"]],
        question: json["question"],
        correctAnswer: json["correct_answer"],
        incorrectAnswers:
            List<String>.from(json["incorrect_answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "type": typeValues.reverse[type],
        "difficulty": difficultyValues.reverse[difficulty],
        "question": question,
        "correct_answer": correctAnswer,
        "incorrect_answers": List<dynamic>.from(incorrectAnswers.map((x) => x)),
      };
}

enum Difficulty { MEDIUM, EASY, HARD }

final difficultyValues = EnumValues({
  "easy": Difficulty.EASY,
  "hard": Difficulty.HARD,
  "medium": Difficulty.MEDIUM
});

enum Type { BOOLEAN, MULTIPLE }

final typeValues =
    EnumValues({"boolean": Type.BOOLEAN, "multiple": Type.MULTIPLE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
