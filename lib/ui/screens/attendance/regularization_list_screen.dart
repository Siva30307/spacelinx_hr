import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/attendance_provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/attendance_models.dart';

class RegularizationListScreen extends StatefulWidget {
  const RegularizationListScreen({super.key});

  @override
  State<RegularizationListScreen> createState() => _RegularizationListScreenState();
}

class _RegularizationListScreenState extends State<RegularizationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendanceProvider>(context, listen: false).fetchRegularizations();
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployeeLookup();
    });
  }

  void _showForm({AttendanceRegularizationReadModel? editItem}) {
    final empProvider = Provider.of<EmployeeProvider>(context, listen: false);
    String? selectedEmployeeId = editItem?.employeeId;
    final origInCtrl = TextEditingController(text: editItem?.originalCheckIn ?? '');
    final origOutCtrl = TextEditingController(text: editItem?.originalCheckOut ?? '');
    final reqInCtrl = TextEditingController(text: editItem?.requestedCheckIn ?? '');
    final reqOutCtrl = TextEditingController(text: editItem?.requestedCheckOut ?? '');
    final reasonCtrl = TextEditingController(text: editItem?.reason ?? '');

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
                    Text(editItem != null ? 'Edit Regularization' : 'Add Regularization', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
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
                    const Text('Original Times', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(children: [Expanded(child: _buildField(origInCtrl, 'Original In')), const SizedBox(width: 12), Expanded(child: _buildField(origOutCtrl, 'Original Out'))]),
                    const SizedBox(height: 12),
                    const Text('Requested Times', style: TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Row(children: [Expanded(child: _buildField(reqInCtrl, 'Requested In')), const SizedBox(width: 12), Expanded(child: _buildField(reqOutCtrl, 'Requested Out'))]),
                    const SizedBox(height: 12),
                    _buildField(reasonCtrl, 'Reason', maxLines: 2),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'employeeId': selectedEmployeeId,
                          'attendanceId': editItem?.attendanceId ?? '',
                          'originalCheckIn': origInCtrl.text.isEmpty ? null : origInCtrl.text,
                          'originalCheckOut': origOutCtrl.text.isEmpty ? null : origOutCtrl.text,
                          'requestedCheckIn': reqInCtrl.text.isEmpty ? null : reqInCtrl.text,
                          'requestedCheckOut': reqOutCtrl.text.isEmpty ? null : reqOutCtrl.text,
                          'reason': reasonCtrl.text,
                        };
                        final provider = Provider.of<AttendanceProvider>(ctx, listen: false);
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          data['status'] = editItem.status;
                          success = await provider.updateRegularization(editItem.id, data);
                        } else {
                          success = await provider.createRegularization(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text(success ? 'Saved!' : 'Failed'), backgroundColor: success ? Colors.green : Colors.red));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF59E0B), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(editItem != null ? 'Update' : 'Submit', style: const TextStyle(fontWeight: FontWeight.bold)),
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
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('Regularizations', style: TextStyle(fontWeight: FontWeight.bold)), foregroundColor: Colors.white),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.regularizations.isEmpty) return const Center(child: CircularProgressIndicator());
          if (provider.regularizations.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.rule_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('No regularizations', style: TextStyle(color: Colors.white.withValues(alpha: 0.6)))]));

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.regularizations.length,
            itemBuilder: (context, index) {
              final r = provider.regularizations[index];
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
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('Orig. In', r.originalCheckIn ?? '—'),
                        _buildDetail('Orig. Out', r.originalCheckOut ?? '—'),
                      ]),
                      const SizedBox(height: 6),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('Req. In', r.requestedCheckIn ?? '—'),
                        _buildDetail('Req. Out', r.requestedCheckOut ?? '—'),
                      ]),
                      const SizedBox(height: 6),
                      Text('Reason: ${r.reason}', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6), fontStyle: FontStyle.italic)),
                      const Divider(height: 16, color: Colors.white12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        if (r.status == 'Pending') ...[
                          TextButton.icon(
                            onPressed: () async {
                              final s = await Provider.of<AttendanceProvider>(context, listen: false).approveRegularization(r.id);
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s ? 'Approved' : 'Failed'), backgroundColor: s ? Colors.green : Colors.red));
                            },
                            icon: const Icon(Icons.check_circle, size: 14, color: Colors.green),
                            label: const Text('Approve', style: TextStyle(fontSize: 12, color: Colors.green)),
                          ),
                          TextButton.icon(
                            onPressed: () async {
                              final s = await Provider.of<AttendanceProvider>(context, listen: false).rejectRegularization(r.id);
                              if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s ? 'Rejected' : 'Failed'), backgroundColor: s ? Colors.orange : Colors.red));
                            },
                            icon: const Icon(Icons.cancel, size: 14, color: Colors.redAccent),
                            label: const Text('Reject', style: TextStyle(fontSize: 12, color: Colors.redAccent)),
                          ),
                        ] else
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
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _showForm(), backgroundColor: const Color(0xFFF59E0B), foregroundColor: Colors.black, icon: const Icon(Icons.add), label: const Text('Add Regularization', style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Approved': color = Colors.green; break;
      case 'Pending': color = Colors.orange; break;
      case 'Rejected': color = Colors.red; break;
      default: color = Colors.grey;
    }
    return Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withValues(alpha: 0.5))), child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));
  }

  Widget _buildDetail(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))), Text(value, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white))]);
  InputDecoration _inputDecor(String label) => InputDecoration(labelText: label, labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFF59E0B))), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12));
  Widget _buildField(TextEditingController ctrl, String label, {int maxLines = 1}) => TextField(controller: ctrl, maxLines: maxLines, style: const TextStyle(color: Colors.white), decoration: _inputDecor(label));
}
