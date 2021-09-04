import 'package:schoollearning/model/date.dart';
import 'package:schoollearning/model/quiz/questions/question.dart';
import 'package:schoollearning/generated/l10n.dart';


class Quiz {
  String id;
  String _title;
  String _subject;
  String _author;
  double _difficulty;
  int _positiveMarks;
  int _negativeMarks;
  int _completedTimes;
  Date _createdAtDate;
  List<Question> _questionsList = new List();

  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      'subject': _subject,
      'author': _author,
      'difficulty': _difficulty,
      'positiveMarks': _positiveMarks,
      'negativeMarks': _negativeMarks,
      'completedTimes': _completedTimes,
      'createdAt': _createdAtDate.dateTime,
      'questionList':
          _questionsList.map((q) => mapQuestion(q)).toList(),
    };
  }

  Quiz.fromJson(String id, Map<String, dynamic> data) {
    this.id = id;
    _title = data['title'];
    _subject = data['subject'];
    _author = data['author'];
    _difficulty = data['difficulty'];
    _positiveMarks = data['positiveMarks'];
    _negativeMarks = data['negativeMarks'];
    _completedTimes = data['completedTimes'];
    _createdAtDate = Date.fromString(data['createdAt']);

    (data['questionList'] as List).forEach((element) {
      _questionsList.add(fromJsonQuestion(element));
    });

  }

  Quiz.newEmpty() {
    _completedTimes = 0;
    _positiveMarks = 0;
    _negativeMarks = 0;
    _difficulty = 0;
    _createdAtDate = new Date.now();
  }
  Quiz(
    this._title,
    this._difficulty,
    this._positiveMarks,
    this._negativeMarks,
    this._completedTimes,
    this._author,
    this._subject,
  );

  String get title => _title;
  double get difficulty => _difficulty;
  int get positiveMarks => _positiveMarks;
  int get negativeMarks => _negativeMarks;
  int get completedTimes => _completedTimes;
  String get subject => _subject;
  String get author => _author;
  String get createdAtDate => _createdAtDate.dateString;

  List<Question> get questions => _questionsList;
  void addQuestion(Question question) {
    _questionsList.add(question);
  }

  void setTitle(String newTitle) => _title = newTitle;
  void setSubject(String newSubject) => _subject = newSubject;
  void setAuthor(String author) => _author = author;
  set completedTimes(newValue) => _completedTimes = newValue;
  set difficulty(newValue) => _difficulty = newValue;
  set positiveMarks(newValue) => _positiveMarks = newValue;
  set negativeMarks(newValue) => _negativeMarks = newValue;

  String difficultyTitle(context) {
    if(_completedTimes == 0) return S.of(context).unknown_label;
    if (100 - _difficulty < 20) return S.of(context).easy_label;
    if (100 - _difficulty < 40) return S.of(context).medium_label;
    if (100 - _difficulty < 95) return S.of(context).hard_label;

    return S.of(context).insane_label;
  }
}
