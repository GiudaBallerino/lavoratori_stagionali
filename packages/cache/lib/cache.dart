library cache;

import 'package:employees_api/employees_api.dart' show Employee;

class CacheClient {
  CacheClient() : _cache = <String, dynamic>{};

  final Map<String, dynamic> _cache;

  void write(
      {required String key, required Employee value}){
    _cache[key] = value.toJson();
  }

  Employee? read({required String key}){
    if(_cache[key]!={}&&_cache[key]!=null){
      return Employee.fromJson(_cache[key]);
    }
    return null;
  }

  Future<void> reset({required String key}) async{
    _cache[key] = {};
  }
}
