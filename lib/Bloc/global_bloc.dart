import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_tneww/Bloc/global_event.dart';
import 'package:motives_tneww/Bloc/global_state.dart';
import 'package:motives_tneww/Repository/repository.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<Login>(_login);
  }

  Repository repo = Repository();

  _login(
    Login event,
    emit,
  ) async {
    emit(state.copyWith(status: LoginStatus.loading));

    try {
      final response = await repo.login(
        event.email ?? "",
        event.password ?? "",
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        emit(state.copyWith(status: LoginStatus.success));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: LoginStatus.failure,
      ));
    }
  }
}
