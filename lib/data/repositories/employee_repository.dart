import 'package:spacelinx_hr/data/models/employee_read_model.dart';
import 'package:spacelinx_hr/core/api/api_client.dart';

class EmployeeRepository {
  final ApiClient _apiClient;

  EmployeeRepository(this._apiClient);

  // ─── Employee ──────────────────────────────────────────────
  Future<List<EmployeeReadModel>> getEmployees() async {
    final response = await _apiClient.get('/Employee');
    return (response.data as List).map((e) => EmployeeReadModel.fromJson(e)).toList();
  }

  Future<EmployeeReadModel> getEmployeeById(String id) async {
    final response = await _apiClient.get('/Employee/$id');
    return EmployeeReadModel.fromJson(response.data);
  }

  Future<List<EmployeeRefModel>> getEmployeeLookup() async {
    final response = await _apiClient.get('/Employee/Lookup');
    return (response.data as List).map((e) => EmployeeRefModel.fromJson(e)).toList();
  }

  Future<EmployeeReadModel> createEmployee(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/Employee', data: data);
    return EmployeeReadModel.fromJson(response.data);
  }

  Future<EmployeeReadModel> updateEmployee(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/Employee/$id', data: data);
    return EmployeeReadModel.fromJson(response.data);
  }

  Future<void> deleteEmployee(String id) async {
    await _apiClient.delete('/Employee/$id');
  }

  // ─── Onboarding Template ──────────────────────────────────
  Future<List<OnboardingTemplateReadModel>> getOnboardingTemplates() async {
    final response = await _apiClient.get('/OnboardingTemplate');
    return (response.data as List).map((e) => OnboardingTemplateReadModel.fromJson(e)).toList();
  }

  Future<OnboardingTemplateReadModel> createOnboardingTemplate(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/OnboardingTemplate', data: data);
    return OnboardingTemplateReadModel.fromJson(response.data);
  }

  Future<OnboardingTemplateReadModel> updateOnboardingTemplate(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/OnboardingTemplate/$id', data: data);
    return OnboardingTemplateReadModel.fromJson(response.data);
  }

  Future<void> deleteOnboardingTemplate(String id) async {
    await _apiClient.delete('/OnboardingTemplate/$id');
  }

  // ─── Onboarding Task ──────────────────────────────────────
  Future<List<OnboardingTaskReadModel>> getOnboardingTasks(String templateId) async {
    final response = await _apiClient.get('/OnboardingTask/ByTemplate/$templateId');
    return (response.data as List).map((e) => OnboardingTaskReadModel.fromJson(e)).toList();
  }

  Future<OnboardingTaskReadModel> createOnboardingTask(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/OnboardingTask', data: data);
    return OnboardingTaskReadModel.fromJson(response.data);
  }

  Future<OnboardingTaskReadModel> updateOnboardingTask(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/OnboardingTask/$id', data: data);
    return OnboardingTaskReadModel.fromJson(response.data);
  }

  Future<void> deleteOnboardingTask(String id) async {
    await _apiClient.delete('/OnboardingTask/$id');
  }

  // ─── Separation ───────────────────────────────────────────
  Future<List<SeparationReadModel>> getSeparations() async {
    final response = await _apiClient.get('/Separation');
    return (response.data as List).map((e) => SeparationReadModel.fromJson(e)).toList();
  }

  Future<SeparationReadModel> createSeparation(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/Separation', data: data);
    return SeparationReadModel.fromJson(response.data);
  }

  Future<SeparationReadModel> updateSeparation(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/Separation/$id', data: data);
    return SeparationReadModel.fromJson(response.data);
  }

  Future<void> deleteSeparation(String id) async {
    await _apiClient.delete('/Separation/$id');
  }
}
