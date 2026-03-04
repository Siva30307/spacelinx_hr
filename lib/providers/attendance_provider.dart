import 'package:flutter/material.dart';
import 'package:spacelinx_hr/data/models/attendance_models.dart';
import 'package:spacelinx_hr/data/repositories/attendance_repository.dart';

class AttendanceProvider with ChangeNotifier {
  final AttendanceRepository _repo;

  List<AttendanceRecordReadModel> _records = [];
  List<ShiftReadModel> _shifts = [];
  List<ShiftRefModel> _shiftLookup = [];
  List<ShiftAssignmentReadModel> _assignments = [];
  List<AttendanceRegularizationReadModel> _regularizations = [];
  bool _isLoading = false;
  String? _error;

  AttendanceProvider(this._repo);

  List<AttendanceRecordReadModel> get records => _records;
  List<ShiftReadModel> get shifts => _shifts;
  List<ShiftRefModel> get shiftLookup => _shiftLookup;
  List<ShiftAssignmentReadModel> get assignments => _assignments;
  List<AttendanceRegularizationReadModel> get regularizations => _regularizations;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ─── Attendance Record ────────────────────────────────────
  Future<void> fetchRecords() async {
    _isLoading = true; _error = null; notifyListeners();
    try { _records = await _repo.getAttendanceRecords(); }
    catch (e) { _error = 'Error: $e'; debugPrint(_error); }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> createRecord(Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.createAttendanceRecord(data); await fetchRecords(); return true; }
    catch (e) { debugPrint('Error creating record: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> updateRecord(String id, Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.updateAttendanceRecord(id, data); await fetchRecords(); return true; }
    catch (e) { debugPrint('Error updating record: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> deleteRecord(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.deleteAttendanceRecord(id); await fetchRecords(); return true; }
    catch (e) { debugPrint('Error deleting record: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  // ─── Shift ────────────────────────────────────────────────
  Future<void> fetchShifts() async {
    _isLoading = true; _error = null; notifyListeners();
    try { _shifts = await _repo.getShifts(); }
    catch (e) { _error = 'Error: $e'; debugPrint(_error); }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<void> fetchShiftLookup() async {
    try { _shiftLookup = await _repo.getShiftLookup(); notifyListeners(); }
    catch (e) { debugPrint('Error: $e'); }
  }

  Future<bool> createShift(Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.createShift(data); await fetchShifts(); return true; }
    catch (e) { debugPrint('Error creating shift: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> updateShift(String id, Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.updateShift(id, data); await fetchShifts(); return true; }
    catch (e) { debugPrint('Error updating shift: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> deleteShift(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.deleteShift(id); await fetchShifts(); return true; }
    catch (e) { debugPrint('Error deleting shift: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  // ─── Shift Assignment ─────────────────────────────────────
  Future<void> fetchAssignments() async {
    _isLoading = true; _error = null; notifyListeners();
    try { _assignments = await _repo.getShiftAssignments(); }
    catch (e) { _error = 'Error: $e'; debugPrint(_error); }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> createAssignment(Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.createShiftAssignment(data); await fetchAssignments(); return true; }
    catch (e) { debugPrint('Error creating assignment: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> updateAssignment(String id, Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.updateShiftAssignment(id, data); await fetchAssignments(); return true; }
    catch (e) { debugPrint('Error updating assignment: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> deleteAssignment(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.deleteShiftAssignment(id); await fetchAssignments(); return true; }
    catch (e) { debugPrint('Error deleting assignment: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  // ─── Regularization ───────────────────────────────────────
  Future<void> fetchRegularizations() async {
    _isLoading = true; _error = null; notifyListeners();
    try { _regularizations = await _repo.getRegularizations(); }
    catch (e) { _error = 'Error: $e'; debugPrint(_error); }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> createRegularization(Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.createRegularization(data); await fetchRegularizations(); return true; }
    catch (e) { debugPrint('Error creating regularization: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> updateRegularization(String id, Map<String, dynamic> data) async {
    _isLoading = true; notifyListeners();
    try { await _repo.updateRegularization(id, data); await fetchRegularizations(); return true; }
    catch (e) { debugPrint('Error updating regularization: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> deleteRegularization(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.deleteRegularization(id); await fetchRegularizations(); return true; }
    catch (e) { debugPrint('Error deleting regularization: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> approveRegularization(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.approveRegularization(id); await fetchRegularizations(); return true; }
    catch (e) { debugPrint('Error approving: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }

  Future<bool> rejectRegularization(String id) async {
    _isLoading = true; notifyListeners();
    try { await _repo.rejectRegularization(id); await fetchRegularizations(); return true; }
    catch (e) { debugPrint('Error rejecting: $e'); return false; }
    finally { _isLoading = false; notifyListeners(); }
  }
}
