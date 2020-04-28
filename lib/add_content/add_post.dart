import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ut_social/feed/post_bloc/post_bloc.dart';

import '../core/repositories/post_upload_repository.dart';

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

  _showSelectImageDialog() {
    return Platform.isIOS ? _iosBottomSheet() : _androidDialog();
  }

  _iosBottomSheet() {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Add Photo'),
          actions: <Widget>[
            CupertinoActionSheetAction(
              child: Text('Take Photo'),
              onPressed: () => _handleImage(ImageSource.camera),
            ),
            CupertinoActionSheetAction(
              child: Text('Choose From Gallery'),
              onPressed: () => _handleImage(ImageSource.gallery),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            child: Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        );
      },
    );
  }

  _androidDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Add Photo'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text('Take Photo'),
              onPressed: () => _handleImage(ImageSource.camera),
            ),
            SimpleDialogOption(
              child: Text('Choose From Gallery'),
              onPressed: () => _handleImage(ImageSource.gallery),
            ),
            SimpleDialogOption(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.redAccent,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  _handleImage(ImageSource source) async {
    Navigator.pop(context);
    FocusScope.of(context).unfocus();
    File imageFile = await ImagePicker.pickImage(source: source);
    if (imageFile != null) {
      imageFile = await _cropImage(imageFile) as File;
      setState(() {
        _image = imageFile;
      });
    }
  }

  _cropImage(File imageFile) async {
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    return croppedImage;
  }

  _submit() async {
    if (!_isLoading && _caption.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });
      String imageUrl;
      // Create post
      if (_image != null) {
        imageUrl = await StorageService.uploadPost(_image);
      }

      BlocProvider.of<PostBloc>(context).add(PostAdded(_caption, imageUrl));

      // Reset data
      _captionController.clear();

      setState(() {
        _caption = '';
        _image = null;
        _isLoading = false;
      });
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
              style: Theme.of(context).textTheme.subhead.copyWith(
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
                _isLoading
                    ? Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.blue[200],
                          valueColor: AlwaysStoppedAnimation(Colors.blue),
                        ),
                      )
                    : SizedBox.shrink(),
                GestureDetector(
                  onTap: _showSelectImageDialog,
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 20),
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
                SizedBox(height: 10.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextField(
                    controller: _captionController,
                    style: TextStyle(fontSize: 18.0),
                    autofocus: true,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
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
