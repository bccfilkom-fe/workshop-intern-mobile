class Api {
  static const String _baseUrl = "https://next-tweet-api.vercel.app/api";

  static String getRegisterEndpoint() => "$_baseUrl/auth/register";
  static String getLoginEndpoint() => "$_baseUrl/auth/login";
  static String getAllTweetsByUserEndpoint() => "$_baseUrl/tweet/get";
  static String getTweetByIdEndpoint(String id) => "$_baseUrl/tweet/$id/get";
  static String getCreateNewTweetEndpoint() => "$_baseUrl/tweet/create";
  static String getUpdateTweetById() => "$_baseUrl/tweet/update";
  static String getDeleteTweetById() => "$_baseUrl/tweet/delete";
}
