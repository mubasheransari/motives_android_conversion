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

  _login(Login event, Emitter<GlobalState> emit) async {
  emit(state.copyWith(status: LoginStatus.loading));

  try {
    final response = await repo.login(event.email, event.password);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final LoginModel loginModel = loginModelFromJson(response.body);

      print('STATUS CHECK: ${loginModel.status}');

      if (loginModel.status == "1") {
        emit(state.copyWith(
          status: LoginStatus.success,
          loginModel: loginModel,
        ));
      } else {
        emit(state.copyWith(
          status: LoginStatus.failure,
          loginModel: loginModel,
        ));
      }
    } else {
      emit(state.copyWith(status: LoginStatus.failure));
    }
  } catch (e) {
    print("Login error: $e");
    emit(state.copyWith(status: LoginStatus.failure));
  }
}


/*_login(Login event, emit) async {
  emit(state.copyWith(status: LoginStatus.loading));

  try {
    final response = await repo.login(
      event.email,
      event.password,
    );

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final LoginModel loginModel = loginModelFromJson(response.body);
      print('STATUS CHECK ${loginModel.status}');
      print('STATUS CHECK ${loginModel.status}');
      print('STATUS CHECK ${loginModel.status}');
      print('STATUS CHECK ${loginModel.status}');
      print('STATUS CHECK ${loginModel.status}');
      if(loginModel.status =="1"){
                emit(state.copyWith(
        status: LoginStatus.success,
        loginModel: loginModel,
      ));
      }
       else  if(loginModel.status =="0"){
                emit(state.copyWith(
        status: LoginStatus.failure,
        loginModel: loginModel,
      ));
      }


      // emit(state.copyWith(
      //   status: LoginStatus.success,
      //   loginModel: loginModel,
      // ));
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
}*/

}
