import 'package:flutter/material.dart';
import 'package:spacelinx_hr/data/models/dashboard_summary_models.dart';
import 'package:spacelinx_hr/data/repositories/dashboard_repository.dart';

class DashboardProvider with ChangeNotifier {
  final DashboardRepository _repo;

  HeadcountSummary? headcountSummary;
  AttendanceSummary? attendanceSummary;
  LeaveSummary? leaveSummary;
  PayrollSummary? payrollSummary;
  AttritionSummary? attritionSummary;
  List<HeadcountTrend> headcountTrend = [];

  bool isLoading = false;
  String? error;

  DashboardProvider(this._repo);

  /// Fetch all dashboard data concurrently.
  /// Individual failures are caught so one bad endpoint
  /// won't prevent the rest of the dashboard from rendering.
  Future<void> fetchDashboardMetrics() async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      // Fire all calls concurrently
      final results = await Future.wait<dynamic>([
        _safeCall(() => _repo.getHeadcountSummary()),
        _safeCall(() => _repo.getAttendanceSummary()),
        _safeCall(() => _repo.getLeaveSummary()),
        _safeCall(() => _repo.getPayrollSummary()),
        _safeCall(() => _repo.getAttritionSummary()),
        _safeCall(() => _repo.getHeadcountTrend()),
      ]);

      headcountSummary = results[0] as HeadcountSummary?;
      attendanceSummary = results[1] as AttendanceSummary?;
      leaveSummary = results[2] as LeaveSummary?;
      payrollSummary = results[3] as PayrollSummary?;
      attritionSummary = results[4] as AttritionSummary?;
      headcountTrend = (results[5] as List<HeadcountTrend>?) ?? [];

      // If ALL calls failed, show an error
      if (results.every((r) => r == null)) {
        error = 'All dashboard APIs failed. Check your connection.';
      }
    } catch (e) {
      error = e.toString();
      debugPrint('Dashboard fetch error: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Wraps an async call so that it returns null on failure
  /// instead of throwing.
  Future<T?> _safeCall<T>(Future<T> Function() fn) async {
    try {
      return await fn();
    } catch (e) {
      debugPrint('Dashboard partial error: $e');
      return null;
    }
  }
}
