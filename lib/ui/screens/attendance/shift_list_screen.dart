import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/attendance_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/attendance_models.dart';

class ShiftListScreen extends StatefulWidget {
  const ShiftListScreen({super.key});

  @override
  State<ShiftListScreen> createState() => _ShiftListScreenState();
}

class _ShiftListScreenState extends State<ShiftListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AttendanceProvider>(context, listen: false).fetchShifts();
    });
  }

  void _showForm({ShiftReadModel? editItem}) {
    final codeCtrl = TextEditingController(text: editItem?.code ?? '');
    final nameCtrl = TextEditingController(text: editItem?.name ?? '');
    final startCtrl = TextEditingController(text: editItem?.startTime ?? '');
    final endCtrl = TextEditingController(text: editItem?.endTime ?? '');
    final graceCtrl = TextEditingController(text: editItem?.graceMinutes.toString() ?? '15');
    final fullDayCtrl = TextEditingController(text: editItem?.fullDayHours.toString() ?? '8');
    bool isNight = editItem?.isNightShift ?? false;

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
                    Text(editItem != null ? 'Edit Shift' : 'Add Shift', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    Row(children: [Expanded(child: _buildField(codeCtrl, 'Code')), const SizedBox(width: 12), Expanded(child: _buildField(nameCtrl, 'Name'))]),
                    const SizedBox(height: 12),
                    Row(children: [Expanded(child: _buildField(startCtrl, 'Start Time')), const SizedBox(width: 12), Expanded(child: _buildField(endCtrl, 'End Time'))]),
                    const SizedBox(height: 12),
                    Row(children: [Expanded(child: _buildField(graceCtrl, 'Grace (min)', isNumber: true)), const SizedBox(width: 12), Expanded(child: _buildField(fullDayCtrl, 'Full Day (hrs)', isNumber: true))]),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      const Text('Night Shift', style: TextStyle(color: Colors.white)),
                      Switch(value: isNight, activeColor: const Color(0xFF8B5CF6), onChanged: (v) => setModalState(() => isNight = v)),
                    ]),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'code': codeCtrl.text,
                          'name': nameCtrl.text,
                          'startTime': startCtrl.text,
                          'endTime': endCtrl.text,
                          'graceMinutes': int.tryParse(graceCtrl.text) ?? 15,
                          'halfDayHours': 4,
                          'fullDayHours': int.tryParse(fullDayCtrl.text) ?? 8,
                          'isNightShift': isNight,
                        };
                        final provider = Provider.of<AttendanceProvider>(ctx, listen: false);
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          success = await provider.updateShift(editItem.id, data);
                        } else {
                          success = await provider.createShift(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(content: Text(success ? 'Saved!' : 'Failed'), backgroundColor: success ? Colors.green : Colors.red));
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(editItem != null ? 'Update' : 'Add Shift', style: const TextStyle(fontWeight: FontWeight.bold)),
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

  void _confirmDelete(String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Shift', style: TextStyle(color: Colors.white)),
        content: Text('Delete "$name"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(onPressed: () async { Navigator.pop(ctx); final s = await Provider.of<AttendanceProvider>(context, listen: false).deleteShift(id); if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(s ? 'Deleted' : 'Failed'), backgroundColor: s ? Colors.green : Colors.red)); }, child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, title: const Text('Shifts', style: TextStyle(fontWeight: FontWeight.bold)), foregroundColor: Colors.white),
      body: Consumer<AttendanceProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.shifts.isEmpty) return const Center(child: CircularProgressIndicator());
          if (provider.shifts.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.access_time_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)), const SizedBox(height: 16), Text('No shifts', style: TextStyle(color: Colors.white.withValues(alpha: 0.6)))]));

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.shifts.length,
            itemBuilder: (context, index) {
              final s = provider.shifts[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(color: const Color(0xFF8B5CF6).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6)),
                            child: Text(s.code, style: const TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          const SizedBox(width: 10),
                          Text(s.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        ]),
                        Row(children: [
                          _buildChip(s.isNightShift ? 'Night' : 'Day', s.isNightShift ? Colors.indigo : Colors.amber),
                          const SizedBox(width: 6),
                          _buildChip(s.isActive ? 'Active' : 'Inactive', s.isActive ? Colors.green : Colors.grey),
                        ]),
                      ]),
                      const SizedBox(height: 10),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _buildDetail('Start', s.startTime),
                        _buildDetail('End', s.endTime),
                        _buildDetail('Grace', '${s.graceMinutes} min'),
                        _buildDetail('Hours', '${s.fullDayHours}h'),
                      ]),
                      const Divider(height: 16, color: Colors.white12),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        TextButton.icon(onPressed: () => _showForm(editItem: s), icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 12))),
                        TextButton.icon(onPressed: () => _confirmDelete(s.id, s.name), icon: const Icon(Icons.delete_outline, size: 14, color: Colors.redAccent), label: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.redAccent))),
                      ]),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _showForm(), backgroundColor: const Color(0xFF8B5CF6), icon: const Icon(Icons.add), label: const Text('Add Shift', style: TextStyle(fontWeight: FontWeight.bold))),
    );
  }

  Widget _buildChip(String label, Color color) => Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)), child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));
  Widget _buildDetail(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))), Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white))]);
  Widget _buildField(TextEditingController ctrl, String label, {bool isNumber = false}) => TextField(controller: ctrl, keyboardType: isNumber ? TextInputType.number : TextInputType.text, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: label, labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF8B5CF6))), contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12)));
}
