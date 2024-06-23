import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:vtracker/core/exception.dart';
import 'package:vtracker/core/failure.dart';
import 'package:vtracker/features/auth/data/datasources/local_datasources.dart';
import 'package:vtracker/features/auth/data/datasources/remote_datasources.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';

import 'package:vtracker/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthPageRepository {
  final AuthRemoteDatasource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> login(
      {required username, required password}) async {
    try {
      final result =
          await remoteDataSource.login(username: username, password: password);
      return Right(result);
    } on ServerFailure catch (e) {
      return Left(e);
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return const Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveAccountList(AccountLogin movie) async {
    try {
      final result = await localDataSource
          .insertAccountlist(AccountLogin.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, String>> removeAccountList(AccountLogin movie) async {
    try {
      final result = await localDataSource
          .removeAccountlist(AccountLogin.fromEntity(movie));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<AccountLogin>>> getAccountList() async {
    final result = await localDataSource.getAccountlist();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
