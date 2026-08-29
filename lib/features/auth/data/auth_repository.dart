import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart'; // أضف هذا السطر

import '../../../providers/local_auth_data_source.dart';
import 'requests/login_request_model.dart';
import 'remote_auth_data_source.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    remoteDataSource: ref.watch(remoteAuthDataSourceProvider),
    localDataSource: ref.watch(localAuthDataSourceProvider),
  );
});

class AuthRepository {
  final RemoteAuthDataSource remoteDataSource;
  final LocalAuthDataSource localDataSource;

  AuthRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  // دالة تسجيل الدخول المعدلة (محلياً)
  Future<Response> login({required LoginRequestModel data}) async {
    try {
      // محاكاة تسجيل الدخول بدون سيرفر
      if (data.email.isNotEmpty && data.password.isNotEmpty) {
        // حفظ التوكن محلياً (توكن وهمي)
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', 'fake_token_12345');
        await prefs.setString('user_email', data.email);
        await prefs.setBool('is_logged_in', true);
        
        print('✅ تم تسجيل الدخول محلياً: ${data.email}');
        
        // إرجاع استجابة وهمية
        return Response(
          data: {'access_token': 'fake_token_12345'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      } else {
        throw Exception('الإيميل أو كلمة المرور فارغة');
      }
    } catch (e) {
      print('❌ خطأ في تسجيل الدخول المحلي: $e');
      throw Exception('فشل في تسجيل الدخول: $e');
    }
  }

  // دالة التسجيل المعدلة (محلياً)
  Future<Response> register({required RegisterRequestModel data}) async {
    try {
      // محاكاة التسجيل بدون سيرفر
      if (data.email.isNotEmpty && data.password.isNotEmpty && data.username.isNotEmpty) {
        // حفظ التوكن محلياً
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', 'fake_token_12345');
        await prefs.setString('user_email', data.email);
        await prefs.setString('user_name', data.username);
        await prefs.setBool('is_logged_in', true);
        
        print('✅ تم التسجيل محلياً: ${data.email}');
        
        // إرجاع استجابة وهمية
        return Response(
          data: {'access_token': 'fake_token_12345'},
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        );
      } else {
        throw Exception('جميع الحقول مطلوبة');
      }
    } catch (e) {
      print('❌ خطأ في التسجيل المحلي: $e');
      throw Exception('فشل في التسجيل: $e');
    }
  }

  // باقي الدوال كما هي (logout, getToken, fetchUserInfo)
  Future<void> logout() async {
    try {
      localDataSource.clearToken();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_email');
      await prefs.remove('user_name');
      await prefs.setBool('is_logged_in', false);
    } catch (e) {
      rethrow;
    }
  }

  String? getToken() {
    try {
      final token = localDataSource.getToken();
      return token;
    } catch (e) {
      rethrow;
    }
  }

  Future fetchUserInfo() async {
    try {
      // إرجاع بيانات وهمية
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email') ?? 'user@example.com';
      final name = prefs.getString('user_name') ?? 'مستخدم';
      
      return UserModel(
        id: 1,
        email: email,
        username: name,
        avatar: null,
      );
    } catch (e) {
      print('خطأ في جلب بيانات المستخدم: $e');
      return null;
    }
  }
}
