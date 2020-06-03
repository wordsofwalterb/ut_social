import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  String coverPhotoUrl;
  String avatarUrl;

  @override
  Widget build(BuildContext context) {
    final userState = BlocProvider.of<UserBloc>(context);
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
            child: ProfileAvatar(
              avatarUrl: '',
              radius: 100,
              size: 90,
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
      TextFormField(
        controller: _firstNameController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'First Name',
          // errorText: (state.error == 'Last name needs to be provided')
          //     ? state.error
          //     : null,
        ),
        autovalidate: false,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        // focusNode: _lastNameFocus,
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (term) {
        //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
        // },
      ),
      SizedBox(
        height: 3,
      ),
      TextFormField(
        controller: _lastNameController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Last Name',
          // errorText: (state.error == 'Last name needs to be provided')
          //     ? state.error
          //     : null,
        ),
        keyboardType: TextInputType.emailAddress,
        autovalidate: false,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        // focusNode: _lastNameFocus,
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (term) {
        //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
        // },
      ),
      SizedBox(
        height: 3,
      ),
      TextFormField(
        controller: _bioController,
        decoration: InputDecoration(
          alignLabelWithHint: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: 'Bio',
          // errorText: (state.error == 'Last name needs to be provided')
          //     ? state.error
          //     : null,
        ),
        keyboardType: TextInputType.emailAddress,
        autovalidate: false,
        autocorrect: false,
        textCapitalization: TextCapitalization.words,
        // focusNode: _lastNameFocus,
        textInputAction: TextInputAction.next,
        // onFieldSubmitted: (term) {
        //    _fieldFocusChange(context, _lastNameFocus, _emailFocus);
        // },
      ),
    ]);
  }
}
