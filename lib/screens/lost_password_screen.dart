import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:ut_social/models/failure.dart';

class LostPasswordScreen extends StatefulWidget {
  @override
  _LostPasswordScreenState createState() => _LostPasswordScreenState();
}

class _LostPasswordScreenState extends State<LostPasswordScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  Failure error;
  String result;
  bool hasError = false;
  bool isSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Future<void> _resetPassword() async {
    try {
      // _submitingPopup();ytt
      await _firebaseAuth.sendPasswordResetEmail(email: _emailController.text);
      setState(() {
        result = 'A password reset link has been sent to the entered address';
        isSuccess = true;
        hasError = false;
      });
    } on PlatformException catch (error) {
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          setState(() {
            result = 'Email address not found';
            hasError = true;
            isSuccess = false;
          });
          // _errorPopup();
          break;
        case 'ERROR_WRONG_PASSWORD':
          setState(() {
            result = 'Password is incorrect';
            hasError = true;
            isSuccess = false;
          });
          //_errorPopup();
          break;
      }
    } catch (e) {
      setState(() {
        result = 'There was an undefined error';
        hasError = true;
        isSuccess = false;
      });
      // _errorPopup();
    }
  }

  void _errorPopup() {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(result), const Icon(Icons.error)],
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
      );
  }

  void _submitingPopup() {
    Scaffold.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Logging In...',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const CircularProgressIndicator(),
            ],
          ),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      );
  }

  bool get isPopulated => _emailController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * .01),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Image.asset('assets/images/appbar.png', height: 90),
                ),
                const SizedBox(height: 10),
                Container(
                  child: Text(
                    'Enter your registered email to recieve a password reset email.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
                if (result != null) ...{
                  const SizedBox(height: 30),
                  Text(
                    result,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: (hasError) ? Colors.red : Colors.green,
                    ),
                  ),
                },
                const SizedBox(height: 30),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    alignLabelWithHint: true,
                    // hasFloatingPlaceholder: false,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: 'UT Email',
                  ),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: false,
                  autocorrect: false,
                  // focusNode: _emailFocus,
                  textInputAction: TextInputAction.done,
                ),
                const SizedBox(height: 16),
                Container(
                  height: 50,
                  child: FlatButton(
                    color: Theme.of(context).backgroundColor,
                    onPressed: _resetPassword,
                    child: const Text('Send Link'),
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
