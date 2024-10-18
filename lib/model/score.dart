class Score {
  int? categoryId;
  String? categoryName;
  String? averageScore;

  Score({this.categoryId, this.categoryName, this.averageScore});

  Score.fromJson(Map<String, dynamic> json) {
    categoryId = json['category_id'];
    categoryName = json['category_name'];
    averageScore = json['average_score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category_id'] = this.categoryId;
    data['category_name'] = this.categoryName;
    data['average_score'] = this.averageScore;
    return data;
  }
}
