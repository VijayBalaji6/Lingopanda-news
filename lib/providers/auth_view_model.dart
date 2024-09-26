import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lingoganda_news/services/auth_services.dart';
import 'package:lingoganda_news/utils/api_utils/api_response_state.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authServices = AuthService();

  ApiResponseState<User?> _user = ApiResponseState.initial();

  ApiResponseState<User?> get user => _user;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _user = ApiResponseState.loading();
    notifyListeners();
    try {
      final firebaseLoginResponse = await _authServices.firebaseEmailSignIn(
        emailId: email,
        password: password,
      );
      _user = ApiResponseState.completed(firebaseLoginResponse.user);
    } catch (e) {
      _user = ApiResponseState.error(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> register(
      {required String email,
      required String password,
      required String userName}) async {
    _user = ApiResponseState.loading();
    notifyListeners();
    try {
      final firebaseRegisterResponse = await _authServices.firebaseEmailSignUp(
          emailId: email, password: password, name: userName);
      _user = ApiResponseState.completed(firebaseRegisterResponse.user);
    } catch (e) {
      _user = ApiResponseState.error(e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> logout() async {
    try {
      await _authServices.signOut();
      _user = ApiResponseState.completed(null);
    } catch (e) {
      _user = ApiResponseState.completed(null);
    }
    notifyListeners();
  }
}
