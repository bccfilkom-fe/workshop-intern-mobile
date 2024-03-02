import 'package:bloc/bloc.dart';
import 'package:fe_bccintern24/data/repositories/auth_repositories.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthRepository _authRepository = AuthRepository();

  void register(String email, String password) async {
    try {
      emit(AuthLoading());

      var response = await _authRepository.registerRepository(email, password);

      if (response == true) {
        emit(AuthSuccess());
      } else {
        emit(AuthError("There is an error: response not success"));
      }
    } catch (e) {
      emit(AuthError("There is an error: ${e.toString()}"));
    }
  }

  void login(String email, String password) async {
    try {
      emit(AuthLoading());

      var response = await _authRepository.loginRepository(email, password);

      if (response == true) {
        emit(AuthSuccess());
      } else {
        emit(AuthError("There is an error: response not success"));
      }
    } catch (e) {
      emit(AuthError("There is an error: ${e.toString()}"));
    }
  }

  void logout() async {
    try {
      emit(AuthLoading());
      final response = await _authRepository.logoutRepository();

      if (response) {
        emit(Unauthenticated());
      } else {
        emit(AuthError("Logout failed."));
      }
    } catch (error) {
      emit(AuthError("Error during logout: ${error.toString()}"));
    }
  }

  Future<void> isHasLogin() async {
    try {
      final user = await _authRepository.getUserRepository();

      if (user != null && user.isNotEmpty) {
        print("TERAUTENTIKASI");
        emit(Authenticated());
      } else {
        print("TIDAK TERAUTENTIKASI");
        emit(Unauthenticated());
      }
    } catch (error) {
      print("error di sini");
      print(error.toString());
      emit(AuthError("There is an error : ${error.toString()}"));
    }
  }
}
