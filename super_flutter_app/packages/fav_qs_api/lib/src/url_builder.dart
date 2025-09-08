class UrlBuilder {
  const UrlBuilder({String? baseUrl})
    : _baseUrl = baseUrl ?? "https://favqs.com/api";

  final String _baseUrl;

  String buildSignInUrl() {
    return '$_baseUrl/session';
  }

  String buildSignUpUrl() {
    return '$_baseUrl/users';
  }

  String buildSignOutUrl() {
    return '$_baseUrl/session';
  }

  // TOD: Add more url
}
