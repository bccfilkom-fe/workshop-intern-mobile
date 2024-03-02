part of 'tweet_cubit.dart';

@immutable
sealed class TweetState {}

final class TweetInitial extends TweetState {}

final class GetTweetLoading extends TweetState {}

final class GetTweetSuccess extends TweetState {
  final List<TweetModel> listTweet;

  GetTweetSuccess({required this.listTweet});
}

final class GetTweetHasNoData extends TweetState {}

final class GetTweetEror extends TweetState {
  final String eror;

  GetTweetEror({required this.eror});
}

final class CreateTweetLoading extends TweetState {}

final class CreateTweetSuccess extends TweetState {}

final class CreateTweetEror extends TweetState {
  final String eror;

  CreateTweetEror({required this.eror});
}

final class DeleteTweetLoading extends TweetState {}

final class DeleteTweetSuccess extends TweetState {}

final class DeleteTweetEror extends TweetState {
  final String eror;

  DeleteTweetEror({required this.eror});
}

final class UpdateTweetLoading extends TweetState {}

final class UpdateTweetSuccess extends TweetState {}

final class UpdateTweetEror extends TweetState {
  final String eror;

  UpdateTweetEror({required this.eror});
}
