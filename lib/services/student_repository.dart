import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/models/failure.dart';
import 'package:ut_social/models/student.dart';

abstract class StudentRepository {
  Future<StudentResult> getStudentById(String id);
  Future<List<Student>> findStudentsByName(String keyword);
}

class StudentResult {
  final bool hasError;
  final Student student;
  final Failure error;

  const StudentResult({this.student, this.error, @required this.hasError});
}

class FirebaseStudentRepository extends StudentRepository {
  final FirebaseFirestore _firestore;

  FirebaseStudentRepository({
    FirebaseFirestore firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<List<Student>> findStudentsByName(String keyword) async {
    keyword.trim();
    // TODO: Use String buffer and move to seperate method
    final fullName = keyword.split(' ');
    final List<String> sanitizedWords = [];
    for (final word in fullName) {
      sanitizedWords
          .add(word[0].toUpperCase() + word.substring(1).toLowerCase());
    }
    final StringBuffer sanitizedFullKeyword = StringBuffer();
    for (final word in sanitizedWords) {
      sanitizedFullKeyword.write('$word ');
    }
    print(sanitizedFullKeyword.toString());

    final query = await _firestore
        .collection('students')
        .where('fullName',
            isGreaterThanOrEqualTo: sanitizedFullKeyword.toString().trim())
        .get();

    sanitizedFullKeyword.clear();

    return query.docs
        .map((e) =>
            Student.fromJson(e.data()..addAll(<String, dynamic>{'id': e.id})))
        .toList();
  }

  @override
  Future<StudentResult> getStudentById(String id) async {
    try {
      final document = await _firestore.collection('students').doc(id).get();
      if (document.data().isNotEmpty) {
        return StudentResult(
            student: Student.fromJson(
              document.data()..addAll(<String, dynamic>{'id': id}),
            ),
            hasError: false);
      } else {
        throw Failure('Profile info was not found', 'DATA_NULL');
      }
    } on Failure catch (e) {
      return StudentResult(error: e, hasError: true);
    } catch (e) {
      return StudentResult(
        error: Failure(
          'There was an error retrieving profile info',
          e.toString(),
        ),
        hasError: true,
      );
    }
  }
}
