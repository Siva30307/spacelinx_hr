import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/leave_models.dart';

class LeaveTypeListScreen extends StatefulWidget {
  const LeaveTypeListScreen({super.key});

  @override
  State<LeaveTypeListScreen> createState() => _LeaveTypeListScreenState();
}

class _LeaveTypeListScreenState extends State<LeaveTypeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaveProvider>(context, listen: false).fetchLeaveTypes();
    });
  }

  void _showForm({LeaveTypeReadModel? editItem}) {
    final nameCtrl = TextEditingController(text: editItem?.name ?? '');
    final codeCtrl = TextEditingController(text: editItem?.code ?? '');
    final descCtrl = TextEditingController(text: editItem?.description ?? '');
    bool isPaid = editItem?.isPaid ?? false;
    bool isCarryForward = editItem?.isCarryForward ?? false;
    double maxCarryForward = editItem?.maxCarryForward ?? 0;
    bool isEncashable = editItem?.isEncashable ?? false;
    double maxEncashment = editItem?.maxEncashment ?? 0;
    final maxCfCtrl = TextEditingController(text: maxCarryForward.toString());
    final maxEncCtrl = TextEditingController(text: maxEncashment.toString());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20, right: 20, top: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      editItem != null ? 'Edit Leave Type' : 'Add Leave Type',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    _buildField(nameCtrl, 'Name'),
                    const SizedBox(height: 12),
                    _buildField(codeCtrl, 'Code'),
                    const SizedBox(height: 12),
                    _buildField(descCtrl, 'Description', maxLines: 2),
                    const SizedBox(height: 12),
                    _buildSwitch('Paid Leave', isPaid, (v) => setModalState(() => isPaid = v)),
                    _buildSwitch('Carry Forward', isCarryForward, (v) => setModalState(() => isCarryForward = v)),
                    if (isCarryForward) _buildField(maxCfCtrl, 'Max Carry Forward', isNumber: true),
                    _buildSwitch('Encashable', isEncashable, (v) => setModalState(() => isEncashable = v)),
                    if (isEncashable) _buildField(maxEncCtrl, 'Max Encashment', isNumber: true),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'name': nameCtrl.text,
                          'code': codeCtrl.text,
                          'description': descCtrl.text,
                          'isPaid': isPaid,
                          'isCarryForward': isCarryForward,
                          'maxCarryForward': double.tryParse(maxCfCtrl.text) ?? 0,
                          'isEncashable': isEncashable,
                          'maxEncashment': double.tryParse(maxEncCtrl.text) ?? 0,
                        };
                        final provider = Provider.of<LeaveProvider>(ctx, listen: false);
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          success = await provider.updateLeaveType(editItem.id, data);
                        } else {
                          success = await provider.createLeaveType(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) {
                          ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                            content: Text(success ? '${editItem != null ? 'Updated' : 'Created'} successfully' : 'Operation failed'),
                            backgroundColor: success ? Colors.green : Colors.red,
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(editItem != null ? 'Update' : 'Create', style: const TextStyle(fontWeight: FontWeight.bold)),
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
        title: const Text('Delete Leave Type', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to delete "$name"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = Provider.of<LeaveProvider>(context, listen: false);
              final success = await provider.deleteLeaveType(id);
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
        title: const Text('Leave Types', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.leaveTypes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.leaveTypes.isEmpty) {
            return const Center(child: Text('No leave types configured', style: TextStyle(color: Colors.white70)));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.leaveTypes.length,
            itemBuilder: (context, index) {
              final leaveType = provider.leaveTypes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(leaveType.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                                Text(leaveType.code, style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.6))),
                              ],
                            ),
                          ),
                          _buildStatusChip(leaveType.isPaid ? 'Paid' : 'Unpaid', leaveType.isPaid ? Colors.green : Colors.grey),
                        ],
                      ),
                      const Divider(height: 24, color: Colors.white12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailItem('Carry Forward', leaveType.isCarryForward ? 'Yes' : 'No'),
                          _buildDetailItem('Max CF', leaveType.maxCarryForward.toString()),
                          _buildDetailItem('Encashable', leaveType.isEncashable ? 'Yes' : 'No'),
                        ],
                      ),
                      if (leaveType.description != null && leaveType.description!.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(leaveType.description!, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.5), fontStyle: FontStyle.italic)),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _showForm(editItem: leaveType),
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                          ),
                          TextButton.icon(
                            onPressed: () => _confirmDelete(leaveType.id, leaveType.name),
                            icon: const Icon(Icons.delete_outline, size: 16, color: Colors.redAccent),
                            label: const Text('Delete', style: TextStyle(color: Colors.redAccent)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(),
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildField(TextEditingController ctrl, String label, {int maxLines = 1, bool isNumber = false}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
      ),
    );
  }

  Widget _buildSwitch(String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        Switch(value: value, activeColor: const Color(0xFF6366F1), onChanged: onChanged),
      ],
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
        Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
