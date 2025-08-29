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
