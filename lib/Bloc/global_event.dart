import 'package:equatable/equatable.dart';

abstract class GlobalEvent extends Equatable {
  const GlobalEvent();

  @override
  List<Object> get props => [];
}

// ignore: must_be_immutable
class Login extends GlobalEvent {
  Login({this.email, this.password});

  String? email, password;

  @override
  List<Object> get props => [email!, password!];
}