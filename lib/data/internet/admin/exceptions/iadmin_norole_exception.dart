class InternetAdminNoRoleException implements Exception {
  final String message;

  InternetAdminNoRoleException(this.message);

  @override
  String toString() {
    return message;
  }
}
