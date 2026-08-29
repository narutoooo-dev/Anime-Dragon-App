/*import 'package:anime_slayer/features/auth/presentation/user_notifier.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        await prefs.setString('user_name', data.email.split('@')[0]); // اسم مؤقت من الإيميل
        await prefs.setString('user_avatar', 'https://i.pravatar.cc/150?img=1');
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
        
        // حفظ مسار الصورة (اختياري)
        if (data.avatar != null) {
          await prefs.setString('user_avatar', data.avatar!.path);
        } else {
          await prefs.setString('user_avatar', 'https://i.pravatar.cc/150?img=1');
        }
        
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

  // دالة تسجيل الخروج
  Future<void> logout() async {
    try {
      localDataSource.clearToken();
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('user_email');
      await prefs.remove('user_name');
      await prefs.remove('user_avatar');
      await prefs.setBool('is_logged_in', false);
      print('✅ تم تسجيل الخروج');
    } catch (e) {
      print('❌ خطأ في تسجيل الخروج: $e');
      rethrow;
    }
  }

  // جلب التوكن
  String? getToken() {
    try {
      final token = localDataSource.getToken();
      return token;
    } catch (e) {
      print('❌ خطأ في جلب التوكن: $e');
      return null;
    }
  }

  // جلب معلومات المستخدم
  Future<UserModel> fetchUserInfo() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('user_email') ?? 'admin@anime.com';
      final name = prefs.getString('user_name') ?? 'الأدمن';
      final avatar = prefs.getString('user_avatar') ?? 'https://i.pravatar.cc/150?img=1';
      
      print('✅ تم جلب بيانات المستخدم: $email');
      
      // استخدام الباني الصحيح لـ UserModel
      return UserModel(
        email: email,
        name: name,
        avatar: avatar,
      );
    } catch (e) {
      print('❌ خطأ في جلب بيانات المستخدم: $e');
      // إرجاع مستخدم افتراضي في حالة الخطأ
      return UserModel(
        email: 'admin@anime.com',
        name: 'الأدمن',
        avatar: 'https://i.pravatar.cc/150?img=1',
      );
    }
  }
}
*/
