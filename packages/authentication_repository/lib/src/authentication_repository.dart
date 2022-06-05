import 'dart:async';
import 'dart:convert';

import 'package:cache/cache.dart';
import 'package:employees_api/employees_api.dart' show Employee;
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rxdart/rxdart.dart';
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
  final controller = BehaviorSubject<Employee>.seeded(Employee.empty);

  Employee get currentEmployee {
    return _cache.read<Employee>(key: authCacheKey) ?? Employee.empty;
  }

  Stream<Employee> get employee {
    String? employeePref = _authPlugin.getString(authCacheKey);

    Employee emp = employeePref == null
        ? Employee.empty
        : Employee.fromJson(jsonDecode(employeePref));
    _cache.write(key: authCacheKey, value: emp);

    if (emp.email != '' && emp.password != '')
      logInWithEmailAndPassword(email: emp.email, password: emp.password);
    return controller.stream;
  }

  //Stream<Employee> get employee=>controller.stream;

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _dbPlugin
        .findOne(where.eq('email', email).eq('password', password));
    if (result != null) {
      Employee employee = Employee.fromJson(result);

      await _authPlugin.setString(authCacheKey, json.encode(employee));
      controller.add(employee);
    } else {
      throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
    }
  }

  Future<void> logInWithUserAndPassword({
    required String username,
    required String password,
  }) async {
    final result = await _dbPlugin
        .findOne(where.eq('username', username).eq('password', password));
    if (result != null) {
      Employee employee = Employee.fromJson(result);

      await _authPlugin.setString(authCacheKey, json.encode(employee));
      controller.add(employee);
    } else {
      throw LogInWithEmailAndPasswordFailure.fromCode('user-not-found');
    }
  }

  Future<void> logOut() async {
    try {
      controller.add(Employee.empty);
      await _authPlugin.setString(authCacheKey, json.encode(Employee.empty));
    } catch (_) {
      throw LogOutFailure();
    }
  }
}
