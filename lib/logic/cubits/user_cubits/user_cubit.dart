import 'package:ecom/data/models/user_model.dart';
import 'package:ecom/data/repository/user_repository.dart';
import 'package:ecom/logic/cubits/user_cubits/useer_state.dart';
import 'package:ecom/logic/services/preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState()) {
    _initialize();
  }

  final UserRepository _repository = UserRepository();

  void _initialize() async {
    final userDetail = await Preferences.getUserDetails();
    String? email = userDetail["email"];
    String? password = userDetail["password"];
    if (email == null || password == null) {
      emit(UserLogoutState());
    } else {
      signIn(email: email, password: password);
    }
  }

  void _emitLoggedInState(
      {required UserModel userModel,
      required String email,
      required String password}) async {
    await Preferences.saveUserDeatails(email, password);
    emit(UserLoggedInState(userModel: userModel));
  }

  void signIn({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _repository.signIn(email: email, password: password);

      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  void createAccount({required String email, required String password}) async {
    emit(UserLoadingState());
    try {
      UserModel userModel =
          await _repository.createAccount(email: email, password: password);
      _emitLoggedInState(
          userModel: userModel, email: email, password: password);
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
    }
  }

  Future<bool> updateUser(UserModel user) async {
    try {
      emit(UserLoadingState());
      UserModel updateUser = await _repository.updateUser(user);
      emit(UserLoggedInState(userModel: updateUser));
      return true;
    } catch (e) {
      emit(UserErrorState(message: e.toString()));
      return false;
    }
  }

  void signOut() async {
    await Preferences.clear();
    emit(UserLogoutState());
  }
}
