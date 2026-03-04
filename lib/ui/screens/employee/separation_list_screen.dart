import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';

class SeparationListScreen extends StatefulWidget {
  const SeparationListScreen({super.key});

  @override
  State<SeparationListScreen> createState() => _SeparationListScreenState();
}

class _SeparationListScreenState extends State<SeparationListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<EmployeeProvider>(context, listen: false);
      provider.fetchSeparations();
      provider.fetchEmployeeLookup();
    });
  }

  void _showForm({SeparationReadModel? editItem}) {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    String? selectedEmployeeId = editItem?.employeeId;
    String? separationType = editItem?.separationType ?? 'Resignation';
    final resignDateCtrl = TextEditingController(text: editItem?.resignationDate ?? '');
    final lastWorkingCtrl = TextEditingController(text: editItem?.lastWorkingDate ?? '');
    final noticeDaysCtrl = TextEditingController(text: editItem?.noticePeriodDays?.toString() ?? '30');

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
                    Text(editItem != null ? 'Edit Separation' : 'Initiate Separation', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 16),
                    // Employee dropdown
                    DropdownButtonFormField<String>(
                      value: selectedEmployeeId,
                      dropdownColor: const Color(0xFF1E293B),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Employee'),
                      hint: Text('Select Employee', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                      items: provider.employeeLookup.map((e) => DropdownMenuItem(value: e.id, child: Text(e.fullName))).toList(),
                      onChanged: editItem != null ? null : (v) => setModalState(() => selectedEmployeeId = v),
                    ),
                    const SizedBox(height: 12),
                    // Separation Type
                    DropdownButtonFormField<String>(
                      value: separationType,
                      dropdownColor: const Color(0xFF1E293B),
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Separation Type'),
                      items: ['Resignation', 'Termination', 'Retirement', 'Absconding'].map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (v) => setModalState(() => separationType = v),
                    ),
                    const SizedBox(height: 12),
                    _buildDateField(ctx, resignDateCtrl, 'Resignation Date'),
                    const SizedBox(height: 12),
                    _buildDateField(ctx, lastWorkingCtrl, 'Last Working Date'),
                    const SizedBox(height: 12),
                    TextField(
                      controller: noticeDaysCtrl,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecor('Notice Period (Days)'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        final data = {
                          'employeeId': selectedEmployeeId,
                          'separationType': separationType,
                          'resignationDate': resignDateCtrl.text.isEmpty ? null : resignDateCtrl.text,
                          'lastWorkingDate': lastWorkingCtrl.text.isEmpty ? null : lastWorkingCtrl.text,
                          'noticePeriodDays': int.tryParse(noticeDaysCtrl.text),
                        };
                        bool success;
                        if (editItem != null) {
                          data['id'] = editItem.id;
                          data['status'] = editItem.status;
                          data['fnfStatus'] = editItem.fnfStatus;
                          data['noticeShortfallDays'] = editItem.noticeShortfallDays;
                          data['noticePeriodServed'] = editItem.noticePeriodServed;
                          success = await provider.updateSeparation(editItem.id, data);
                        } else {
                          success = await provider.createSeparation(data);
                        }
                        if (ctx.mounted) Navigator.pop(ctx);
                        if (mounted) {
                          ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                            content: Text(success ? '${editItem != null ? 'Updated' : 'Initiated'} successfully' : 'Operation failed'),
                            backgroundColor: success ? Colors.green : Colors.red,
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFF59E0B), foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: Text(editItem != null ? 'Update' : 'Initiate Separation', style: const TextStyle(fontWeight: FontWeight.bold)),
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
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('Delete Separation', style: TextStyle(color: Colors.white)),
        content: const Text('Are you sure?', style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await Provider.of<EmployeeProvider>(context, listen: false).deleteSeparation(id);
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(success ? 'Deleted' : 'Failed'), backgroundColor: success ? Colors.green : Colors.red));
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
        title: const Text('Separations', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.separations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.separations.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.exit_to_app, size: 64, color: Colors.white.withValues(alpha: 0.3)),
              const SizedBox(height: 16),
              Text('No separations found', style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
            ]));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.separations.length,
            itemBuilder: (context, index) {
              final sep = provider.separations[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GlassCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              sep.employee?.fullName ?? 'Employee',
                              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          _buildStatusChip(sep.status),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _buildChip(sep.separationType, Colors.orange),
                          const SizedBox(width: 8),
                          _buildChip('F&F: ${sep.fnfStatus}', sep.fnfStatus == 'Completed' ? Colors.green : Colors.amber),
                        ],
                      ),
                      const Divider(height: 20, color: Colors.white12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildDetail('Resignation', sep.resignationDate ?? '—'),
                          _buildDetail('Last Working', sep.lastWorkingDate ?? '—'),
                          _buildDetail('Notice', '${sep.noticePeriodServed}/${sep.noticePeriodDays ?? 0} days'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(onPressed: () => _showForm(editItem: sep), icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 12))),
                          TextButton.icon(onPressed: () => _confirmDelete(sep.id), icon: const Icon(Icons.delete_outline, size: 14, color: Colors.redAccent), label: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.redAccent))),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showForm(),
        backgroundColor: const Color(0xFFF59E0B),
        foregroundColor: Colors.black,
        icon: const Icon(Icons.add),
        label: const Text('Initiate Separation', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  InputDecoration _inputDecor(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFF59E0B))),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    );
  }

  Widget _buildDateField(BuildContext ctx, TextEditingController ctrl, String label) {
    return TextField(
      controller: ctrl,
      readOnly: true,
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecor(label).copyWith(suffixIcon: const Icon(Icons.calendar_today, color: Color(0xFFF59E0B), size: 16)),
      onTap: () async {
        final date = await showDatePicker(
          context: ctx,
          initialDate: DateTime.now(),
          firstDate: DateTime(2020),
          lastDate: DateTime(2035),
          builder: (context, child) => Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.dark(primary: Color(0xFFF59E0B), surface: Color(0xFF1E293B), onSurface: Colors.white)), child: child!),
        );
        if (date != null) ctrl.text = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    switch (status) {
      case 'Initiated': color = Colors.orange; break;
      case 'InProgress': color = Colors.blue; break;
      case 'Completed': color = Colors.green; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withValues(alpha: 0.5))),
      child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
        Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.white)),
      ],
    );
  }
}
