import 'package:equatable/equatable.dart';
import 'package:motives_android_conversion/Models/login_model.dart';
import 'package:motives_android_conversion/Models/markattendance_model.dart';

enum LoginStatus { initial, loading, success, failure }

enum MarkAttendanceStatus { initial, loading, success, failure }

// ignore: must_be_immutable
class GlobalState extends Equatable {
  final LoginStatus status;
  final MarkAttendanceStatus markAttendanceStatus;
  LoginModel? loginModel;
  MarkAttendenceModel ? markAttendenceModel;

  GlobalState({
    this.status = LoginStatus.initial,
    this.markAttendanceStatus = MarkAttendanceStatus.initial,
    this.loginModel,
    this.markAttendenceModel
  });

  GlobalState copyWith({
    LoginStatus? status,
    MarkAttendanceStatus? markAttendanceStatus,
    LoginModel? loginModel,
    MarkAttendenceModel ? markAttendenceModel,
  }) {
    return GlobalState(
      status: status ?? this.status,
      markAttendanceStatus: markAttendanceStatus ?? this.markAttendanceStatus,
      loginModel: loginModel ?? this.loginModel,
      markAttendenceModel:  markAttendenceModel ?? this.markAttendenceModel
    );
  }

  @override
  List<Object?> get props => [status, markAttendanceStatus, loginModel,markAttendenceModel];
}
