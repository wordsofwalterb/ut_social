import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:ut_social/core/entities/error.dart';
import 'package:ut_social/core/entities/student.dart';

abstract class StudentRepository {
  Future<StudentResult> getStudentById(String id);
}

class StudentResult {
  final bool hasError;
  final Student student;
  final Failure error;

  const StudentResult({this.student, this.error, @required this.hasError});
}

class FirebaseStudentRepository extends StudentRepository {
  final Firestore _firestore;

  FirebaseStudentRepository({
    Firestore firestore,
  }) : _firestore = firestore ?? Firestore.instance;

  @override
  Future<StudentResult> getStudentById(String id) async {
    try {
      final document =
          await _firestore.collection('students').document(id).get();
      if (document.data.isNotEmpty) {
        return StudentResult(
            student: Student.fromMap(document.data), hasError: false);
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
