import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

// TODO: Refactor to Repository
// TODO: Refactor into fewer methods
class StorageService {
  static Future<String> uploadUserProfileImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();
    final File image = await compressImage(photoId, imageFile);
    // TODO: FIX AND MAKE SURE STORAGE DOESN't FILL UP UNNECESARILLY

    // if (url.isNotEmpty) {
    //   // Updating user profile image
    //   final RegExp exp = RegExp(r'userProfile_(.*).jpg');
    //   photoId = exp.firstMatch(url)[1];
    // }

    final StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images/users/userProfile_$photoId.jpg')
        .putFile(image);
    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    final String downloadUrl = await storageSnap.ref.getDownloadURL() as String;
    return downloadUrl;
  }

  static Future<String> uploadUserCoverPhotoImage(
      String url, File imageFile) async {
    String photoId = Uuid().v4();
    final File image = await compressImage(photoId, imageFile);

    if (url.isNotEmpty) {
      // Updating user profile image
      final RegExp exp = RegExp(r'userCoverPhoto_(.*).jpg');
      photoId = exp.firstMatch(url)[1];
    }

    final StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images/users/userCoverPhoto_$photoId.jpg')
        .putFile(image);
    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    final String downloadUrl = await storageSnap.ref.getDownloadURL() as String;
    return downloadUrl;
  }

  static Future<File> compressImage(String photoId, File image) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final File compressedImageFile =
        await FlutterImageCompress.compressAndGetFile(
      image.absolute.path,
      '$path/img_$photoId.jpg',
      quality: 70,
    );
    return compressedImageFile;
  }

  static Future<String> uploadPost(File imageFile) async {
    final String photoId = Uuid().v4();
    final File image = await compressImage(photoId, imageFile);
    final StorageUploadTask uploadTask = FirebaseStorage.instance
        .ref()
        .child('images/posts/post_$photoId.jpg')
        .putFile(image);
    final StorageTaskSnapshot storageSnap = await uploadTask.onComplete;
    final String downloadUrl = await storageSnap.ref.getDownloadURL() as String;
    return downloadUrl;
  }
}
