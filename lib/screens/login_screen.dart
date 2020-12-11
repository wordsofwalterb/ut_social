import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ut_social/blocs/login_bloc/login_bloc.dart';
import 'package:ut_social/blocs/user_bloc/user_bloc.dart';
import 'package:ut_social/util/router.dart';

import '../services/user_repository.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  const LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  String _failureType(LoginState state) {
    if (state.error != null) {
      return state.error;
    } else {
      return 'Login Failure, please try again later';
    }
  }

  //bool _hasLoginFailure(LoginState state) => state.error != null;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
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
        if (state.isSuccess) {
          BlocProvider.of<UserBloc>(context).add(LogInUser());
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * .1),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child:
                          Image.asset('assets/images/appbar.png', height: 90),
                    ),
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
                        // hasFloatingPlaceholder: false,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () => Navigator.of(context)
                            .pushNamed(Routes.lostPassword),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Lost Password',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: const Color(0xffcbcbcb),
                                    ),
                          ),
                        ),
                      ),
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
                              child: const Text('Login'),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1.0,
                                color: const Color(0xffc4c4c4),
                              ),
                            ),
                            child: FlatButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return RegisterScreen(
                                      userRepository: _userRepository);
                                }),
                              ),
                              child: const Text(
                                'Create an Account',
                                style: TextStyle(color: Color(0xffc4c4c4)),
                              ),
                            ),
                          ),
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
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _onPasswordObscuredChanged() {
    _loginBloc.add(
      ToggledObscurePassword(),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
