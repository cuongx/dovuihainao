import 'package:dovui_app/src/resource/model/question.dart';

class ProcessModel {
  int score;
  int offset;
  int heart;
  List<Question> questions;

  ProcessModel({this.questions, this.heart, this.offset, this.score});

  ProcessModel copyWith(
      {List<Question> questions, int heart, int offset, int score}) {
    return ProcessModel(questions: questions ?? this.questions,
        offset: offset ?? this.offset,
        score: score ?? this.score,
        heart : heart ?? this.heart);
  }

  ProcessModel.fromJson(dynamic json) {
    questions = json["questions"] != null
        ? Question.listFromJson(json["questions"])
        : [];
    score = json["score"];
    heart = json["heart"];
    offset = json["offset"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["questions"] = questions;
    map["score"] = score;
    map["heart"] = heart;
    map["offset"] = offset;
    return map;
  }
}
