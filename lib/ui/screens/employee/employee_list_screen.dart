import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';
import 'employee_create_screen.dart';
import 'employee_detail_screen.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
    });
  }

  void _confirmDelete(String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Employee', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to delete "$name"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await Provider.of<EmployeeProvider>(context, listen: false).deleteEmployee(id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(success ? 'Deleted successfully' : 'Delete failed'),
                  backgroundColor: success ? Colors.green : Colors.red,
                ));
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('All Employees', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: TextField(
              onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search employees...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4)),
                prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.4)),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.05),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1))),
                focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF6366F1))),
              ),
            ),
          ),
          Expanded(
            child: Consumer<EmployeeProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading && provider.employees.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filtered = provider.employees.where((e) {
                  final q = _searchQuery;
                  return q.isEmpty ||
                      e.fullName.toLowerCase().contains(q) ||
                      e.employeeId.toLowerCase().contains(q) ||
                      (e.departmentName?.toLowerCase().contains(q) ?? false) ||
                      (e.designation?.name.toLowerCase().contains(q) ?? false);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.people_outline, size: 64, color: Colors.white.withValues(alpha: 0.3)),
                        const SizedBox(height: 16),
                        Text('No employees found', style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final emp = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeDetailScreen(employee: emp))),
                        child: GlassCard(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundColor: const Color(0xFF6366F1).withValues(alpha: 0.2),
                                child: Text(
                                  emp.firstName[0] + emp.lastName[0],
                                  style: const TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold, fontSize: 16),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(emp.fullName, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                        _buildStatusChip(emp.employmentStatus),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(emp.employeeId, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5))),
                                    const SizedBox(height: 2),
                                    Row(
                                      children: [
                                        if (emp.departmentName != null)
                                          Text(emp.departmentName!, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                                        if (emp.departmentName != null && emp.designation != null)
                                          Text(' • ', style: TextStyle(color: Colors.white.withValues(alpha: 0.3))),
                                        if (emp.designation != null)
                                          Flexible(child: Text(emp.designation!.name, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6)), overflow: TextOverflow.ellipsis)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        _buildActionBtn(Icons.visibility, 'View', () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeDetailScreen(employee: emp)));
                                        }),
                                        _buildActionBtn(Icons.edit, 'Edit', () {
                                          Navigator.push(context, MaterialPageRoute(builder: (_) => EmployeeCreateScreen(editEmployee: emp))).then((_) {
                                            Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
                                          });
                                        }),
                                        _buildActionBtn(Icons.delete_outline, 'Delete', () => _confirmDelete(emp.id, emp.fullName), color: Colors.redAccent),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const EmployeeCreateScreen())).then((_) {
            Provider.of<EmployeeProvider>(context, listen: false).fetchEmployees();
          });
        },
        backgroundColor: const Color(0xFF6366F1),
        icon: const Icon(Icons.add),
        label: const Text('Add Employee', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Active': color = Colors.green; break;
      case 'OnNotice': color = Colors.orange; break;
      case 'Terminated': color = Colors.red; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildActionBtn(IconData icon, String label, VoidCallback onTap, {Color? color}) {
    return TextButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 14, color: color),
      label: Text(label, style: TextStyle(fontSize: 11, color: color)),
      style: TextButton.styleFrom(minimumSize: Size.zero, padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4)),
    );
  }
}
