import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lob_app/models/user.dart';
import 'package:lob_app/services/auth_services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_provider.g.dart';

@riverpod
Future<Users> user(UserRef ref, {required String email}) {
  return AuthServices.getUser(email: email);
}
