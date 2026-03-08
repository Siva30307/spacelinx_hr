import 'package:flutter/material.dart';
import 'package:spacelinx_hr/data/models/organization_models.dart';
import 'package:spacelinx_hr/data/repositories/organization_repository.dart';

class OrganizationProvider with ChangeNotifier {
  final OrganizationRepository _repo;

  List<DepartmentRefModel> _departments = [];
  List<DesignationRefModel> _designations = [];
  List<GradeRefModel> _grades = [];
  List<CostCenterRefModel> _costCenters = [];
  List<WorkLocationRefModel> _workLocations = [];
  bool _isLoading = false;

  OrganizationProvider(this._repo);

  List<DepartmentRefModel> get departments => _departments;
  List<DesignationRefModel> get designations => _designations;
  List<GradeRefModel> get grades => _grades;
  List<CostCenterRefModel> get costCenters => _costCenters;
  List<WorkLocationRefModel> get workLocations => _workLocations;
  bool get isLoading => _isLoading;

  Future<void> fetchAllLookups() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.wait([
        _fetchDepartments(),
        _fetchDesignations(),
        _fetchGrades(),
        _fetchCostCenters(),
        _fetchWorkLocations(),
      ]);
    } catch (e) {
      debugPrint('Error fetching organization lookups: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _fetchDepartments() async {
    try {
      _departments = await _repo.getDepartmentLookup();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _fetchDesignations() async {
    try {
      _designations = await _repo.getDesignationLookup();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _fetchGrades() async {
    try {
      _grades = await _repo.getGradeLookup();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _fetchCostCenters() async {
    try {
      _costCenters = await _repo.getCostCenterLookup();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> _fetchWorkLocations() async {
    try {
      _workLocations = await _repo.getWorkLocationLookup();
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
