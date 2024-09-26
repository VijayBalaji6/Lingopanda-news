class FirebaseExceptionHandler {
  static Exception handleFirebaseException(e) {
    switch (e) {
      case 'user-not-found':
        return Exception('user-not-found');
      case 'invalid-credential':
        return Exception('user-not-found');
      case 'weak-password':
        return Exception('The password provided is too weak.');
      case 'email-already-in-use':
        return Exception('The account already exists for that email.');
      default:
        return Exception('Something went wrong');
    }
  }
}
