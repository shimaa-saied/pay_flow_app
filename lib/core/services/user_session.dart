import 'package:flutter/foundation.dart';

/// Holds authenticated user state and notifies go_router on changes.
class UserSession extends ChangeNotifier {
  String? _userId;
  String? _email;

  String? get userId => _userId;
  String? get email => _email;
  bool get isAuthenticated => _userId != null;

  void login(String uid, String email) {
    _userId = uid;
    _email = email;
    notifyListeners();
  }

  void logout() {
    _userId = null;
    _email = null;
    notifyListeners();
  }
}
