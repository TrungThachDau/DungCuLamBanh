class AppEnv {
  static const String apiBaseUrl =
      String.fromEnvironment('API_BASE_URL', defaultValue: 'http://10.0.2.2:5000');
  static const String accountBaseUrl =
      String.fromEnvironment('ACCOUNT_BASE_URL', defaultValue: apiBaseUrl);
  static const String webBaseUrl =
      String.fromEnvironment('WEB_BASE_URL', defaultValue: apiBaseUrl);

  static Uri api(String path) => _buildUri(apiBaseUrl, path);

  static Uri account(String path) => _buildUri(accountBaseUrl, path);

  static Uri web(String path) => _buildUri(webBaseUrl, path);

  static Uri _buildUri(String base, String path) {
    final baseUri = Uri.parse(base);
    final normalizedPath = path.startsWith('/') ? path : '/$path';
    return baseUri.resolve(normalizedPath);
  }
}
