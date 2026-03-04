import 'package:spacelinx_hr/data/models/attendance_models.dart';
import 'package:spacelinx_hr/core/api/api_client.dart';

class AttendanceRepository {
  final ApiClient _apiClient;

  AttendanceRepository(this._apiClient);

  // ─── Attendance Record (Daily Log) ────────────────────────
  Future<List<AttendanceRecordReadModel>> getAttendanceRecords() async {
    final response = await _apiClient.get('/AttendanceRecord');
    return (response.data as List).map((e) => AttendanceRecordReadModel.fromJson(e)).toList();
  }

  Future<AttendanceRecordReadModel> createAttendanceRecord(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/AttendanceRecord', data: data);
    return AttendanceRecordReadModel.fromJson(response.data);
  }

  Future<AttendanceRecordReadModel> updateAttendanceRecord(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/AttendanceRecord/$id', data: data);
    return AttendanceRecordReadModel.fromJson(response.data);
  }

  Future<void> deleteAttendanceRecord(String id) async {
    await _apiClient.delete('/AttendanceRecord/$id');
  }

  // ─── Shift ────────────────────────────────────────────────
  Future<List<ShiftReadModel>> getShifts() async {
    final response = await _apiClient.get('/Shift');
    return (response.data as List).map((e) => ShiftReadModel.fromJson(e)).toList();
  }

  Future<List<ShiftRefModel>> getShiftLookup() async {
    final response = await _apiClient.get('/Shift/Lookup');
    return (response.data as List).map((e) => ShiftRefModel.fromJson(e)).toList();
  }

  Future<ShiftReadModel> createShift(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/Shift', data: data);
    return ShiftReadModel.fromJson(response.data);
  }

  Future<ShiftReadModel> updateShift(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/Shift/$id', data: data);
    return ShiftReadModel.fromJson(response.data);
  }

  Future<void> deleteShift(String id) async {
    await _apiClient.delete('/Shift/$id');
  }

  // ─── Shift Assignment ─────────────────────────────────────
  Future<List<ShiftAssignmentReadModel>> getShiftAssignments() async {
    final response = await _apiClient.get('/ShiftAssignment');
    return (response.data as List).map((e) => ShiftAssignmentReadModel.fromJson(e)).toList();
  }

  Future<ShiftAssignmentReadModel> createShiftAssignment(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/ShiftAssignment', data: data);
    return ShiftAssignmentReadModel.fromJson(response.data);
  }

  Future<ShiftAssignmentReadModel> updateShiftAssignment(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/ShiftAssignment/$id', data: data);
    return ShiftAssignmentReadModel.fromJson(response.data);
  }

  Future<void> deleteShiftAssignment(String id) async {
    await _apiClient.delete('/ShiftAssignment/$id');
  }

  // ─── Attendance Regularization ────────────────────────────
  Future<List<AttendanceRegularizationReadModel>> getRegularizations() async {
    final response = await _apiClient.get('/AttendanceRegularization');
    return (response.data as List).map((e) => AttendanceRegularizationReadModel.fromJson(e)).toList();
  }

  Future<AttendanceRegularizationReadModel> createRegularization(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/AttendanceRegularization', data: data);
    return AttendanceRegularizationReadModel.fromJson(response.data);
  }

  Future<AttendanceRegularizationReadModel> updateRegularization(String id, Map<String, dynamic> data) async {
    final response = await _apiClient.put('/AttendanceRegularization/$id', data: data);
    return AttendanceRegularizationReadModel.fromJson(response.data);
  }

  Future<void> deleteRegularization(String id) async {
    await _apiClient.delete('/AttendanceRegularization/$id');
  }

  Future<void> approveRegularization(String id) async {
    await _apiClient.put('/AttendanceRegularization/$id/Approve');
  }

  Future<void> rejectRegularization(String id) async {
    await _apiClient.put('/AttendanceRegularization/$id/Reject');
  }
}
