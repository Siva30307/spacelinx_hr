import '../../core/api/api_endpoints.dart';
import 'base_repository.dart';

class AttendanceRepository extends BaseRepository {
  AttendanceRepository(super.apiClient);

  Future<List<dynamic>> getAttendanceByEmployee(String employeeId) async {
    final response = await apiClient.get(ApiEndpoints.attendanceByEmployee(employeeId));
    return response.data;
  }

  Future<Map<String, dynamic>> clockIn(Map<String, dynamic> data) async {
    final response = await apiClient.post(ApiEndpoints.attendanceRecord, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> clockOut(String id, Map<String, dynamic> data) async {
    final response = await apiClient.put('${ApiEndpoints.attendanceRecord}/$id', data: data);
    return response.data;
  }
}
