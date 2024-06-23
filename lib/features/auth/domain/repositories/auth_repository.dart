import 'package:dartz/dartz.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';

import '../../../../core/failure.dart';

abstract class AuthPageRepository {
  Future<Either<Failure, String>> login({
    required String username,
    required String password,
  });

  Future<Either<Failure, String>> saveAccountList(AccountLogin movie);
  Future<Either<Failure, String>> removeAccountList(AccountLogin movie);
  Future<Either<Failure, List<AccountLogin>>> getAccountList();
}
