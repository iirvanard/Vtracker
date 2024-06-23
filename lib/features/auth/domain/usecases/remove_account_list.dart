import 'package:dartz/dartz.dart';
import 'package:vtracker/core/failure.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';
import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';

class RemoveAccountList {
  final AuthPageRepository repository;

  RemoveAccountList(this.repository);

  Future<Either<Failure, String>> execute(AccountLogin account) {
    return repository.removeAccountList(account);
  }
}
