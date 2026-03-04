import 'package:flutter/material.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';
import 'package:spacelinx_hr/data/repositories/employee_repository.dart';

class EmployeeProvider with ChangeNotifier {
  final EmployeeRepository _repo;

  List<EmployeeReadModel> _employees = [];
  List<EmployeeRefModel> _employeeLookup = [];
  EmployeeReadModel? _selectedEmployee;
  List<OnboardingTemplateReadModel> _templates = [];
  List<OnboardingTaskReadModel> _tasks = [];
  List<SeparationReadModel> _separations = [];
  bool _isLoading = false;
  String? _error;

  EmployeeProvider(this._repo);

  List<EmployeeReadModel> get employees => _employees;
  List<EmployeeRefModel> get employeeLookup => _employeeLookup;
  EmployeeReadModel? get selectedEmployee => _selectedEmployee;
  List<OnboardingTemplateReadModel> get templates => _templates;
  List<OnboardingTaskReadModel> get tasks => _tasks;
  List<SeparationReadModel> get separations => _separations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ─── Employee ──────────────────────────────────────────────
  Future<void> fetchEmployees() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _employees = await _repo.getEmployees();
    } catch (e) {
      _error = 'Error fetching employees: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchEmployeeLookup() async {
    try {
      _employeeLookup = await _repo.getEmployeeLookup();
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching employee lookup: $e');
    }
  }

  Future<void> fetchEmployeeById(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _selectedEmployee = await _repo.getEmployeeById(id);
    } catch (e) {
      debugPrint('Error fetching employee: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createEmployee(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.createEmployee(data);
      await fetchEmployees();
      return true;
    } catch (e) {
      debugPrint('Error creating employee: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateEmployee(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.updateEmployee(id, data);
      await fetchEmployees();
      return true;
    } catch (e) {
      debugPrint('Error updating employee: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteEmployee(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.deleteEmployee(id);
      await fetchEmployees();
      return true;
    } catch (e) {
      debugPrint('Error deleting employee: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Onboarding Template ──────────────────────────────────
  Future<void> fetchOnboardingTemplates() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _templates = await _repo.getOnboardingTemplates();
    } catch (e) {
      _error = 'Error fetching templates: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOnboardingTemplate(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.createOnboardingTemplate(data);
      await fetchOnboardingTemplates();
      return true;
    } catch (e) {
      debugPrint('Error creating template: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOnboardingTemplate(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.updateOnboardingTemplate(id, data);
      await fetchOnboardingTemplates();
      return true;
    } catch (e) {
      debugPrint('Error updating template: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteOnboardingTemplate(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.deleteOnboardingTemplate(id);
      await fetchOnboardingTemplates();
      return true;
    } catch (e) {
      debugPrint('Error deleting template: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Onboarding Task ──────────────────────────────────────
  Future<void> fetchOnboardingTasks(String templateId) async {
    _isLoading = true;
    _tasks = [];
    notifyListeners();
    try {
      _tasks = await _repo.getOnboardingTasks(templateId);
    } catch (e) {
      debugPrint('Error fetching tasks: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createOnboardingTask(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.createOnboardingTask(data);
      return true;
    } catch (e) {
      debugPrint('Error creating task: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateOnboardingTask(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.updateOnboardingTask(id, data);
      return true;
    } catch (e) {
      debugPrint('Error updating task: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteOnboardingTask(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.deleteOnboardingTask(id);
      return true;
    } catch (e) {
      debugPrint('Error deleting task: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Separation ───────────────────────────────────────────
  Future<void> fetchSeparations() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _separations = await _repo.getSeparations();
    } catch (e) {
      _error = 'Error fetching separations: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createSeparation(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.createSeparation(data);
      await fetchSeparations();
      return true;
    } catch (e) {
      debugPrint('Error creating separation: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateSeparation(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.updateSeparation(id, data);
      await fetchSeparations();
      return true;
    } catch (e) {
      debugPrint('Error updating separation: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteSeparation(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _repo.deleteSeparation(id);
      await fetchSeparations();
      return true;
    } catch (e) {
      debugPrint('Error deleting separation: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
