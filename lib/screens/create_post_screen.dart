import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ut_social/blocs/post_bloc/post_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

import '../services/post_upload_repository.dart';

class CreatePostScreen extends StatefulWidget {
  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  File _image;
  final TextEditingController _captionController = TextEditingController();
  String _caption = '';
  bool _isLoading = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  dynamic _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  dynamic _iosBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: const Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.camera),
              child: const Text('Take Photo'),
            ),
            CupertinoActionSheetAction(
              onPressed: () => _handleImage(ImageSource.gallery),
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

  dynamic _androidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.camera),
              child: const Text('Take Photo'),
            ),
            SimpleDialogOption(
              onPressed: () => _handleImage(ImageSource.gallery),
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

  Future<void> _handleImage(ImageSource source) async {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile);
      setState(() {
        _image = imageFile;
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

  Future<void> _submit() async {
    if (!_isLoading && (_caption.isNotEmpty || _image != null)) {
      setState(() {
        _isLoading = true;
      });
      String imageUrl;
      // Create post
      if (_image != null) {
        imageUrl = await StorageService.uploadPost(_image);
      }
      final userState = BlocProvider.of<UserBloc>(context).state;
      if (userState is UserAuthenticated) {
        BlocProvider.of<PostsBloc>(context).add(AddPost(
          _caption,
          imageUrl,
          userState.currentUser,
        ));
      }

      // Reset data
      _captionController.clear();

      setState(() {
        _caption = '';
        _image = null;
        _isLoading = false;
      });
      BlocProvider.of<PostsBloc>(context).add(RefreshPosts());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        actions: <Widget>[
          FlatButton(
            onPressed: _submit,
            child: Text(
              'Post',
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
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
                GestureDetector(
                  onTap: _showSelectImageDialog,
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, top: 20),
                    height: width / 3,
                    width: width / 3,
                    color: Theme.of(context).backgroundColor,
                    child: _image == null
                        ? Icon(
                            SFSymbols.camera,
                            color: Colors.white70,
                            size: width / 6,
                          )
                        : Image(
                            image: FileImage(_image),
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _captionController,
                    style: const TextStyle(fontSize: 18.0),
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: 10,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      filled: false,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      hintText: "What's on your mind?",
                      alignLabelWithHint: true,
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.normal,
                      ),
                      // focusedBorder: UnderlineInputBorder(
                      //   borderSide: new BorderSide(color: Colors.grey),
                      // ),
                    ),
                    onChanged: (input) => _caption = input,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
