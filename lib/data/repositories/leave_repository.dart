import 'package:spacelinx_hr/data/models/leave_models.dart';
import 'package:spacelinx_hr/core/api/api_client.dart';

class LeaveRepository {
  final ApiClient _apiClient;

  LeaveRepository(this._apiClient);

  // ─── Leave Type ────────────────────────────────────────────
  Future<List<LeaveTypeReadModel>> getLeaveTypes() async {
    final response = await _apiClient.get('/LeaveType');
    return (response.data as List).map((e) => LeaveTypeReadModel.fromJson(e)).toList();
  }

  Future<LeaveTypeReadModel> createLeaveType(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/LeaveType', data: data);
    return LeaveTypeReadModel.fromJson(response.data);
  }

  Future<LeaveTypeReadModel> updateLeaveType(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/LeaveType/$id', data: data);
    return LeaveTypeReadModel.fromJson(response.data);
  }

  Future<void> deleteLeaveType(String id) async {
    await _apiClient.delete('/LeaveType/$id');
  }

  // ─── Leave Policy ──────────────────────────────────────────
  Future<List<LeavePolicyReadModel>> getLeavePolicies() async {
    final response = await _apiClient.get('/LeavePolicy');
    return (response.data as List).map((e) => LeavePolicyReadModel.fromJson(e)).toList();
  }

  Future<LeavePolicyReadModel> createLeavePolicy(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/LeavePolicy', data: data);
    return LeavePolicyReadModel.fromJson(response.data);
  }

  Future<LeavePolicyReadModel> updateLeavePolicy(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/LeavePolicy/$id', data: data);
    return LeavePolicyReadModel.fromJson(response.data);
  }

  Future<void> deleteLeavePolicy(String id) async {
    await _apiClient.delete('/LeavePolicy/$id');
  }

  // ─── Leave Policy Detail ───────────────────────────────────
  Future<List<LeavePolicyDetailReadModel>> getLeavePolicyDetails(String policyId) async {
    final response = await _apiClient.get('/LeavePolicyDetail/ByLeavePolicy/$policyId');
    return (response.data as List).map((e) => LeavePolicyDetailReadModel.fromJson(e)).toList();
  }

  Future<LeavePolicyDetailReadModel> createLeavePolicyDetail(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/LeavePolicyDetail', data: data);
    return LeavePolicyDetailReadModel.fromJson(response.data);
  }

  Future<LeavePolicyDetailReadModel> updateLeavePolicyDetail(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/LeavePolicyDetail/$id', data: data);
    return LeavePolicyDetailReadModel.fromJson(response.data);
  }

  Future<void> deleteLeavePolicyDetail(String id) async {
    await _apiClient.delete('/LeavePolicyDetail/$id');
  }

  // ─── Leave Balance ─────────────────────────────────────────
  Future<List<LeaveBalanceReadModel>> getLeaveBalances(String employeeId) async {
    final response = await _apiClient.get('/LeaveBalance/ByEmployee/$employeeId');
    return (response.data as List).map((e) => LeaveBalanceReadModel.fromJson(e)).toList();
  }

  // ─── Leave Request ─────────────────────────────────────────
  Future<List<LeaveRequestReadModel>> getLeaveRequests() async {
    final response = await _apiClient.get('/LeaveRequest');
    return (response.data as List).map((e) => LeaveRequestReadModel.fromJson(e)).toList();
  }

  Future<List<LeaveRequestReadModel>> getMyLeaveRequests(String employeeId) async {
    final response = await _apiClient.get('/LeaveRequest/ByEmployee/$employeeId');
    return (response.data as List).map((e) => LeaveRequestReadModel.fromJson(e)).toList();
  }

  Future<LeaveRequestReadModel> createLeaveRequest(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/LeaveRequest', data: data);
    return LeaveRequestReadModel.fromJson(response.data);
  }

  Future<LeaveRequestReadModel> updateLeaveRequest(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/LeaveRequest/$id', data: data);
    return LeaveRequestReadModel.fromJson(response.data);
  }

  Future<void> deleteLeaveRequest(String id) async {
    await _apiClient.delete('/LeaveRequest/$id');
  }

  // ─── Holiday Calendar ──────────────────────────────────────
  Future<List<HolidayCalendarReadModel>> getHolidayCalendars() async {
    final response = await _apiClient.get('/HolidayCalendar');
    return (response.data as List).map((e) => HolidayCalendarReadModel.fromJson(e)).toList();
  }

  Future<HolidayCalendarReadModel> createHolidayCalendar(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/HolidayCalendar', data: data);
    return HolidayCalendarReadModel.fromJson(response.data);
  }

  Future<HolidayCalendarReadModel> updateHolidayCalendar(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/HolidayCalendar/$id', data: data);
    return HolidayCalendarReadModel.fromJson(response.data);
  }

  Future<void> deleteHolidayCalendar(String id) async {
    await _apiClient.delete('/HolidayCalendar/$id');
  }

  // ─── Holiday ───────────────────────────────────────────────
  Future<List<HolidayReadModel>> getHolidaysByCalendar(String calendarId) async {
    final response = await _apiClient.get('/Holiday/ByCalendar/$calendarId');
    return (response.data as List).map((e) => HolidayReadModel.fromJson(e)).toList();
  }

  Future<HolidayReadModel> createHoliday(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/Holiday', data: data);
    return HolidayReadModel.fromJson(response.data);
  }

  Future<HolidayReadModel> updateHoliday(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/Holiday/$id', data: data);
    return HolidayReadModel.fromJson(response.data);
  }

  Future<void> deleteHoliday(String id) async {
    await _apiClient.delete('/Holiday/$id');
  }
}
