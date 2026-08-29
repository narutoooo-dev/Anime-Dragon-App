import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  static const String url = 'https://xaeygtdjngzudkgcbkuh.supabase.co';
  static const String anonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhhZXlndGRqbmd6dWRrZ2Nia3VoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODgwMDgxMDUsImV4cCI6MjEwMzU4NDEwNX0.YKRBZQo-RM9iaDJ8Ys2UCDpjPWbJST5zsrxUhHzQM2Q';

  Future<void> init() async {
    await Supabase.initialize(
      url: url,
      anonKey: anonKey,
    );
  }

  // جلب كل الأنمي
  Future<List<Map<String, dynamic>>> getAnime() async {
    try {
      final response = await Supabase.instance.client
          .from('anime')
          .select('*');
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('خطأ في getAnime: $e');
      return [];
    }
  }

  // إضافة أنمي جديد
  Future<void> addAnime(Map<String, dynamic> animeData) async {
    try {
      await Supabase.instance.client
          .from('anime')
          .insert(animeData);
      
      print('تمت إضافة الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في addAnime: $e');
      rethrow;
    }
  }

  // تحديث أنمي
  Future<void> updateAnime(int id, Map<String, dynamic> newData) async {
    try {
      await Supabase.instance.client
          .from('anime')
          .update(newData)
          .eq('id', id);
      
      print('تم تحديث الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في updateAnime: $e');
      rethrow;
    }
  }

  // حذف أنمي
  Future<void> deleteAnime(int id) async {
    try {
      await Supabase.instance.client
          .from('anime')
          .delete()
          .eq('id', id);
      
      print('تم حذف الأنمي بنجاح!');
    } catch (e) {
      print('خطأ في deleteAnime: $e');
      rethrow;
    }
  }
}
