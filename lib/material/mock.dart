class Mock {
  static Future<void> sendPasswordResetEmail(Duration time, bool result) async {
    await Future.delayed(time);
    if (result) {
      return; // simulate success
    } else {
      throw Exception("Mock password reset failed"); // simulate failure
    }
  }
}
