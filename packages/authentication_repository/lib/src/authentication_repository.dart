import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:employees_api/employees_api.dart' show Employee;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInWithEmailAndPasswordFailure implements Exception {
  const LogInWithEmailAndPasswordFailure([
    this.message = 'Si è verificato un errore sconosciuto!',
  ]);

  factory LogInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
          'Email/Username o password non corretta.',
        );
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }

  final String message;
}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({
    CacheClient? cache,
    required DbCollection dbPlugin,
    required SharedPreferences authPlugin,
  })  : _cache = cache ?? CacheClient(),
        _dbPlugin = dbPlugin,
        _authPlugin = authPlugin {}

  final CacheClient _cache;
  final DbCollection _dbPlugin;
  final SharedPreferences _authPlugin;

  static const authCacheKey = 'logged_in';

  void setCurrentEmployee(Employee employee) {
    print(employee);
    _cache.write(
      key: authCacheKey,
      value: employee,
    );
  }

  Employee? get currentEmployee {
    return _cache.read(key: authCacheKey);
  }

  Stream<Employee?> get employee async* {
    String? employeePref = _authPlugin.getString(authCacheKey);

    final employee = employeePref == null
        ? null
        : Employee.fromJson(jsonDecode(employeePref));
    if (employee != null) {
      _cache.write(key: authCacheKey, value: employee);
    }

    yield employee;
  }

  Future<Employee> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _dbPlugin
        .findOne(where.eq('email', email).eq('password', password));
    if (result != null) {
      Employee employee = Employee.fromJson(result);

      await _authPlugin.setString(authCacheKey, json.encode(employee));
      setCurrentEmployee(employee);

      return employee;
    } else {
      throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
    }
  }

  Future<Employee> logInWithUserAndPassword({
    required String username,
    required String password,
  }) async {
    final result = await _dbPlugin
        .findOne(where.eq('username', username).eq('password', password));
    if (result != null) {
      Employee employee = Employee.fromJson(result);

      await _authPlugin.setString(authCacheKey, json.encode(employee));
      setCurrentEmployee(employee);

      return employee;
    } else {
      throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
    }
  }

  Future<void> logOut() async {
    try {
      await _authPlugin.remove(authCacheKey);
      _cache.reset(key: authCacheKey);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
