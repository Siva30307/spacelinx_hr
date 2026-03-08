import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/attendance_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/attendance_models.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/app_search_field.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/status_chip.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  String _searchQuery = '';
  List<AttendanceRecordReadModel> _filtered = const [];
  List<AttendanceRecordReadModel> _lastSource = const [];
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendanceProvider>(context, listen: false).fetchRecords();
    });
  }

  String _formatTime(String? isoTime) {
    if (isoTime == null || isoTime.isEmpty) return '-';
    try {
      final dt = DateTime.parse(isoTime);
      return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
    } catch (_) {
      // Try to parse time-only strings like "09:00:00"
      if (isoTime.contains(':')) {
        final parts = isoTime.split(':');
        if (parts.length >= 2) return '${parts[0]}:${parts[1]}';
      }
      return isoTime;
    }
  }

  String _formatHours(double? hours) {
    if (hours == null || hours == 0) return '-';
    final h = hours.floor();
    final m = ((hours - h) * 60).round();
    return '$h:${m.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            const AppHeader(title: 'Attendance'),
            // Search
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppSearchField(
                hintText: 'Search attendance...',
                onChanged: (q) {
                  setState(() {
                    _searchQuery = q;
                  });
                },
              ),
            ),
            // List
            Expanded(
              child: Consumer<AttendanceProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading && provider.records.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  final source = provider.records;
                  if (!identical(source, _lastSource) || _searchQuery != _lastQuery) {
                    _lastSource = source;
                    _lastQuery = _searchQuery;

                    final q = _searchQuery;
                    if (q.isEmpty) {
                      _filtered = source;
                    } else {
                      _filtered = source.where((r) {
                        final empName = r.employee?.fullName.toLowerCase() ?? '';
                        final status = r.status.toLowerCase();
                        return empName.contains(q) || status.contains(q);
                      }).toList(growable: false);
                    }
                  }

                  if (_filtered.isEmpty) {
                    return const AppEmptyState(
                      icon: Icons.calendar_today_outlined,
                      title: 'No attendance records',
                      subtitle: 'Pull to refresh or try a different search.',
                    );
                  }

                  return RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onRefresh: () async {
                      await provider.fetchRecords();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 20),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final record = _filtered[index];
                        return _buildAttendanceCard(record);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCard(AttendanceRecordReadModel record) {
    final empName = record.employee?.fullName ?? 'Unknown';
    final checkIn = _formatTime(record.checkIn);
    final checkOut = _formatTime(record.checkOut);
    final shiftName = record.shift?.name ?? 'General Shift';
    final totalHrs = _formatHours(record.totalHours);
    final lateMin = record.lateMinutes > 0 ? '${record.lateMinutes} min' : '-';
    final overtime = _formatHours(record.overtimeHours);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + Status
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  empName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              StatusChip(label: record.status),
            ],
          ),
          const SizedBox(height: 6),
          // Time range + Shift
          Text(
            '$checkIn - $checkOut • $shiftName',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          // Total Hours / Late / Overtime
          Row(
            children: [
              _buildInfoItem('Total Hours', totalHrs),
              const SizedBox(width: 24),
              _buildInfoItem('Late', lateMin),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              _buildInfoItem('Overtime', overtime),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
        ),
      ],
    );
  }
}
