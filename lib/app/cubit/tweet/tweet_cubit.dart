import 'package:bloc/bloc.dart';
import 'package:fe_bccintern24/data/models/tweet.dart';
import 'package:fe_bccintern24/data/repositories/tweet_repositories.dart';
import 'package:meta/meta.dart';

part 'tweet_state.dart';

class TweetCubit extends Cubit<TweetState> {
  TweetCubit() : super(TweetInitial());

  final TweetRepositories _repositories = TweetRepositories();

  void getAllTweet() async {
    emit(GetTweetLoading());
    try {
      var response = await _repositories.getAllTweet();

      response.isNotEmpty
          ? emit(GetTweetSuccess(listTweet: response))
          : emit(GetTweetHasNoData());
    } catch (e) {
      emit(GetTweetEror(eror: e.toString()));
    }
  }

  void createTweet(String title, String description) async {
    emit(CreateTweetLoading());
    try {
      var response = await _repositories.createTweet(title, description);

      response
          ? emit(CreateTweetSuccess())
          : emit(CreateTweetEror(eror: "Fail make new tweet"));
    } catch (e) {
      emit(CreateTweetEror(eror: e.toString()));
    }
  }

  void updateTweet(
    String id,
    String title,
    String description,
  ) async {
    emit(UpdateTweetLoading());
    try {
      var response = await _repositories.updateTweet(
        id,
        title,
        description,
      );

      response
          ? emit(UpdateTweetSuccess())
          : emit(UpdateTweetEror(eror: 'fail update tweet'));
    } catch (e) {
      emit(UpdateTweetEror(eror: e.toString()));
    }
  }

  void deleteTweet(String id) async {
    emit(DeleteTweetLoading());
    try {
      var response = await _repositories.deleteTweet(id);

      response
          ? emit(DeleteTweetSuccess())
          : emit(DeleteTweetEror(eror: "fail delete tweet"));
    } catch (e) {
      emit(CreateTweetEror(eror: e.toString()));
    }
  }
}
