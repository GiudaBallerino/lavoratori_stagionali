import 'package:employees_api/employees_api.dart';

class EmployeesRepository {
  const EmployeesRepository({
    required EmployeesApi employeesApi,
  }) : _employeesApi = employeesApi;

  final EmployeesApi _employeesApi;

  Stream<List<Employee>> getEmployees() => _employeesApi.getEmployees();

  Future<void> saveWorker(Employee employee) => _employeesApi.saveEmployee(employee);

  Future<void> deleteWorker(String id) => _employeesApi.deleteEmployee(id);
}