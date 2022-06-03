import 'dart:async';

import 'package:meta/meta.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:rxdart/subjects.dart';
import 'package:employees_api/employees_api.dart';

class MongoDBEmployeesApi extends EmployeesApi {
  MongoDBEmployeesApi({
    required DbCollection plugin,
  }) : _plugin = plugin {
    _init();
  }

  final DbCollection _plugin;

  final _employeeStreamController =
      BehaviorSubject<List<Employee>>.seeded(const []);

  @visibleForTesting
  static const kEmployeesCollectionKey = 'employees';

  Future<List<Map<String, dynamic>>> _getValue() async =>
      await _plugin.find().toList();
  Future<void> _updateValue(String id, Map<String, dynamic> value) async =>
      await _plugin.updateOne(where.eq('id', id), value);
  Future<void> _setValue(Map<String, dynamic> value) async =>
      await _plugin.insertOne(value);
  Future<void> _deleteValue(String id) async =>
      await _plugin.deleteOne(where.eq('id', id));

  Future<void> _init() async {
    final employeesJson = await _getValue();
    if (employeesJson != null) {
      List<Employee> employees = List.generate(employeesJson.length,
          (index) => Employee.fromJson(employeesJson[index]));
      _employeeStreamController.add(employees);
    } else {
      _employeeStreamController.add(const []);
    }
  }

  @override
  Stream<List<Employee>> getEmployees() =>
      _employeeStreamController.asBroadcastStream();

  @override
  Future<void> saveEmployee(Employee employee) async {
    final employees = [..._employeeStreamController.value];
    final employeeIndex = employees.indexWhere((e) => e.id == employee.id);
    if (employeeIndex >= 0) {
      employees[employeeIndex] = employee;
      _employeeStreamController.add(employees);
      return await _updateValue(employees[employeeIndex].id, employee.toJson());
    } else {
      employees.add(employee);
      _employeeStreamController.add(employees);
      return _setValue(employee.toJson());
    }
  }

  @override
  Future<void> deleteEmployee(String id) async {
    final employees = [..._employeeStreamController.value];
    final employeeIndex = employees.indexWhere((e) => e.id == id);
    if (employeeIndex == -1) {
      throw EmployeeNotFoundException();
    } else {
      employees.removeAt(employeeIndex);
      _employeeStreamController.add(employees);
      return await _deleteValue(id);
    }
  }
}
