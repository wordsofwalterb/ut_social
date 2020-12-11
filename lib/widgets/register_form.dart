import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ut_social/blocs/register_bloc/register_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';

class RegisterForm extends StatefulWidget {
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _firstNameFocus = FocusNode();
  final FocusNode _lastNameFocus = FocusNode();

  RegisterBloc _registerBloc;

  //UserRepository get _userRepository => widget._userRepository;

  String _failureType(RegisterState state) {
    if (state.error != null) {
      return state.error;
    } else {
      return 'Login Failure, please try again later';
    }
  }

  Future<void> _launchPrivacyPolicy() async {
    const url =
        'https://www.notion.so/Privacy-Policy-1dc7732fb3f04de3810fe66c984bb431';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchTermsOfService() async {
    const url =
        'https://www.notion.so/Terms-of-Services-b7c41ba68be74edcb8c065c1f9c5d4c0';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //bool _hasRegisterFailure(RegisterState state) => state.error != null;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_failureType(state)),
                      const Icon(Icons.error)
                    ],
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
          }
          if (state.isSubmitting) {
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Creating Account...',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  ),
                  backgroundColor: Theme.of(context).backgroundColor,
                ),
              );
          }
          if (state.isSuccess) {
            Navigator.of(context).pop();
            BlocProvider.of<UserBloc>(context).add(LogInUser());
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 20),
                    //   child:
                    //       Image.asset('assets/images/appbar.png', height: 90),
                    // ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'First Name',
                        errorText:
                            (state.error == 'First name needs to be provided')
                                ? 'First name needs to be provided'
                                : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: true,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      focusNode: _firstNameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(
                            context, _firstNameFocus, _lastNameFocus);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'Last Name',
                        errorText:
                            (state.error == 'Last name needs to be provided')
                                ? state.error
                                : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: false,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.words,
                      focusNode: _lastNameFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _lastNameFocus, _emailFocus);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        hintText: 'UT Email',
                        errorText: (state.error ==
                                    'Email format is incorrect' ||
                                state.error == 'UTexas email is required' ||
                                state.error ==
                                    'User with this email already exists.' ||
                                state.error == 'Invalid email format')
                            ? state.error
                            : null,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autovalidate: false,
                      autocorrect: false,
                      focusNode: _emailFocus,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (term) {
                        _fieldFocusChange(context, _emailFocus, _passwordFocus);
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        errorText: (state.error == 'Password is too weak')
                            ? 'Password too weak, use atleast 8 characters and a number'
                            : null,
                        hintText: 'Password',
                        suffixIcon: GestureDetector(
                          onTap: _onPasswordObscuredChanged,
                          child: (state.isPasswordObscured)
                              ? Icon(Icons.visibility_off,
                                  color: Theme.of(context).primaryColor)
                              : Icon(Icons.visibility,
                                  color: Theme.of(context).primaryColor),
                        ),
                      ),
                      obscureText: state.isPasswordObscured,
                      autovalidate: false,
                      autocorrect: false,
                      focusNode: _passwordFocus,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (term) {
                        _passwordFocus.unfocus();
                        if (isPopulated) _onFormSubmitted();
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            height: 50,
                            child: FlatButton(
                              color: Theme.of(context).backgroundColor,
                              onPressed: _onFormSubmitted,
                              child: const Text('Register'),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const Text(
                      'By creating an account you agree to the following',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        const Spacer(),
                        GestureDetector(
                          onTap: _launchTermsOfService,
                          child: Text(
                            'Terms of Service',
                            style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: _launchPrivacyPolicy,
                          child: Text(
                            'Privacy Policy',
                            style: TextStyle(
                              color: Colors.white70,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _fieldFocusChange(
      BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _onPasswordObscuredChanged() {
    _registerBloc.add(
      RegisterPasswordObscured(),
    );
  }

  void _onFormSubmitted() {
    _registerBloc.add(
      RegisterSubmitted(
        email: _emailController.text,
        password: _passwordController.text,
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      ),
    );
  }
}
