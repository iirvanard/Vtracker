part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;
  final bool remember;

  const LoginButtonPressed(
      {required this.username, required this.password, this.remember = false});

  @override
  List<Object> get props => [username, password, remember];
}

abstract class MultiLoginEvent extends Equatable {
  const MultiLoginEvent();

  @override
  List<Object> get props => [];
}

class AccountListEvent extends MultiLoginEvent {}
