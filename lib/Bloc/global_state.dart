import 'package:equatable/equatable.dart';

import '../Model/login_model.dart';

enum LoginStatus {
  initial,
  loading,
  success,
  failure,
}

class GlobalState extends Equatable {
  final LoginStatus status;
  //LoginModel? loginModel;

  GlobalState({
    this.status = LoginStatus.initial,
    // this.loginModel
  });

  /// Copy the state with updated fields
  GlobalState copyWith({
    LoginStatus? status,
    // LoginModel ? loginModel,
  }) {
    return GlobalState(
      status: status ?? this.status,
      // loginModel:  loginModel ?? this.loginModel
    );
  }

  @override
  List<Object?> get props => [
        status,
        //  loginModel
      ];
}
