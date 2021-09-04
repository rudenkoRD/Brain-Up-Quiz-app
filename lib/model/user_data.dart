class UserData {
  List<String> _featuredIds = List();
  Map<String, Map<String, String>> _completedQuizData = Map<String, Map<String, String>>();

  List<String> get featuredIds => _featuredIds;
  Map<String, Map<String, String>> get completedQuizData => _completedQuizData;

  Map<String, dynamic> toMap(){
    return {
      'featuredIds' : _featuredIds,
      'completedQuizData' : _completedQuizData
    };
  }

  UserData.fromJson(Map<String, dynamic> data){
    if(data.isEmpty) return;

    _featuredIds = data['featuredIds'].cast<String>();
    (data['completedQuizData']  as Map<String, dynamic>).forEach((key, value) {
      _completedQuizData.putIfAbsent(key, () => Map<String,String>.from(value));
    });
  }

  UserData();
}