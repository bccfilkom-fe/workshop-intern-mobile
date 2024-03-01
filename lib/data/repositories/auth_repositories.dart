import 'package:dio/dio.dart';
import 'package:fe_bccintern24/data/datasources/remote/api.dart';

import '../datasources/local/local_storage.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<bool> registerRepository(String email, String password) async {
    try {
      final response = await _dio.post(Api.getRegisterEndpoint(),
          data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception("Error at register repository ${e.toString()}");
    }
    return false;
  }

  Future<bool> loginRepository(String email, String password) async {
    try {
      final response = await _dio.post(Api.getLoginEndpoint(),
          data: {"email": email, "password": password});

      if (response.statusCode == 200) {
        final data = response.data["data"];
        final token = data["token"];
        await UserLocalStorage.addUserToken(token);
        return true;
      } else {
        throw Exception("Non-200 status code received: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error at login repository ${e.toString()}");
    }
  }

  Future<bool> logoutRepository() async {
    try {
      await UserLocalStorage.deleteUserToken();
      return true;
    } catch (e) {
      throw Exception("Error at logout repository${e.toString()}");
    }
  }

  Future<String?> getUserRepository() async {
    try {
      final userToken = await UserLocalStorage.getUserToken();
      print("ini user: $userToken");
      if (userToken != null) {
        return userToken;
      } else {
        return null;
      }
    } catch (e) {
      print("tidak dapat data user ini di repo");
      throw Exception("Error at get user: ${e.toString()}");
    }
  }
}
