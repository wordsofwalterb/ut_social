import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/blocs/authentication_bloc/authentication_bloc.dart';
import 'bloc/register_bloc.dart';

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
                    children: [Text(_failureType(state)), Icon(Icons.error)],
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
            BlocProvider.of<AuthenticationBloc>(context).add(AuthLoggedIn());
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
