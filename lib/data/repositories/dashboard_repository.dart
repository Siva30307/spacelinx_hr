import 'package:spacelinx_hr/data/models/dashboard_summary_models.dart';
import 'package:spacelinx_hr/core/api/api_client.dart';
import 'package:spacelinx_hr/core/api/api_endpoints.dart';

class DashboardRepository {
  final ApiClient _apiClient;

  DashboardRepository(this._apiClient);

  Future<HeadcountSummary> getHeadcountSummary() async {
    final response = await _apiClient.get(ApiEndpoints.headcountSummary);
    return HeadcountSummary.fromJson(response.data);
  }

  Future<AttendanceSummary> getAttendanceSummary({String? date}) async {
    final response = await _apiClient.get(
      ApiEndpoints.attendanceSummary,
      queryParameters: date != null ? {'date': date} : null,
    );
    return AttendanceSummary.fromJson(response.data);
  }

  Future<LeaveSummary> getLeaveSummary() async {
    final response = await _apiClient.get(ApiEndpoints.leaveSummary);
    return LeaveSummary.fromJson(response.data);
  }

  Future<PayrollSummary> getPayrollSummary() async {
    final response = await _apiClient.get(ApiEndpoints.payrollSummary);
    return PayrollSummary.fromJson(response.data);
  }

  Future<AttritionSummary> getAttritionSummary() async {
    final response = await _apiClient.get(ApiEndpoints.attritionSummary);
    return AttritionSummary.fromJson(response.data);
  }

  Future<List<HeadcountTrend>> getHeadcountTrend() async {
    final response = await _apiClient.get(ApiEndpoints.headcountTrend);
    return (response.data as List).map((e) => HeadcountTrend.fromJson(e)).toList();
  }
}
