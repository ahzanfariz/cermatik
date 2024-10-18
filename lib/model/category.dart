import 'package:quizzie_thunder/model/question.dart';

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  List<Question>? question;

  Category({this.id, this.name, this.createdAt, this.updatedAt, this.question});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['question'] != null) {
      question = <Question>[];
      json['question'].forEach((v) {
        question!.add(new Question.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.question != null) {
      data['question'] = this.question!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
