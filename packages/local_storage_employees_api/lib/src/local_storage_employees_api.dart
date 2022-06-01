import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:employees_api/employees_api.dart';

class LocalStorageEmployeesApi extends EmployeesApi {
  LocalStorageEmployeesApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _employeesStreamController = BehaviorSubject<List<Employee>>.seeded(const []);

  @visibleForTesting
  static const kEmployeesCollectionKey = 'employees';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final employeesJson = _getValue(kEmployeesCollectionKey);
    if (employeesJson != null) {
      final employees = List<Map>.from(json.decode(employeesJson) as List)
          .map((jsonMap) => Employee.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _employeesStreamController.add(employees);
    } else {
      _employeesStreamController.add(const []);
    }
  }

  @override
  Stream<List<Employee>> getEmployees() => _employeesStreamController.asBroadcastStream();

  @override
  Future<void> saveEmployee(Employee employee) {
    final employees = [..._employeesStreamController.value];
    final employeeIndex = employees.indexWhere((e) => e.getId == employee.getId);
    if (employeeIndex >= 0) {
      employees[employeeIndex] = employee;
    } else {
      employees.add(employee);
    }

    _employeesStreamController.add(employees);
    return _setValue(kEmployeesCollectionKey, json.encode(employees));
  }

  @override
  Future<void> deleteEmployee(String id) async {
    final employees = [..._employeesStreamController.value];
    final employeeIndex = employees.indexWhere((e) => e.getId == id);
    if (employeeIndex == -1) {
      throw EmployeeNotFoundException();
    } else {
      employees.removeAt(employeeIndex);
      _employeesStreamController.add(employees);
      return _setValue(kEmployeesCollectionKey, json.encode(employees));
    }
  }
}