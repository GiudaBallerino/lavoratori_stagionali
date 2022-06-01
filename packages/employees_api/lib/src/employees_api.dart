import 'package:employees_api/employees_api.dart';

abstract class EmployeesApi{
  EmployeesApi();

  Stream<List<Employee>> getEmployees();

  Future<void> saveEmployee(Employee employee);

  Future<void> deleteEmployee(String id);

}

class EmployeeNotFoundException implements Exception {}