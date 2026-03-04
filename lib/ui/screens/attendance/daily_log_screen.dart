import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/attendance_provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/attendance_models.dart';

class DailyLogScreen extends StatefulWidget {
  const DailyLogScreen({super.key});

  @override
  State<DailyLogScreen> createState() => _DailyLogScreenState();
}

class _DailyLogScreenState extends State<DailyLogScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendanceProvider>(context, listen: false).fetchRecords();
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployeeLookup();
    });
  }

  void _showForm({AttendanceRecordReadModel? editItem}) {
    final empProvider = Provider.of<EmployeeProvider>(context, listen: false);
    String? selectedEmployeeId = editItem?.employeeId;
    final dateCtrl = TextEditingController(text: editItem?.attendanceDate ?? '');
    final checkInCtrl = TextEditingController(text: editItem?.checkIn ?? '');
    final checkOutCtrl = TextEditingController(text: editItem?.checkOut ?? '');
    String status = editItem?.status ?? 'Present';
    final totalHoursCtrl = TextEditingController(text: editItem?.totalHours?.toString() ?? '');
    final lateCtrl = TextEditingController(text: editItem?.lateMinutes.toString() ?? '0');
    String? source = editItem?.source;
    final remarksCtrl = TextEditingController(text: editItem?.remarks ?? '');

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
                    Text(editItem != null ? 'Edit Record' : 'Add Record', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: selectedEmployeeId,
                      dropdownColor: const Color(0xFF1E293B),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Employee'),
                      hint: Text('Select Employee', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                      items: empProvider.employeeLookup.map((e) => DropdownMenuItem(value: e.id, child: Text(e.fullName))).toList(),
                      onChanged: editItem != null ? null : (v) => setModalState(() => selectedEmployeeId = v),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(ctx, dateCtrl, 'Date'),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(child: _buildField(checkInCtrl, 'Check In')),
                      const SizedBox(width: 12),
                      Expanded(child: _buildField(checkOutCtrl, 'Check Out')),
                    ]),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: status,
                      dropdownColor: const Color(0xFF1E293B),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Status'),
                      items: ['Present', 'Absent', 'WFH', 'HalfDay', 'OnLeave', 'Holiday'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setModalState(() => status = v ?? 'Present'),
                    ),
                    const SizedBox(height: 12),
                    Row(children: [
                      Expanded(child: _buildField(totalHoursCtrl, 'Total Hours', isNumber: true)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildField(lateCtrl, 'Late (min)', isNumber: true)),
                    ]),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: source,
                      dropdownColor: const Color(0xFF1E293B),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Source'),
                      items: ['Biometric', 'Web', 'Mobile', 'Manual'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setModalState(() => source = v),
                    ),
                    const SizedBox(height: 12),
                    _buildField(remarksCtrl, 'Remarks'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'employeeId': selectedEmployeeId,
                          'attendanceDate': dateCtrl.text,
                          'checkIn': checkInCtrl.text.isEmpty ? null : checkInCtrl.text,
                          'checkOut': checkOutCtrl.text.isEmpty ? null : checkOutCtrl.text,
                          'status': status,
                          'totalHours': double.tryParse(totalHoursCtrl.text),
                          'lateMinutes': int.tryParse(lateCtrl.text) ?? 0,
                          'earlyLeaveMinutes': 0,
                          'source': source,
                          'remarks': remarksCtrl.text.isEmpty ? null : remarksCtrl.text,
                        };
                        final provider = Provider.of<AttendanceProvider>(ctx, listen: false);
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          success = await provider.updateRecord(editItem.id, data);
                        } else {
                          success = await provider.createRecord(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text(success ? 'Saved!' : 'Failed'), backgroundColor: success ? Colors.green : Colors.red));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF3B82F6), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(editItem != null ? 'Update' : 'Add Record', style: const TextStyle(fontWeight: FontWeight.bold)),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('Attendance Log', style: TextStyle(fontWeight: FontWeight.bold)), foregroundColor: Colors.white),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.records.isEmpty) return const Center(child: CircularProgressIndicator());
          if (provider.records.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.schedule_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('No records', style: TextStyle(color: Colors.white.withValues(alpha: 0.6)))]));

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.records.length,
            itemBuilder: (context, index) {
              final r = provider.records[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(child: Text(r.employee?.fullName ?? 'Employee', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white))),
                        _buildStatusChip(r.status),
                      ]),
                      const SizedBox(height: 8),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('Date', r.attendanceDate),
                        _buildDetail('Check In', r.checkIn ?? '—'),
                        _buildDetail('Check Out', r.checkOut ?? '—'),
                      ]),
                      const SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('Hours', r.totalHours?.toStringAsFixed(1) ?? '—'),
                        _buildDetail('Late', '${r.lateMinutes} min'),
                        _buildDetail('Source', r.source ?? '—'),
                      ]),
                      const Divider(height: 16, color: Colors.white12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton.icon(onPressed: () => _showForm(editItem: r), icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 12))),
                      ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _showForm(), backgroundColor: const Color(0xFF3B82F6), icon: const Icon(Icons.add), label: const Text('Add Record', style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Present': color = Colors.green; break;
      case 'WFH': color = Colors.blue; break;
      case 'Absent': color = Colors.red; break;
      case 'HalfDay': color = Colors.orange; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetail(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
    Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white)),
  ]);

  InputDecoration _inputDecor(String label) => InputDecoration(labelText: label, labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF3B82F6))), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12));

  Widget _buildField(TextEditingController ctrl, String label, {bool isNumber = false}) => TextField(controller: ctrl, keyboardType: isNumber ? TextInputType.number : TextInputType.text, style: const TextStyle(color: Colors.white), decoration: _inputDecor(label));

  Widget _buildDateField(BuildContext ctx, TextEditingController ctrl, String label) => TextField(
    controller: ctrl, readOnly: true, style: const TextStyle(color: Colors.white),
    decoration: _inputDecor(label).copyWith(suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF3B82F6), size: 16)),
    onTap: () async {
      final d = await showDatePicker(context: ctx, initialDate: DateTime.now(), firstDate: DateTime(2024), lastDate: DateTime(2035), builder: (c, w) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFF3B82F6), surface: Color(0xFF1E293B), onSurface: Colors.white)), child: w!));
      if (d != null) ctrl.text = '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    },
  );
}
