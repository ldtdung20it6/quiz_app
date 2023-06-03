class Quiz {
  int? id;
  String? quiz_num;
  String? question;
  String? correct_answer;
  Quiz(
    this.id,
    this.quiz_num,
    this.question,
    this.correct_answer,
  );
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'quiz_num': quiz_num,
      'question': question,
      'correct_answer': correct_answer,
    };
    return map;
  }

  Quiz.fromMap(Map<String, dynamic> map) {
      id = map['id'];
      quiz_num = map["quiz_num"];
      question = map["question"];
      correct_answer = map["correct_answer"];
    
  }
}
