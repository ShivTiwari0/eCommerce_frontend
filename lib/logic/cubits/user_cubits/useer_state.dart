import 'package:ecom/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoggedInState extends UserState {
  final UserModel userModel;

  UserLoggedInState({required this.userModel});
}

class UserLogoutState extends UserState {}


class UserErrorState extends UserState {
  final String message;

  UserErrorState({required this.message});
}
// class UserPasswordResetState extends UserState{}
// class UserProfileUpdateState extends UserState{}