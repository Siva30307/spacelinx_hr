import 'package:flutter/foundation.dart';
import '../data/models/dashboard_summary_models.dart';
import '../data/repositories/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository;

  DashboardProvider(this._repository);

  HeadcountSummary? _headcountSummary;
  AttendanceSummary? _attendanceSummary;
  List<HeadcountTrend> _headcountTrend = [];
  bool _isLoading = false;

  HeadcountSummary? get headcountSummary => _headcountSummary;
  AttendanceSummary? get attendanceSummary => _attendanceSummary;
  List<HeadcountTrend> get headcountTrend => _headcountTrend;
  bool get isLoading => _isLoading;

  Future<void> fetchDashboardData(String currentDate) async {
    _isLoading = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _repository.getHeadcountSummary(),
        _repository.getAttendanceSummary(date: currentDate),
        _repository.getHeadcountTrend(),
      ]);

      _headcountSummary = results[0] as HeadcountSummary;
      _attendanceSummary = results[1] as AttendanceSummary;
      _headcountTrend = results[2] as List<HeadcountTrend>;
    } catch (e) {
      debugPrint('Error fetching dashboard data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
