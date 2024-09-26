import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:lingoganda_news/models/user_model.dart';
import 'package:lingoganda_news/utils/api_utils/firebase_exception_handler.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // Stream to listen to auth changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<UserCredential> firebaseEmailSignIn({
    required String emailId,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailId, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> firebaseEmailSignUp(
      {required String emailId,
      required String password,
      required String name}) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailId,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExceptionHandler.handleFirebaseException(e);
    } catch (e) {
      rethrow;
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addUserToFirestore(
      {required String name, required String email}) async {
    try {
      DocumentReference users =
          FirebaseFirestore.instance.collection('users').doc(email);

      await users.set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      throw FirebaseExceptionHandler.handleFirebaseException(e);
    }
  }

  Future<UserModel> fetchUserData(String email) async {
    try {
      DocumentSnapshot docSnapshot =
          await FirebaseFirestore.instance.collection('users').doc(email).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;
        return UserModel.fromMap(data!);
      } else {
        throw Exception("No User Found");
      }
    } catch (e) {
      throw FirebaseExceptionHandler.handleFirebaseException(e);
    }
  }

  Future<String> fetchRemoteConfig() async {
    try {
      await _remoteConfig.fetchAndActivate();

      return _remoteConfig.getString('news_query_country');
    } catch (e) {
      throw FirebaseExceptionHandler.handleFirebaseException(e);
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
