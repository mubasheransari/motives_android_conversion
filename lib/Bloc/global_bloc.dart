import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motives_android_conversion/Bloc/global_event.dart';
import 'package:motives_android_conversion/Bloc/global_state.dart';
import 'package:motives_android_conversion/Models/login_model.dart';
import 'package:motives_android_conversion/Repository/repository.dart';

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  GlobalBloc() : super(GlobalState()) {
    on<Login>(_login);
    on<MarkAttendance>(markAttendance);
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


  markAttendance(MarkAttendance event, Emitter<GlobalState> emit) async {
  emit(state.copyWith(markAttendanceStatus: MarkAttendanceStatus.loading));

  try {
    final response = await repo.attendance(event.type,event.userId,event.lat,event.lng);

    print("Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 200) {
      print('Under status code 200 print');
      print('Under status code 200 print');
      print('Under status code 200 print');
      // final LoginModel loginModel = loginModelFromJson(response.body);

      // print('STATUS CHECK: ${loginModel.status}');

      // if (loginModel.status == "1") {
      //   emit(state.copyWith(
      //    markAttendanceStatus: MarkAttendanceStatus.success,
      //     loginModel: loginModel,
      //   ));
      // } else {
      //   emit(state.copyWith(
      //     markAttendanceStatus: MarkAttendanceStatus.failure,
      //     loginModel: loginModel,
      //   ));
      // }
    } else {
      emit(state.copyWith(markAttendanceStatus: MarkAttendanceStatus.failure));
    }
  } catch (e) {
    print("Login error: $e");
    emit(state.copyWith(markAttendanceStatus: MarkAttendanceStatus.failure));
  }
}
}
