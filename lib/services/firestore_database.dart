import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoollearning/models/quiz/quiz.dart';
import 'package:schoollearning/models/user.dart';
import 'package:schoollearning/models/user_data.dart';

class FirestoreService {
  final CollectionReference _quizCollection =
      FirebaseFirestore.instance.collection('quiz');
  
  final CollectionReference _usersDataCollection =
  FirebaseFirestore.instance.collection('users');

  Future<String> addOrUpdateQuiz(Quiz quiz) async {
    DocumentReference docRef = _quizCollection.doc(quiz.id);

    return await docRef.set(quiz.toMap()).then((_) => docRef.id);
  }

  Stream<List<Quiz>> getQuizList() {
    return _quizCollection.snapshots().map((QuerySnapshot data) =>
        data.docs
            .map((DocumentSnapshot doc) =>
                Quiz.fromJson(doc.id, doc.data()))
            .toList());
  }

  Stream<UserData> getUsersData(String usersId){
    return _usersDataCollection.doc(usersId).snapshots().map((DocumentSnapshot doc) {
      if(doc.exists)
        return UserData.fromJson(doc.data());
      else return UserData();
    });
  }

  Stream<List<Quiz>> getUsersQuizList(AppUser user){
    return _quizCollection.where('author', isEqualTo: user.username).snapshots().map((QuerySnapshot data) =>
        data.docs
            .map((DocumentSnapshot doc) =>
            Quiz.fromJson(doc.id, doc.data()))
            .toList());
  }

  Stream<List<Quiz>> getFeaturedQuizList(List<String> featuredIds){
    return _quizCollection.where('__name__', whereIn: featuredIds.isEmpty ? [' '] : featuredIds).snapshots().map((QuerySnapshot data) =>
        data.docs.map((DocumentSnapshot doc) =>
        Quiz.fromJson(doc.id, doc.data()))
        .toList());
  }

  Future addOrUpdateUserData(AppUser user) async{
    return await _usersDataCollection.doc(user.uid).set(user.userData.toMap()).then((value) => print('write'));
  }

  Future deleteQuiz(Quiz quiz) async {
    return await _quizCollection.doc(quiz.id).delete();
  }
}
