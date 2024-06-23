import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';

import '../../../../core/failure.dart';

class LoginParams extends Equatable {
  const LoginParams({required this.username, required this.password});
  final String username;
  final String password;

  @override
  List<Object> get props => [username, password];
}

class LoginUsecase {
  final AuthPageRepository repository;
  LoginUsecase({
    required this.repository,
  });

  Future<Either<Failure, String>> execute(LoginParams params) {
    return repository.login(
        username: params.username, password: params.password);
  }
}
