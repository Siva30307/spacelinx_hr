import 'package:flutter/material.dart';
import 'package:spacelinx_hr/data/models/leave_models.dart';
import 'package:spacelinx_hr/data/repositories/leave_repository.dart';

class LeaveProvider with ChangeNotifier {
  final LeaveRepository _leaveRepository;

  List<LeaveTypeReadModel> _leaveTypes = [];
  List<LeavePolicyReadModel> _leavePolicies = [];
  List<LeavePolicyDetailReadModel> _leavePolicyDetails = [];
  List<LeaveRequestReadModel> _leaveRequests = [];
  List<LeaveBalanceReadModel> _leaveBalances = [];
  List<HolidayCalendarReadModel> _holidayCalendars = [];
  List<HolidayReadModel> _holidays = [];
  bool _isLoading = false;
  String? _error;

  LeaveProvider(this._leaveRepository);

  List<LeaveTypeReadModel> get leaveTypes => _leaveTypes;
  List<LeavePolicyReadModel> get leavePolicies => _leavePolicies;
  List<LeavePolicyDetailReadModel> get leavePolicyDetails => _leavePolicyDetails;
  List<LeaveRequestReadModel> get leaveRequests => _leaveRequests;
  List<LeaveBalanceReadModel> get leaveBalances => _leaveBalances;
  List<HolidayCalendarReadModel> get holidayCalendars => _holidayCalendars;
  List<HolidayReadModel> get holidays => _holidays;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // ─── Leave Type ────────────────────────────────────────────
  Future<void> fetchLeaveTypes() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _leaveTypes = await _leaveRepository.getLeaveTypes();
    } catch (e) {
      _error = 'Error fetching leave types: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createLeaveType(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createLeaveType(data);
      await fetchLeaveTypes();
      return true;
    } catch (e) {
      debugPrint('Error creating leave type: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateLeaveType(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateLeaveType(id, data);
      await fetchLeaveTypes();
      return true;
    } catch (e) {
      debugPrint('Error updating leave type: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteLeaveType(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteLeaveType(id);
      await fetchLeaveTypes();
      return true;
    } catch (e) {
      debugPrint('Error deleting leave type: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Leave Policy ──────────────────────────────────────────
  Future<void> fetchLeavePolicies() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _leavePolicies = await _leaveRepository.getLeavePolicies();
    } catch (e) {
      _error = 'Error fetching leave policies: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createLeavePolicy(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createLeavePolicy(data);
      await fetchLeavePolicies();
      return true;
    } catch (e) {
      debugPrint('Error creating leave policy: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateLeavePolicy(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateLeavePolicy(id, data);
      await fetchLeavePolicies();
      return true;
    } catch (e) {
      debugPrint('Error updating leave policy: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteLeavePolicy(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteLeavePolicy(id);
      await fetchLeavePolicies();
      return true;
    } catch (e) {
      debugPrint('Error deleting leave policy: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Leave Policy Detail ───────────────────────────────────
  Future<void> fetchLeavePolicyDetails(String policyId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _leavePolicyDetails = await _leaveRepository.getLeavePolicyDetails(policyId);
    } catch (e) {
      debugPrint('Error fetching leave policy details: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createLeavePolicyDetail(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createLeavePolicyDetail(data);
      return true;
    } catch (e) {
      debugPrint('Error creating leave policy detail: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateLeavePolicyDetail(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateLeavePolicyDetail(id, data);
      return true;
    } catch (e) {
      debugPrint('Error updating leave policy detail: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteLeavePolicyDetail(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteLeavePolicyDetail(id);
      return true;
    } catch (e) {
      debugPrint('Error deleting leave policy detail: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Leave Request ─────────────────────────────────────────
  Future<void> fetchLeaveRequests() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _leaveRequests = await _leaveRepository.getLeaveRequests();
    } catch (e) {
      _error = 'Error fetching leave requests: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createLeaveRequest(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createLeaveRequest(data);
      await fetchLeaveRequests();
      return true;
    } catch (e) {
      debugPrint('Error creating leave request: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateLeaveRequest(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateLeaveRequest(id, data);
      await fetchLeaveRequests();
      return true;
    } catch (e) {
      debugPrint('Error updating leave request: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteLeaveRequest(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteLeaveRequest(id);
      await fetchLeaveRequests();
      return true;
    } catch (e) {
      debugPrint('Error deleting leave request: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Leave Balance ─────────────────────────────────────────
  Future<void> fetchLeaveBalances(String employeeId) async {
    _isLoading = true;
    notifyListeners();
    try {
      _leaveBalances = await _leaveRepository.getLeaveBalances(employeeId);
    } catch (e) {
      debugPrint('Error fetching leave balances: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Holiday Calendar ──────────────────────────────────────
  Future<void> fetchHolidayCalendars() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _holidayCalendars = await _leaveRepository.getHolidayCalendars();
    } catch (e) {
      _error = 'Error fetching holiday calendars: $e';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createHolidayCalendar(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createHolidayCalendar(data);
      await fetchHolidayCalendars();
      return true;
    } catch (e) {
      debugPrint('Error creating holiday calendar: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateHolidayCalendar(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateHolidayCalendar(id, data);
      await fetchHolidayCalendars();
      return true;
    } catch (e) {
      debugPrint('Error updating holiday calendar: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteHolidayCalendar(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteHolidayCalendar(id);
      await fetchHolidayCalendars();
      return true;
    } catch (e) {
      debugPrint('Error deleting holiday calendar: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // ─── Holiday ───────────────────────────────────────────────
  Future<void> fetchHolidaysByCalendar(String calendarId) async {
    _isLoading = true;
    _holidays = [];
    notifyListeners();
    try {
      _holidays = await _leaveRepository.getHolidaysByCalendar(calendarId);
    } catch (e) {
      debugPrint('Error fetching holidays: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> createHoliday(Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.createHoliday(data);
      return true;
    } catch (e) {
      debugPrint('Error creating holiday: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateHoliday(String id, Map<String, dynamic> data) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.updateHoliday(id, data);
      return true;
    } catch (e) {
      debugPrint('Error updating holiday: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteHoliday(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      await _leaveRepository.deleteHoliday(id);
      return true;
    } catch (e) {
      debugPrint('Error deleting holiday: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
