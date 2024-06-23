import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:vtracker/features/auth/data/models/multi_login_models.dart';
import 'package:vtracker/features/auth/domain/usecases/get_account_list.dart';
import 'package:vtracker/features/auth/domain/usecases/insert_acount_list.dart';
import 'package:vtracker/features/auth/domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required LoginUsecase loginUsecase, required SaveAccountList saveUsecase}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}


class MultiLoginBloc extends Bloc<MultiLoginEvent, MultiLoginState> {
  MultiLoginBloc({required GetAccountList getListUsecase}) : super(MultiLoginInitial()) {
    on<MultiLoginEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
