import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ut_social/blocs/profile_info_bloc/profile_info_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/services/post_upload_repository.dart';
import 'package:ut_social/widgets/profile_avatar.dart';

import '../widgets/cover_photo.dart';

enum ImageToChange {
  profileImage,
  coverImage,
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  UserAuthenticated userState;
  File coverPhotoFile;
  File avatarFile;
  bool _isLoading = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    // avatarFile.delete();
    // coverPhotoFile.delete();
    super.dispose();
  }

  Future<void> _editProfile() async {
    setState(() {
      _isLoading = true;
    });

    String firstName;
    if (_firstNameController.text.isNotEmpty) {
      firstName = _firstNameController.text;
    }

    String lastName;
    if (_lastNameController.text.isNotEmpty) {
      lastName = _lastNameController.text;
    }

    String bio;
    if (_bioController.text.isNotEmpty) {
      bio = _bioController.text;
    }

    String avatarUrl;
    if (avatarFile != null) {
      avatarUrl = await StorageService.uploadUserProfileImage(
          userState.currentUser.avatarUrl ?? '', avatarFile);
    }

    String coverPhotorUrl;
    if (coverPhotoFile != null) {
      coverPhotorUrl = await StorageService.uploadUserCoverPhotoImage(
          userState.currentUser.coverPhotoUrl ?? '', coverPhotoFile);
    }

    BlocProvider.of<UserBloc>(context).add(
      UpdateUserProfile(
        firstName: firstName,
        lastName: lastName,
        bio: bio,
        avatarUrl: avatarUrl,
        coverPhotoUrl: coverPhotorUrl,
      ),
    );

    setState(() {
      _isLoading = false;
    });
    BlocProvider.of<ProfileInfoBloc>(context).add(const LoadProfile());

    Navigator.of(context).pop();
    // Posts
    // Comments
    // Students
  }

  Future<void> _showSelectImageDialog(ImageToChange toChange) {
    return Platform.isIOS
        ? _iosBottomSheet(toChange)
        : _androidDialog(toChange);
  }

  Future<void> _iosBottomSheet(ImageToChange toChange) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.camera, toChange),
              child: const Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.gallery, toChange),
              child: const Text('Choose From Gallery'),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        );
      },
    );
  }

  Future<void> _androidDialog(ImageToChange toChange) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.camera, toChange),
              child: const Text('Take Photo'),
            ),
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.gallery, toChange),
              child: const Text('Choose From Gallery'),
            ),
            SimpleDialogOption(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _handleImage(ImageSource source, ImageToChange toChange) async {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        switch (toChange) {
          case ImageToChange.profileImage:
            {
              avatarFile = imageFile;
              break;
            }
          case ImageToChange.coverImage:
            {
              coverPhotoFile = imageFile;
              break;
            }
        }
      });
    }
  }

  Future<File> _cropImage(File imageFile) async {
    final File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  @override
  Widget build(BuildContext context) {
    userState = BlocProvider.of<UserBloc>(context).state as UserAuthenticated;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).backgroundColor,
          title: const Text(
            'Edit Profile',
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 14),
                child: GestureDetector(
                  onTap: _editProfile,
                  child: Text(
                    'Done',
                    style: TextStyle(
                      color: const Color(0xffce7224),
                      fontSize: 16,
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            if (_isLoading)
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: LinearProgressIndicator(
                  backgroundColor: Colors.blue[200],
                  valueColor: const AlwaysStoppedAnimation(Colors.blue),
                ),
              )
            else
              const SizedBox.shrink(),
            _coverPhoto(),
            _profilePhoto(),
            _textFields(),
          ]),
        ));
  }

  Widget _coverPhoto() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 17, 19, 10),
      child: CoverPhoto(
        onPressed: () => _showSelectImageDialog(ImageToChange.coverImage),
        fileImage: (coverPhotoFile != null) ? FileImage(coverPhotoFile) : null,
        height: 120,
        width: double.infinity,
        coverPhotoUrl: userState.currentUser.coverPhotoUrl,
      ),
    );
  }

  Widget _profilePhoto() {
    return ProfileAvatar(
      onPressed: () => _showSelectImageDialog(ImageToChange.profileImage),
      avatarUrl: userState.currentUser.avatarUrl,
      fileImage: (avatarFile != null) ? FileImage(avatarFile) : null,
      radius: 100,
      size: 90,
    );
  }

  Widget _textFields() {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Container(
        decoration: const BoxDecoration(
            border: Border(
          top: BorderSide(
            color: Color(0xff3d3d3d),
          ),
          bottom: BorderSide(
            color: Color(0xff3d3d3d),
          ),
        )),
        child: TextFormField(
          style: TextStyle(
            color: const Color(0xfff1f1f1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          controller: _firstNameController,
          decoration: InputDecoration(
            filled: false,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'First Name',
                style: TextStyle(
                  color: const Color(0xfff1f1f1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: userState.currentUser.firstName,
            // errorText: (state.error == 'Last name needs to be provided')
            //     ? state.error
            //     : null,
          ),
          autovalidate: false,
          autocorrect: false,
          textCapitalization: TextCapitalization.words,
          // focusNode: _lastNameFocus,
          textInputAction: TextInputAction.done,
          // onFieldSubmitted: (term) {
          //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
          // },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color(0xff3d3d3d),
          ),
        )),
        child: TextFormField(
          style: TextStyle(
            color: const Color(0xfff1f1f1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          controller: _lastNameController,
          decoration: InputDecoration(
            filled: false,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'Last Name',
                style: TextStyle(
                  color: const Color(0xfff1f1f1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: userState.currentUser.lastName,
            // errorText: (state.error == 'Last name needs to be provided')
            //     ? state.error
            //     : null,
          ),
          autovalidate: false,
          autocorrect: false,
          textCapitalization: TextCapitalization.words,
          // focusNode: _lastNameFocus,
          textInputAction: TextInputAction.done,
          // onFieldSubmitted: (term) {
          //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
          // },
        ),
      ),
      const SizedBox(
        height: 3,
      ),
      Container(
        decoration: const BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color(0xff3d3d3d),
          ),
        )),
        child: TextFormField(
          maxLines: 3,
          style: TextStyle(
            color: const Color(0xfff1f1f1),
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          controller: _bioController,
          decoration: InputDecoration(
            filled: false,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Container(
              padding: const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'Bio',
                style: TextStyle(
                  color: const Color(0xfff1f1f1),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            alignLabelWithHint: true,
            floatingLabelBehavior: FloatingLabelBehavior.never,

            hintText: userState.currentUser.bio,
            // errorText: (state.error == 'Last name needs to be provided')
            //     ? state.error
            //     : null,
          ),
          autovalidate: false,
          autocorrect: false,
          textCapitalization: TextCapitalization.sentences,
          // focusNode: _lastNameFocus,
          textInputAction: TextInputAction.done,
          // onFieldSubmitted: (term) {
          //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
          // },
        ),
      ),
    ]);
  }
}
