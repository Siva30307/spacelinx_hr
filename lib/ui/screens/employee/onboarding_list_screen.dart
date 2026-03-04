import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/employee_read_model.dart';

class OnboardingListScreen extends StatefulWidget {
  const OnboardingListScreen({super.key});

  @override
  State<OnboardingListScreen> createState() => _OnboardingListScreenState();
}

class _OnboardingListScreenState extends State<OnboardingListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<EmployeeProvider>(context, listen: false).fetchOnboardingTemplates();
    });
  }

  void _showForm({OnboardingTemplateReadModel? editItem}) {
    final nameCtrl = TextEditingController(text: editItem?.name ?? '');
    final descCtrl = TextEditingController(text: editItem?.description ?? '');

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(editItem != null ? 'Edit Template' : 'Add Template', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 16),
              _buildField(nameCtrl, 'Template Name'),
              const SizedBox(height: 12),
              _buildField(descCtrl, 'Description', maxLines: 3),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final data = {'name': nameCtrl.text, 'description': descCtrl.text.isEmpty ? null : descCtrl.text};
                  final provider = Provider.of<EmployeeProvider>(ctx, listen: false);
                  bool success;
                  if (editItem != null) {
                    data['id'] = editItem.id;
                    success = await provider.updateOnboardingTemplate(editItem.id, data);
                  } else {
                    success = await provider.createOnboardingTemplate(data);
                  }
                  if (ctx.mounted) Navigator.pop(ctx);
                  if (mounted) {
                    ScaffoldMessenger.of(this.context).showSnackBar(SnackBar(
                      content: Text(success ? '${editItem != null ? 'Updated' : 'Created'} successfully' : 'Operation failed'),
                      backgroundColor: success ? Colors.green : Colors.red,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                child: Text(editItem != null ? 'Update' : 'Create', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
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
        title: const Text('Delete Template', style: TextStyle(color: Colors.white)),
        content: Text('Delete "$name"?', style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              final success = await Provider.of<EmployeeProvider>(context, listen: false).deleteOnboardingTemplate(id);
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

  void _showTasks(String templateId, String templateName) {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    provider.fetchOnboardingTasks(templateId);

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (ctx) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          expand: false,
          builder: (context, scrollController) {
            return Consumer<EmployeeProvider>(
              builder: (context, provider, _) {
                return Column(
                  children: [
                    Container(margin: const EdgeInsets.only(top: 12), width: 40, height: 4, decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.3), borderRadius: BorderRadius.circular(2))),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text(templateName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
                          IconButton(
                            icon: const Icon(Icons.add_circle, color: Color(0xFF10B981)),
                            onPressed: () => _showTaskForm(ctx, templateId),
                          ),
                        ],
                      ),
                    ),
                    if (provider.isLoading)
                      const Expanded(child: Center(child: CircularProgressIndicator()))
                    else if (provider.tasks.isEmpty)
                      Expanded(child: Center(child: Text('No tasks yet', style: TextStyle(color: Colors.white.withValues(alpha: 0.6)))))
                    else
                      Expanded(
                        child: ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: provider.tasks.length,
                          itemBuilder: (context, index) {
                            final task = provider.tasks[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white.withValues(alpha: 0.1))),
                              child: Row(
                                children: [
                                  Container(
                                    width: 32, height: 32,
                                    decoration: BoxDecoration(color: const Color(0xFF10B981).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(8)),
                                    child: Center(child: Text('${task.sortOrder}', style: const TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.bold, fontSize: 14))),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text(task.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14))),
                                            if (task.isMandatory) Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: Colors.red.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)), child: const Text('Required', style: TextStyle(color: Colors.redAccent, fontSize: 9, fontWeight: FontWeight.bold))),
                                          ],
                                        ),
                                        Text('Due: ${task.dueDaysAfterJoining} days after joining', style: TextStyle(color: Colors.white.withValues(alpha: 0.5), fontSize: 11)),
                                      ],
                                    ),
                                  ),
                                  IconButton(icon: Icon(Icons.delete_outline, size: 16, color: Colors.redAccent.withValues(alpha: 0.7)), onPressed: () async {
                                    await Provider.of<EmployeeProvider>(context, listen: false).deleteOnboardingTask(task.id);
                                    Provider.of<EmployeeProvider>(context, listen: false).fetchOnboardingTasks(templateId);
                                  }),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              },
            );
          },
        );
      },
    );
  }

  void _showTaskForm(BuildContext sheetCtx, String templateId) {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();
    final dueCtrl = TextEditingController(text: '7');
    final sortCtrl = TextEditingController(text: '1');
    bool isMandatory = false;

    showDialog(
      context: sheetCtx,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF1E293B),
              title: const Text('Add Task', style: TextStyle(color: Colors.white)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildField(titleCtrl, 'Task Title'),
                    const SizedBox(height: 8),
                    _buildField(descCtrl, 'Description'),
                    const SizedBox(height: 8),
                    Row(children: [
                      Expanded(child: _buildField(dueCtrl, 'Due Days', isNumber: true)),
                      const SizedBox(width: 8),
                      Expanded(child: _buildField(sortCtrl, 'Sort Order', isNumber: true)),
                    ]),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Mandatory', style: TextStyle(color: Colors.white)),
                        Switch(value: isMandatory, activeColor: const Color(0xFF10B981), onChanged: (v) => setDialogState(() => isMandatory = v)),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
                ElevatedButton(
                  onPressed: () async {
                    final data = {
                      'templateId': templateId,
                      'title': titleCtrl.text,
                      'description': descCtrl.text.isEmpty ? null : descCtrl.text,
                      'dueDaysAfterJoining': int.tryParse(dueCtrl.text) ?? 7,
                      'isMandatory': isMandatory,
                      'sortOrder': int.tryParse(sortCtrl.text) ?? 1,
                    };
                    Navigator.pop(ctx);
                    await Provider.of<EmployeeProvider>(sheetCtx, listen: false).createOnboardingTask(data);
                    Provider.of<EmployeeProvider>(sheetCtx, listen: false).fetchOnboardingTasks(templateId);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF10B981)),
                  child: const Text('Add'),
                ),
              ],
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Onboarding Templates', style: TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer<EmployeeProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading && provider.templates.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.templates.isEmpty) {
            return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(Icons.how_to_reg_outlined, size: 64, color: Colors.white.withValues(alpha: 0.3)),
              const SizedBox(height: 16),
              Text('No templates yet', style: TextStyle(color: Colors.white.withValues(alpha: 0.6))),
            ]));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: provider.templates.length,
            itemBuilder: (context, index) {
              final t = provider.templates[index];
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
                          Expanded(child: Text(t.name, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white))),
                          _buildStatusBadge(t.isActive),
                        ],
                      ),
                      if (t.departmentName != null) ...[
                        const SizedBox(height: 4),
                        Text(t.departmentName!, style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.5))),
                      ],
                      if (t.description != null && t.description!.isNotEmpty) ...[
                        const SizedBox(height: 6),
                        Text(t.description!, style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6), fontStyle: FontStyle.italic)),
                      ],
                      const Divider(height: 20, color: Colors.white12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(onPressed: () => _showTasks(t.id, t.name), icon: const Icon(Icons.list_alt, size: 14), label: const Text('Tasks', style: TextStyle(fontSize: 12))),
                          TextButton.icon(onPressed: () => _showForm(editItem: t), icon: const Icon(Icons.edit, size: 14), label: const Text('Edit', style: TextStyle(fontSize: 12))),
                          TextButton.icon(onPressed: () => _confirmDelete(t.id, t.name), icon: const Icon(Icons.delete_outline, size: 14, color: Colors.redAccent), label: const Text('Delete', style: TextStyle(fontSize: 12, color: Colors.redAccent))),
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
        backgroundColor: const Color(0xFF10B981),
        icon: const Icon(Icons.add),
        label: const Text('Add Template', style: TextStyle(fontWeight: FontWeight.bold)),
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
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF10B981))),
      ),
    );
  }

  Widget _buildStatusBadge(bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: (isActive ? Colors.green : Colors.grey).withValues(alpha: 0.2), borderRadius: BorderRadius.circular(6), border: Border.all(color: (isActive ? Colors.green : Colors.grey).withValues(alpha: 0.5))),
      child: Text(isActive ? 'Active' : 'Inactive', style: TextStyle(color: isActive ? Colors.green : Colors.grey, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
