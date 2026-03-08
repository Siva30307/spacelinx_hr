import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/employee_provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/employee_read_model.dart';
import '../../widgets/common/app_header.dart';
import '../../widgets/common/app_search_field.dart';
import '../../widgets/common/empty_state.dart';
import '../../widgets/common/status_chip.dart';
import 'employee_create_screen.dart';
import 'employee_detail_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  String _searchQuery = '';
  List<EmployeeReadModel> _filtered = const [];
  List<EmployeeReadModel> _lastSource = const [];
  String _lastQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
    });
  }

  void _recomputeFiltered(List<EmployeeReadModel> source, String query) {
    _lastSource = source;
    _lastQuery = query;

    if (query.isEmpty) {
      _filtered = source;
      return;
    }

    _filtered = source.where((e) {
      return e.fullName.toLowerCase().contains(query) ||
          e.employeeId.toLowerCase().contains(query) ||
          (e.departmentName?.toLowerCase().contains(query) ?? false) ||
          (e.designation?.name.toLowerCase().contains(query) ?? false);
    }).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          children: [
            const AppHeader(title: 'Employees'),
            // Search
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppSearchField(
                hintText: 'Search employees...',
                onChanged: (q) {
                  setState(() {
                    _searchQuery = q;
                  });
                },
              ),
            ),
            // List
            Expanded(
              child: Consumer<EmployeeProvider>(
                builder: (context, provider, _) {
                  if (provider.isLoading && provider.employees.isEmpty) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  }

                  final source = provider.employees;
                  if (!identical(source, _lastSource) || _searchQuery != _lastQuery) {
                    _recomputeFiltered(source, _searchQuery);
                  }

                  if (_filtered.isEmpty) {
                    return const AppEmptyState(
                      icon: Icons.people_outline,
                      title: 'No employees found',
                      subtitle: 'Try a different name, ID, department, or designation.',
                    );
                  }

                  return RefreshIndicator(
                    color: AppColors.primary,
                    backgroundColor: AppColors.surface,
                    onRefresh: () async {
                      await provider.fetchEmployees();
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _filtered.length,
                      itemBuilder: (context, index) {
                        final emp = _filtered[index];
                        return _buildEmployeeCard(emp);
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
          final employeeProvider = context.read<EmployeeProvider>();
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeeCreateScreen()))
              .then((_) => employeeProvider.fetchEmployees());
        },
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  Widget _buildEmployeeCard(EmployeeReadModel emp) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => EmployeeDetailScreen(employee: emp)),
      ),
      child: Container(
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
                    emp.fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                StatusChip(label: emp.employmentStatus),
              ],
            ),
            const SizedBox(height: 6),
            // ID • Role
            Text(
              '${emp.employeeId} • ${emp.designation?.name ?? "N/A"}',
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            // Department + Location
            Row(
              children: [
                Text(
                  'Department: ',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                Text(
                  emp.departmentName ?? 'N/A',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                ),
                const SizedBox(width: 20),
                Text(
                  'Location: ',
                  style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                ),
                Flexible(
                  child: Text(
                    emp.workLocationId ?? 'N/A',
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
