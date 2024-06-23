import 'package:dartz/dartz.dart';
import 'package:vtracker/core/failure.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';
import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';

class GetAccountList {
  final AuthPageRepository repository;

  GetAccountList({required this.repository});

  Future<Either<Failure, List<AccountLogin>>> execute() {
    return repository.getAccountList();
  }
}
