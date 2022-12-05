import 'package:flutter/cupertino.dart';

abstract class AuthRepository {
  Future<bool> login(String email, String password, BuildContext context);
  Future<void> logout();
}
