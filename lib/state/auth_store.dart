import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthStore {
  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);

  static bool isLoggedIn() => currentUser.value != null;

  static void logout() => currentUser.value = null;
}
