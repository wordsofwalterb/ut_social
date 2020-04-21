import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/blocs/authentication_bloc/authentication_bloc.dart';
import '../core/repositories/user_repository.dart';
import '../register/register_screen.dart';
import 'login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
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

  LoginForm({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

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

  bool _hasLoginFailure(LoginState state) => state.error != null;

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
                      'Logging In...',
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
                backgroundColor: Theme.of(context).backgroundColor,
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(AuthLoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Form(
              child: ListView(
                children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * .1),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset('assets/images/appbar.png', height: 90),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hasFloatingPlaceholder: false,
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
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hasFloatingPlaceholder: false,
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
                      _onFormSubmitted();
                    },
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    width: double.infinity,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Lost Password',
                        style: Theme.of(context).textTheme.body1.copyWith(
                              color: Color(0xffcbcbcb),
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          height: 50,
                          child: FlatButton(
                            child: Text('Login'),
                            color: Theme.of(context).backgroundColor,
                            onPressed: _onFormSubmitted,
                          ),
                        ),
                        SizedBox(height: 16),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.0,
                              color: Color(0xffc4c4c4),
                            ),
                          ),
                          child: FlatButton(
                            child: Text(
                              'Create an Account',
                              style: TextStyle(color: Color(0xffc4c4c4)),
                            ),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return RegisterScreen(
                                    userRepository: _userRepository);
                              }),
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
    );
  }

  _fieldFocusChange(
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

// class LoginScreen extends StatefulWidget {
//   static final String id = 'login_screen';

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String _email, _password;

//   _submit() {
//     if (_formKey.currentState.validate()) {
//       _formKey.currentState.save();
//       // Logging in the user w/ Firebase
//       // AuthService.login(_email, _password);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width / 3,
//                 child: Image.asset('assets/images/appbar.png'),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Container(
//                      // height: 50,
//                       margin: EdgeInsets.all(12),
//                      // width: 300,
//                       child: TextFormField(
//                         decoration: InputDecoration(
//                           labelText: 'UT Email',
//                         ),
//                         validator: (input) => !input.contains('@')
//                             ? 'Please enter a valid email'
//                             : null,
//                         onSaved: (_) => {},//(input) => _email = input,
//                       ),
//                     ),
//                     Container(
//                      // height: 50,
//                       margin: EdgeInsets.all(12),
//                      // width: 300,
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Password'),
//                         validator: (input) => input.length < 6
//                             ? 'Must be at least 6 characters'
//                             : null,
//                         onSaved: (_) => {},//(input) => _password = input,
//                         obscureText: true,
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     FyreButton(),
//                     SizedBox(height: 20.0),
//                     Container(
//                       width: 250.0,
//                       child: FlatButton(
//                         onPressed: () => {},
//                         color: Colors.blue,
//                         padding: EdgeInsets.all(10.0),
//                         child: Text(
//                           'Go to Signup',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
