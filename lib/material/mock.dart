import 'package:firebase_auth/firebase_auth.dart';

class Mock {
  /// Simulates sendPasswordResetEmail behavior.
  /// 
  /// [delay]   – how long to wait before completing.
  /// [result]  – if true, completes successfully.
  /// [notFound] – if true, throws a FirebaseAuthException with code 'user-not-found'.
  /// If both [result] and [notFound] are false, throws a generic failure exception.
  static Future<void> sendPasswordResetEmail({
    required Duration delay,
    required bool result,
    bool notFound = false,
  }) async {
    await Future.delayed(delay);

    if (notFound) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user corresponds to the given email.',
      );
    }

    if (result) {
      return; // success
    }

    // generic failure
    throw FirebaseAuthException(
      code: 'unknown-error',
      message: 'Mock password reset failed.',
    );
  }
}