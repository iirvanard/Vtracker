import 'package:vtracker/core/exception.dart';
import 'package:vtracker/features/auth/data/datasources/db_helper.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';

abstract class AuthLocalDataSource {
  Future<String> insertAccountlist(AccountLogin account);
  Future<String> removeAccountlist(AccountLogin account);
  Future<List<AccountLogin>> getAccountlist();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final DatabaseHelper databaseHelper;

  AuthLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertAccountlist(AccountLogin account) async {
    try {
      await databaseHelper.insertAccountList(account);
      return 'Added to Accountlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeAccountlist(AccountLogin account) async {
    try {
      await databaseHelper.removeAccountList(account);
      return 'Removed from Accountlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<AccountLogin>> getAccountlist() async {
    final result = await databaseHelper.getAccountList();
    return result.map((data) => AccountLogin.fromMap(data)).toList();
  }
}
