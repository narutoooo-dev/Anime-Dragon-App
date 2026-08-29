import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anime_slayer/features/auth/data/auth_repository.dart';
import 'user_notifier.dart'; // استورد الـ UserNotifier من مكانه (حتى لو معلق)

final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  return UserNotifier(ref.watch(authRepositoryProvider));
});
