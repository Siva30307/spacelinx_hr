import '../../core/api/api_endpoints.dart';
import '../../data/models/dashboard_summary_models.dart';
import 'base_repository.dart';

class DashboardRepository extends BaseRepository {
  DashboardRepository(super.apiClient);

  Future<HeadcountSummary> getHeadcountSummary() async {
    final response = await apiClient.get(ApiEndpoints.headcountSummary);
    return HeadcountSummary.fromJson(response.data);
  }

  Future<AttendanceSummary> getAttendanceSummary({String? date}) async {
    final queryParams = date != null ? {'date': date} : null;
    final response = await apiClient.get(
      ApiEndpoints.attendanceSummary,
      queryParameters: queryParams,
    );
    return AttendanceSummary.fromJson(response.data);
  }

  Future<List<HeadcountTrend>> getHeadcountTrend() async {
    final response = await apiClient.get(ApiEndpoints.headcountTrend);
    return (response.data as List).map((e) => HeadcountTrend.fromJson(e)).toList();
  }

  // Added back for completeness if needed by UI
  Future<Map<String, dynamic>> getLeaveSummary() async {
    final response = await apiClient.get(ApiEndpoints.leaveSummary);
    return response.data;
  }

  Future<Map<String, dynamic>> getPayrollSummary() async {
    final response = await apiClient.get(ApiEndpoints.payrollSummary);
    return response.data;
  }
}
