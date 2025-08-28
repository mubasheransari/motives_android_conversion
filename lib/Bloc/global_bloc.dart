import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/Models/login_model.dart';
import 'package:motives_android_conversion/Repository/repository.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<Login>(_login);
  }

  Repository repo = Repository();

_login(Login event, emit) async {
  emit(state.copyWith(status: LoginStatus.loading));

  try {
    final response = await repo.login(
      event.email ?? "",
      event.password ?? "",
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final LoginModel loginModel = loginModelFromJson(response.body);

      emit(state.copyWith(
        status: LoginStatus.success,
        loginModel: loginModel,
      ));
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
