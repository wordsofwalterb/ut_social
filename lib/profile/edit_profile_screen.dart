import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ut_social/core/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/core/widgets/profile_avatar.dart';

import 'widgets/cover_photo.dart';

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

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  dynamic _showSelectImageDialog(File file) {
    return Platform.isIOS ? _iosBottomSheet(file) : _androidDialog(file);
  }

  dynamic _iosBottomSheet(File file) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.camera, file),
              child: const Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.gallery, file),
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

  dynamic _androidDialog(File file) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.camera, file),
              child: const Text('Take Photo'),
            ),
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.gallery, file),
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

  Future<void> _handleImage(ImageSource source, File file) async {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        avatarFile = imageFile;
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
                child: Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xffce7224),
                    fontSize: 16,
                    fontFamily: 'SFProText',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _changeImages(),
            _textFields(),
          ]),
        ));
  }

  Widget _changeImages() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(19, 17, 19, 50),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Stack(
            children: [
              GestureDetector(
                onTap: null,
                child: CoverPhoto(
                  height: 120,
                  coverPhotoUrl: '',
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -42,
            left: 15,
            child: GestureDetector(
              onTap: () => _showSelectImageDialog(avatarFile),
              child: ProfileAvatar(
                avatarUrl: userState.currentUser.avatarUrl,
                radius: 100,
                size: 90,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textFields() {
    return Column(children: [
      SizedBox(
        height: 20,
      ),
      Container(
        decoration: BoxDecoration(
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
            color: Color(0xfff1f1f1),
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
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'First Name',
                style: TextStyle(
                  color: Color(0xfff1f1f1),
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
      SizedBox(
        height: 3,
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color(0xff3d3d3d),
          ),
        )),
        child: TextFormField(
          style: TextStyle(
            color: Color(0xfff1f1f1),
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
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'Last Name',
                style: TextStyle(
                  color: Color(0xfff1f1f1),
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
      SizedBox(
        height: 3,
      ),
      Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            color: Color(0xff3d3d3d),
          ),
        )),
        child: TextFormField(
          maxLines: 3,
          style: TextStyle(
            color: Color(0xfff1f1f1),
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
              padding: EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width * .35,
              child: Text(
                'Bio',
                style: TextStyle(
                  color: Color(0xfff1f1f1),
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
          textCapitalization: TextCapitalization.words,
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
