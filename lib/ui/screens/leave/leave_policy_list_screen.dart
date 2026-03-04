import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/leave_models.dart';

class LeavePolicyListScreen extends StatefulWidget {
  const LeavePolicyListScreen({super.key});

  @override
  State<LeavePolicyListScreen> createState() => _LeavePolicyListScreenState();
}

class _LeavePolicyListScreenState extends State<LeavePolicyListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaveProvider>(context, listen: false).fetchLeavePolicies();
    });
  }

  void _showForm({LeavePolicyReadModel? editItem}) {
    final nameCtrl = TextEditingController(text: editItem?.name ?? '');
    final descCtrl = TextEditingController(text: editItem?.description ?? '');
    final effectiveFromCtrl = TextEditingController(text: editItem?.effectiveFrom ?? '');
    final effectiveToCtrl = TextEditingController(text: editItem?.effectiveTo ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
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
                  editItem != null ? 'Edit Leave Policy' : 'Add Leave Policy',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 16),
                _buildField(nameCtrl, 'Policy Name'),
                const SizedBox(height: 12),
                _buildField(descCtrl, 'Description', maxLines: 2),
                const SizedBox(height: 12),
                _buildDateField(context, effectiveFromCtrl, 'Effective From'),
                const SizedBox(height: 12),
                _buildDateField(context, effectiveToCtrl, 'Effective To (Optional)'),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    final data = {
                      'name': nameCtrl.text,
                      'description': descCtrl.text,
                      'effectiveFrom': effectiveFromCtrl.text,
                      'effectiveTo': effectiveToCtrl.text.isEmpty ? null : effectiveToCtrl.text,
                    };
                    final provider = Provider.of<LeaveProvider>(ctx, listen: false);
                    bool success;
                    if (editItem != null) {
                      data['id'] = editItem.id;
                      success = await provider.updateLeavePolicy(editItem.id, data);
                    } else {
                      success = await provider.createLeavePolicy(data);
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
  }

  void _confirmDelete(String id, String name) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Leave Policy', style: TextStyle(color: Colors.white)),
        content: Text('Are you sure you want to delete "$name"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final provider = Provider.of<LeaveProvider>(context, listen: false);
              final success = await provider.deleteLeavePolicy(id);
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
        title: const Text('Leave Policies', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<LeaveProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.leavePolicies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.leavePolicies.isEmpty) {
            return const Center(child: Text('No leave policies configured', style: TextStyle(color: Colors.white70)));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.leavePolicies.length,
            itemBuilder: (context, index) {
              final policy = provider.leavePolicies[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(policy.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                      const SizedBox(height: 4),
                      if (policy.description != null && policy.description!.isNotEmpty)
                        Text(policy.description!, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.6))),
                      const Divider(height: 24, color: Colors.white12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetailItem('Effective From', policy.effectiveFrom),
                          _buildDetailItem('Effective To', policy.effectiveTo ?? 'Ongoing'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () => _showForm(editItem: policy),
                            icon: const Icon(Icons.edit, size: 16),
                            label: const Text('Edit'),
                          ),
                          TextButton.icon(
                            onPressed: () => _confirmDelete(policy.id, policy.name),
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

  Widget _buildField(TextEditingController ctrl, String label, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
      ),
    );
  }

  Widget _buildDateField(BuildContext context, TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
        suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFF6366F1), size: 18),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
      ),
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2030),
          builder: (context, child) => Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.dark(primary: Color(0xFF6366F1), surface: Color(0xFF1E293B), onSurface: Colors.white),
            ),
            child: child!,
          ),
        );
        if (date != null) {
          ctrl.text = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        }
      },
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
