class ApiPathConstants {
  /// Constructor
  const ApiPathConstants();

  /// Returns staging mode (change to false if deploying to live)
  static bool isStaging = false;

  /// Returns API mode
  static String apiBaseMode = 'https://';

  /// Returns API base url
  static String apiBaseUrl = isStaging
      ? 'gowild-api-staging.herokuapp.com'
      : 'gowild-api-dev.herokuapp.com';

  static String registerUrl = 'api/v1/auth/register';

  static String loginUrl = 'api/v1/auth/login';

  static String usersUrl = 'api/v1/users/';
}
