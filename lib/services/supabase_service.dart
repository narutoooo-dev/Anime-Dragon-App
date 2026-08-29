import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // تم تحديث البيانات بمعلومات مشروعك
  static const String url = 'https://xaeygtdjngzudkgcbkuh.supabase.co';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZXlndGRqbmd6dWRrZ2Nia3VoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODgwMDgxMDUsImV4cCI6MjEwMzU4NDEwNX0.YKRBZQo-RM9iaDJ8Ys2UCDpjPWbJST5zsrxUhHzQM2Q';

  Future<void> init() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  // جلب كل الأنمي من قاعدة البيانات
  Future<List<Map<String, dynamic>>> getAnime() async {
    try {
      final response = await Supabase.instance.client
          .from('anime')
          .select('*')
          .execute();
      
      if (response.error != null) {
        throw Exception('فشل في جلب البيانات: ${response.error!.message}');
      }
      
      return List<Map<String, dynamic>>.from(response.data ?? []);
    } catch (e) {
      print('خطأ في getAnime: $e');
      return [];
    }
  }

  // إضافة أنمي جديد (خاص بالأدمن)
  Future<void> addAnime(Map<String, dynamic> animeData) async {
    try {
      final response = await Supabase.instance.client
          .from('anime')
          .insert(animeData)
          .execute();
      
      if (response.error != null) {
        throw Exception('فشل في الإضافة: ${response.error!.message}');
      }
      
      print('تمت إضافة الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في addAnime: $e');
      rethrow;
    }
  }

  // تحديث بيانات أنمي (خاص بالأدمن)
  Future<void> updateAnime(int id, Map<String, dynamic> newData) async {
    try {
      final response = await Supabase.instance.client
          .from('anime')
          .update(newData)
          .eq('id', id)
          .execute();
      
      if (response.error != null) {
        throw Exception('فشل في التحديث: ${response.error!.message}');
      }
      
      print('تم تحديث الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في updateAnime: $e');
      rethrow;
    }
  }

  // حذف أنمي (خاص بالأدمن)
  Future<void> deleteAnime(int id) async {
    try {
      final response = await Supabase.instance.client
          .from('anime')
          .delete()
          .eq('id', id)
          .execute();
      
      if (response.error != null) {
        throw Exception('فشل في الحذف: ${response.error!.message}');
      }
      
      print('تم حذف الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في deleteAnime: $e');
      rethrow;
    }
  }
}
