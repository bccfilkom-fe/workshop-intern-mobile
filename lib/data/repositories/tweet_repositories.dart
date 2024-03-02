import 'package:dio/dio.dart';
import 'package:fe_bccintern24/data/datasources/local/local_storage.dart';
import 'package:fe_bccintern24/data/datasources/remote/api.dart';
import 'package:fe_bccintern24/data/models/tweet.dart';

class TweetRepositories {
  final Dio _dio = Dio();

  //Mendapatkan token dari local storange
  Future<String?> _init() async {
    String? token = await UserLocalStorage.getUserToken();
    return token;
  }

  //Mendapatkan semua tweet dari api
  Future<List<TweetModel>> getAllTweet() async {
    List<TweetModel> data = [];
    String? userToken = await _init();
    try {
      final response = await _dio.get(
        Api.getAllTweetsByUserEndpoint(),
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      );

      //Ada kemungkinan si user baru buat akun, jadinya belum ada tweetnya dong
      //Oleh karena itu, perlu ada cek kondisi tambahan di data hasil api
      //semisalnya ada data dari api, baru deh mulai proses ngambil data
      if (response.statusCode == 200 &&
          (response.data['data'] as List).isNotEmpty) {
        for (var item in response.data['data']) {
          TweetModel dataJson = TweetModel.fromJson(item);
          data.add(dataJson);
        }
      }
    } catch (e) {
      throw Exception("Error at getAllTweet ${e.toString()}");
    }
    return data;
  }

  Future<bool> createTweet(String title, String description) async {
    String? userToken = await _init();
    try {
      final response = await _dio.post(
        Api.getCreateNewTweetEndpoint(),
        data: {'title': title, 'description': description},
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception("Error at createTweet ${e.toString()}");
    }
    return false;
  }

  Future<bool> updateTweet(String id, String title, String description) async {
    String? userToken = await _init();
    try {
      final response = await _dio.put(
        Api.getUpdateTweetById(),
        data: {
          "title": title,
          "description": description,
          "id": id,
        },
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception("Error at updateTweet ${e.toString()}");
    }
    return false;
  }

  Future<bool> deleteTweet(String id) async {
    String? userToken = await _init();
    try {
      final response = await _dio.delete(
        Api.getDeleteTweetById(),
        data: {'id': id},
        options: Options(headers: {'Authorization': 'Bearer $userToken'}),
      );

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      throw Exception("Error at deleteTweet ${e.toString()}");
    }
    return false;
  }
}
