import 'package:equatable/equatable.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class Login extends GlobalEvent {
  final String email;
  final String password;

  Login({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

// ignore: must_be_immutable
class MarkAttendance extends GlobalEvent{
  String type;
  String userId;
  String lat;
  String lng;

  MarkAttendance({required this.type,required this.userId,required this.lat,required this.lng});


  @override
  List<Object> get props => [type, userId, lat , lng];

}
