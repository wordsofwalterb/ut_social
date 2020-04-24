// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/foundation.dart';
// import 'package:ut_social/core/entities/student.dart';
// import 'package:ut_social/core/repositories/user_repository.dart';
// import 'package:ut_social/core/util/globals.dart';

// abstract class Model extends Equatable {
//   final String id;

//   Model(this.id);

//   @override
//   List<Object> get props => [id];
// }

// abstract class LikeRepository<M extends Model> {
//   Future<void> like(String id);
//   Future<void> unlike(String id);
//   Future<List<String>> retrieveLikedIds();
// }

// class PostLikeRepository extends LikeRepository {
//   UserRepository _userRepository;
//   Student _currentUser;

//   PostLikeRepository(this._userRepository);

//   Future<void> like(String id) async {
//     await Global.postsRef.document(id).updateData({
//       'likeCount': FieldValue.increment(1),
//     });

//     await Global.studentsRef.document(userId).setData({
//       'likedPosts': FieldValue.arrayUnion([postId]),
//     }, merge: true);
//   }

//   Future<void> unlike(String id) {}
//   Future<List<String>> retrieveLikedIds() {}
// }

// class LikeData extends Model {
//   final int likeCount;
//   final List<String> likedByIds;

//   LikeData(String id, this.likeCount, this.likedByIds): super(id);

//   @override
//   List<Object> get props => [id,likeCount,likedByIds];
// }

// class LikeProvider extends ChangeNotifier {
//   List<LikeData> _likedObjects = [];
//   LikeRepository _likeRepository;

//   LikeProvider(this._likedObjects, this._likeRepository);

//   bool initialized = false;

//   bool isLiked(String id) => _likedObjects.contains(id);

//   int likeCount(String id) => 

//   Future<void> setLiked(List<String> liked) {
//     _likedObjects = liked;
//     notifyListeners();
//   }

//   Future<void> like(String id) async {
//     if(_likedObjects.contains()){
//       _likedObjects.
//     }
//     _likedObjects.add(id);
//     await _likeRepository.like(id);
//     notifyListeners();
//   }

//   Future<void> unlike(String id, String likedBy) async {
    
//     await _likeRepository.unlike(id);
//     notifyListeners();
//   }

//   Future<void> initialize() async {
//     if (!initialized) {
//       var likedIds = await _likeRepository.retrieveLikedIds();
//       setLiked(likedIds);
//       initialized = true;
//     }
//   }
// }
