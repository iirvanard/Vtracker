part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginError extends LoginState {
  final String message;
  const LoginError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoginSuccess extends LoginState {
  // const LoginSuccess();

  // @override
  // List<Object> get props => [];
}

abstract class MultiLoginState extends Equatable {
  const MultiLoginState();

  @override
  List<Object> get props => [];
}

class GetAccountListState extends MultiLoginState {
  final List<AccountLogin> account;
  const GetAccountListState({
    required this.account,
  });
  @override
  List<Object> get props => [account];
}

class MultiLoginInitial extends MultiLoginState {}

class LoginListError extends MultiLoginState {
  final String message;
  const LoginListError({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}
