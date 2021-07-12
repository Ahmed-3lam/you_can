class APIPath {
  static String user() => 'users/';
  static String users(String uid) => 'users/$uid';
  static String posts() => 'posts/';
  static String post(String pid) => 'posts/$pid';
  static String articles() => 'articles/';
  static String article(String id) => 'articles/$id';
  static String comments() => 'comments/';
  static String comment(String id) => 'comments/$id';
}
