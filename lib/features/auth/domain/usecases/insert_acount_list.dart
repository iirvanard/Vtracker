import 'package:dartz/dartz.dart';
import 'package:vtracker/core/failure.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';
import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';

class SaveAccountList {
  final AuthPageRepository repository;

  SaveAccountList({required this.repository});

  Future<Either<Failure, String>> execute(AccountLogin account) {
    return repository.saveAccountList(account);
  }
}
