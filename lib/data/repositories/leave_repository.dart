import '../../core/api/api_endpoints.dart';
import 'base_repository.dart';

class LeaveRepository extends BaseRepository {
  LeaveRepository(super.apiClient);

  Future<List<dynamic>> getLeaveByEmployee(String employeeId) async {
    final response = await apiClient.get(ApiEndpoints.leaveByEmployee(employeeId));
    return response.data;
  }

  Future<List<dynamic>> getLeaveBalances(String employeeId) async {
    final response = await apiClient.get('${ApiEndpoints.leaveBalance}/ByEmployee/$employeeId');
    return response.data;
  }

  Future<Map<String, dynamic>> submitLeaveRequest(Map<String, dynamic> data) async {
    final response = await apiClient.post(ApiEndpoints.leaveRequest, data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateLeaveRequestStatus(String id, String status) async {
    final response = await apiClient.put('${ApiEndpoints.leaveRequest}/$id', data: {'status': status});
    return response.data;
  }
}
