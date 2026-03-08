import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/attendance_provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/attendance_models.dart';

class ShiftAssignmentScreen extends StatefulWidget {
  const ShiftAssignmentScreen({super.key});

  @override
  State<ShiftAssignmentScreen> createState() => _ShiftAssignmentScreenState();
}

class _ShiftAssignmentScreenState extends State<ShiftAssignmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendanceProvider>(context, listen: false).fetchAssignments();
      Provider.of<AttendanceProvider>(context, listen: false).fetchShiftLookup();
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployeeLookup();
    });
  }

  void _showForm({ShiftAssignmentReadModel? editItem}) {
    String? selectedEmployeeId = editItem?.employeeId;
    String? selectedShiftId = editItem?.shiftId;
    final fromCtrl = TextEditingController(text: editItem?.effectiveFrom ?? '');
    final toCtrl = TextEditingController(text: editItem?.effectiveTo ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(editItem != null ? 'Edit Assignment' : 'Add Assignment', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    Consumer2<EmployeeProvider, AttendanceProvider>(
                      builder: (context, empProvider, attProvider, _) {
                        return Column(
                          children: [
                            DropdownButtonFormField<String>(
                              value: selectedEmployeeId,
                              dropdownColor: const Color(0xFF1E293B),
                              style: const TextStyle(color: Colors.white),
                              isExpanded: true,
                              decoration: _inputDecor('Employee'),
                              hint: Text(empProvider.isLoading ? 'Loading...' : 'Select Employee', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                              items: empProvider.employeeLookup.map((e) => DropdownMenuItem(value: e.id, child: Text(e.fullName, overflow: TextOverflow.ellipsis))).toList(),
                              onChanged: (v) => setModalState(() => selectedEmployeeId = v),
                            ),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(
                              value: selectedShiftId,
                              dropdownColor: const Color(0xFF1E293B),
                              style: const TextStyle(color: Colors.white),
                              isExpanded: true,
                              decoration: _inputDecor('Shift'),
                              hint: Text(attProvider.isLoading ? 'Loading...' : 'Select Shift', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                              items: attProvider.shiftLookup.map((s) => DropdownMenuItem(value: s.id, child: Text('${s.code} - ${s.name}', overflow: TextOverflow.ellipsis))).toList(),
                              onChanged: (v) => setModalState(() => selectedShiftId = v),
                            ),
                          ],
                        );
                      }
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(ctx, fromCtrl, 'Effective From'),
                    const SizedBox(height: 12),
                    _buildDateField(ctx, toCtrl, 'Effective To (Optional)'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        if (selectedEmployeeId == null || selectedShiftId == null || fromCtrl.text.isEmpty) {
                          ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(content: Text('Please select Employee, Shift, and Effective From date'), backgroundColor: Colors.red));
                          return;
                        }
                        final data = {
                          'employeeId': selectedEmployeeId,
                          'shiftId': selectedShiftId,
                          'effectiveFrom': fromCtrl.text,
                          'effectiveTo': toCtrl.text.isEmpty ? null : toCtrl.text,
                        };
                        final provider = Provider.of<AttendanceProvider>(ctx, listen: false);
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          success = await provider.updateAssignment(editItem.id, data);
                        } else {
                          success = await provider.createAssignment(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text(success ? 'Saved!' : 'Failed'), backgroundColor: success ? Colors.green : Colors.red));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(editItem != null ? 'Update' : 'Add Assignment', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDelete(String id) {
    showDialog(context: context, builder: (ctx) => AlertDialog(backgroundColor: const Color(0xFF1E293B), title: const Text('Delete Assignment', style: TextStyle(color: Colors.white)), content: const Text('Are you sure?', style: TextStyle(color: Colors.white70)), actions: [
      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
      TextButton(onPressed: () async { Navigator.pop(ctx); final s = await Provider.of<AttendanceProvider>(context, listen: false).deleteAssignment(id); if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s ? 'Deleted' : 'Failed'), backgroundColor: s ? Colors.green : Colors.red)); }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('Shift Assignments', style: TextStyle(fontWeight: FontWeight.bold)), foregroundColor: Colors.white),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.assignments.isEmpty) return const Center(child: CircularProgressIndicator());
          if (provider.assignments.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.assignment_ind_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('No assignments', style: TextStyle(color: Colors.white.withValues(alpha: 0.6)))]));

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.assignments.length,
            itemBuilder: (context, index) {
              final a = provider.assignments[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(child: Text(a.employee?.fullName ?? 'Employee', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))),
                        _buildChip(a.isActive ? 'Active' : 'Inactive', a.isActive ? Colors.green : Colors.grey),
                      ]),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                        child: Text(a.shift != null ? '${a.shift!.code} - ${a.shift!.name}' : 'Unknown Shift', style: const TextStyle(color: Color(0xFF8B5CF6), fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('From', a.effectiveFrom),
                        _buildDetail('To', a.effectiveTo ?? '—'),
                      ]),
                      const Divider(height: 16, color: Colors.white12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton.icon(onPressed: () => _showForm(editItem: a), icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 12))),
                        TextButton.icon(onPressed: () => _confirmDelete(a.id), icon: const Icon(Icons.delete_outline, size: 14, color: Colors.redAccent), label: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.redAccent))),
                      ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _showForm(), backgroundColor: const Color(0xFF10B981), icon: const Icon(Icons.add), label: const Text('Add Assignment', style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildChip(String label, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)), child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));
  Widget _buildDetail(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))), Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))]);
  InputDecoration _inputDecor(String label) => InputDecoration(labelText: label, labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF10B981))), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12));
  Widget _buildDateField(BuildContext ctx, TextEditingController ctrl, String label) => TextField(controller: ctrl, readOnly: true, style: const TextStyle(color: Colors.white), decoration: _inputDecor(label).copyWith(suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF10B981), size: 16)), onTap: () async { final d = await showDatePicker(context: ctx, initialDate: DateTime.now(), firstDate: DateTime(2024), lastDate: DateTime(2035), builder: (c, w) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFF10B981), surface: Color(0xFF1E293B), onSurface: Colors.white)), child: w!)); if (d != null) ctrl.text = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}'; });
}
