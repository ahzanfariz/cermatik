class Question {
  int? id;
  // Null? image;
  String? subject;
  int? questionNumber;
  String? questionText;
  String? answerA;
  String? answerB;
  String? answerC;
  String? answerD;
  String? answerE;
  String? answerF;
  String? answerG;
  String? answerH;
  String? answerI;
  String? answerJ;
  String? type;
  List<String>? options;
  String? correctAnswer;
  int? correctionIndex;
  String? createdAt;
  String? updatedAt;
  int? categoryId;
  String? categoryName;

  Question(
      {this.id,
      // this.image,
      this.subject,
      this.questionNumber,
      this.questionText,
      this.answerA,
      this.answerB,
      this.answerC,
      this.answerD,
      this.answerE,
      this.answerF,
      this.answerG,
      this.answerH,
      this.answerI,
      this.answerJ,
      this.type,
      this.options,
      this.correctAnswer,
      this.correctionIndex,
      this.createdAt,
      this.updatedAt,
      this.categoryId,
      this.categoryName});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // image = json['image'];
    subject = json['subject'];
    questionNumber = json['question_number'];
    questionText = json['question_text'];
    answerA = json['answer_a'] == null ? "" : json['answer_a'];
    answerB = json['answer_b'] == null ? "" : json['answer_b'];
    answerC = json['answer_c'] == null ? "" : json['answer_c'];
    answerD = json['answer_d'] == null ? "" : json['answer_d'];
    answerE = json['answer_e'] == null ? "" : json['answer_e'];
    answerF = json['answer_f'] == null ? "" : json['answer_f'];
    answerG = json['answer_g'] == null ? "" : json['answer_g'];
    answerH = json['answer_h'] == null ? "" : json['answer_h'];
    answerI = json['answer_i'] == null ? "" : json['answer_i'];
    answerJ = json['answer_j'] == null ? "" : json['answer_j'];
    type = json['type'];
    options = [
      answerA!,
      answerB!,
      answerC!,
      answerD!,
      answerE!,
      answerF!,
      answerG!,
      answerH!,
      answerI!,
      answerJ!
    ];
    correctAnswer = json['correct_answer'];
    correctionIndex = options?.indexWhere((item) => item == correctAnswer);
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categoryId = json['category_id'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;

    // data['image'] = this.image;
    data['subject'] = this.subject;
    data['question_number'] = this.questionNumber;
    data['question_text'] = this.questionText;
    data['answer_a'] = this.answerA;
    data['answer_b'] = this.answerB;
    data['answer_c'] = this.answerC;
    data['answer_d'] = this.answerD;
    data['correct_answer'] = this.correctAnswer;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    return data;
  }
}
