part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEmailChanged extends RegisterEvent {
  final String email;

  const RegisterEmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class RegisterPasswordObscured extends RegisterEvent {}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  const RegisterPasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'PasswordChanged { password: $password }';
}

class RegisterSubmitted extends RegisterEvent {
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  const RegisterSubmitted({
    @required this.email,
    @required this.password,
    @required this.firstName,
    @required this.lastName,
  });

  @override
  List<Object> get props => [email, password, firstName, lastName];

  @override
  String toString() {
    return 'Submitted { email: $email, password: $password, firstName: $firstName, lastName: $lastName }';
  }
}
