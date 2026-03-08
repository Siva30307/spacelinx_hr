import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/leave_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/leave_models.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/app_search_field.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/status_chip.dart';
import 'leave_request_form_screen.dart';

class LeaveRequestListScreen extends StatefulWidget {
  const LeaveRequestListScreen({super.key});

  @override
  State<LeaveRequestListScreen> createState() => _LeaveRequestListScreenState();
}

class _LeaveRequestListScreenState extends State<LeaveRequestListScreen> {
  String _searchQuery = '';
  List<LeaveRequestReadModel> _filtered = const [];
  List<LeaveRequestReadModel> _lastSource = const [];
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaveProvider>(context, listen: false).fetchLeaveRequests();
    });
  }

  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return isoDate;
    }
  }

  void _confirmAction(String id, String action) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('$action Leave Request', style: const TextStyle(color: Colors.white)),
        content: Text(
          'Are you sure you want to ${action.toLowerCase()} this leave request?',
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = Provider.of<LeaveProvider>(context, listen: false);
              bool success;
              if (action == 'Approve') {
                success = await provider.approveLeaveRequest(id);
              } else {
                success = await provider.rejectLeaveRequest(id);
              }
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(success ? '${action}d successfully' : '$action failed'),
                  backgroundColor: success ? AppColors.success : AppColors.danger,
                ));
              }
            },
            child: Text(
              action,
              style: TextStyle(color: action == 'Approve' ? AppColors.success : AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Leave Request', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure you want to delete this leave request?', style: TextStyle(color: AppColors.textSecondary)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await Provider.of<LeaveProvider>(context, listen: false).deleteLeaveRequest(id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(success ? 'Deleted successfully' : 'Delete failed'),
                  backgroundColor: success ? AppColors.success : AppColors.danger,
                ));
              }
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            const AppHeader(title: 'Leave Requests'),
            // Search
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppSearchField(
                hintText: 'Search leave requests...',
                onChanged: (q) {
                  setState(() {
                    _searchQuery = q;
                  });
                },
              ),
            ),
            // List
            Expanded(
              child: Consumer<LeaveProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading && provider.leaveRequests.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  final source = provider.leaveRequests;
                  if (!identical(source, _lastSource) || _searchQuery != _lastQuery) {
                    _lastSource = source;
                    _lastQuery = _searchQuery;

                    final q = _searchQuery;
                    if (q.isEmpty) {
                      _filtered = source;
                    } else {
                      _filtered = source.where((r) {
                        final empName = r.employee?.fullName.toLowerCase() ?? '';
                        final type = r.leaveType?.name.toLowerCase() ?? '';
                        final status = r.status.toLowerCase();
                        return empName.contains(q) || type.contains(q) || status.contains(q);
                      }).toList(growable: false);
                    }
                  }

                  if (_filtered.isEmpty) {
                    return const AppEmptyState(
                      icon: Icons.event_note_outlined,
                      title: 'No leave requests',
                      subtitle: 'Create a request or adjust your search filters.',
                    );
                  }

                  return RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onRefresh: () async {
                      await provider.fetchLeaveRequests();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final request = _filtered[index];
                        return _buildLeaveCard(request);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final leaveProvider = context.read<LeaveProvider>();
          Navigator.push(context, MaterialPageRoute(builder: (_) => const LeaveRequestFormScreen()))
              .then((_) => leaveProvider.fetchLeaveRequests());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildLeaveCard(LeaveRequestReadModel request) {
    final empName = request.employee?.fullName ?? 'Unknown';
    final typeName = request.leaveType?.name ?? 'Leave';
    final fromDate = _formatDate(request.fromDate);
    final toDate = _formatDate(request.toDate);
    final days = request.numberOfDays;
    final isPending = request.status.toLowerCase() == 'pending';

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
              StatusChip(label: request.status),
            ],
          ),
          const SizedBox(height: 6),
          // Type + Date range
          Text(
            '$typeName • $fromDate to $toDate',
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),
          // Days + Reason
          Row(
            children: [
              Text(
                'Days: ',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              Text(
                '${days.toStringAsFixed(days.truncateToDouble() == days ? 0 : 1)} days',
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
              ),
              const SizedBox(width: 24),
              Text(
                'Reason: ',
                style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
              ),
              Flexible(
                child: Text(
                  request.reason,
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          // Action buttons for pending requests
          if (isPending) ...[
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  label: 'Approve',
                  color: AppColors.success,
                  icon: Icons.check_circle_outline,
                  onTap: () => _confirmAction(request.id, 'Approve'),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  label: 'Reject',
                  color: AppColors.danger,
                  icon: Icons.cancel_outlined,
                  onTap: () => _confirmAction(request.id, 'Reject'),
                ),
                const SizedBox(width: 8),
                _buildActionButton(
                  label: 'Delete',
                  color: AppColors.textMuted,
                  icon: Icons.delete_outline,
                  onTap: () => _confirmDelete(request.id),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}
