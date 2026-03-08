import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spacelinx_hr/providers/leave_provider.dart';
import 'package:spacelinx_hr/ui/widgets/common/glass_card.dart';
import 'package:spacelinx_hr/data/models/leave_models.dart';
import 'package:spacelinx_hr/providers/employee_provider.dart';

class LeaveRequestFormScreen extends StatefulWidget {
  final LeaveRequestReadModel? editItem;

  const LeaveRequestFormScreen({super.key, this.editItem});

  @override
  State<LeaveRequestFormScreen> createState() => _LeaveRequestFormScreenState();
}

class _LeaveRequestFormScreenState extends State<LeaveRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedEmployeeId;
  String? _selectedLeaveTypeId;
  DateTime? _fromDate;
  DateTime? _toDate;
  double _numberOfDays = 1;
  bool _isHalfDay = false;
  String? _halfDayType;
  final _reasonController = TextEditingController();

  bool get _isEditMode => widget.editItem != null;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaveProvider>(context, listen: false).fetchLeaveTypes();
      Provider.of<EmployeeProvider>(context, listen: false).fetchEmployeeLookup();
    });

    // Pre-fill form if editing
    if (widget.editItem != null) {
      final item = widget.editItem!;
      _selectedEmployeeId = item.employeeId;
      _selectedLeaveTypeId = item.leaveTypeId;
      _fromDate = DateTime.tryParse(item.fromDate);
      _toDate = DateTime.tryParse(item.toDate);
      _numberOfDays = item.numberOfDays;
      _isHalfDay = item.isHalfDay;
      _halfDayType = item.halfDayType;
      _reasonController.text = item.reason;
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _recalculateDays() {
    if (_fromDate != null && _toDate != null) {
      final diff = _toDate!.difference(_fromDate!).inDays + 1;
      setState(() {
        _numberOfDays = _isHalfDay ? 0.5 : diff.toDouble();
      });
    }
  }

  Future<void> _pickDate(BuildContext context, bool isFrom) async {
    final initial = isFrom ? (_fromDate ?? DateTime.now()) : (_toDate ?? _fromDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.white,
              surface: Color(0xFF1E293B),
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFrom) {
          _fromDate = picked;
          if (_toDate != null && _toDate!.isBefore(picked)) {
            _toDate = picked;
          }
        } else {
          _toDate = picked;
        }
      });
      _recalculateDays();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_fromDate == null || _toDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select both dates'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_selectedEmployeeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an employee'), backgroundColor: Colors.red),
      );
      return;
    }
    if (_selectedLeaveTypeId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a leave type'), backgroundColor: Colors.red),
      );
      return;
    }

    final data = <String, dynamic>{
      'employeeId': _selectedEmployeeId,
      'leaveTypeId': _selectedLeaveTypeId,
      'fromDate': _formatDate(_fromDate!),
      'toDate': _formatDate(_toDate!),
      'numberOfDays': _numberOfDays,
      'isHalfDay': _isHalfDay,
      'halfDayType': _isHalfDay ? _halfDayType : null,
      'reason': _reasonController.text,
    };

    final provider = Provider.of<LeaveProvider>(context, listen: false);
    bool success;

    if (_isEditMode) {
      final editItem = widget.editItem!;
      data['id'] = editItem.id;
      data['status'] = editItem.status;
      data['approvedBy'] = editItem.approvedBy;
      data['approvedAt'] = editItem.approvedAt;
      data['rejectionReason'] = editItem.rejectionReason;
      success = await provider.updateLeaveRequest(editItem.id, data);
    } else {
      success = await provider.createLeaveRequest(data);
    }

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_isEditMode ? 'Leave request updated!' : 'Leave request submitted!'),
          backgroundColor: Colors.green,
        ));
        Navigator.of(context).pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save request'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(_isEditMode ? 'Edit Leave Request' : 'Apply for Leave', style: const TextStyle(fontWeight: FontWeight.bold)),
        foregroundColor: Colors.white,
      ),
      body: Consumer2<LeaveProvider, EmployeeProvider>(
        builder: (context, provider, empProvider, _) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Employee Dropdown
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Employee', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedEmployeeId,
                          dropdownColor: const Color(0xFF1E293B),
                          style: const TextStyle(color: Colors.white),
                          isExpanded: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2))),
                            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF6366F1))),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                          hint: Text(empProvider.isLoading ? 'Loading...' : 'Select Employee', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                          validator: (v) => v == null ? 'Required' : null,
                          items: empProvider.employeeLookup.map((e) {
                            return DropdownMenuItem(value: e.id, child: Text(e.fullName, overflow: TextOverflow.ellipsis));
                          }).toList(),
                          onChanged: _isEditMode ? null : (v) => setState(() => _selectedEmployeeId = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Leave Type Dropdown
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Leave Type', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                        const SizedBox(height: 8),
                        DropdownButtonFormField<String>(
                          value: _selectedLeaveTypeId,
                          dropdownColor: const Color(0xFF1E293B),
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFF6366F1)),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                          hint: Text('Select Leave Type', style: TextStyle(color: Colors.white.withValues(alpha: 0.4))),
                          validator: (v) => v == null ? 'Required' : null,
                          items: provider.leaveTypes.map((lt) {
                            return DropdownMenuItem(
                              value: lt.id,
                              child: Text('${lt.code} - ${lt.name}'),
                            );
                          }).toList(),
                          onChanged: (v) => setState(() => _selectedLeaveTypeId = v),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Date Selection
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Duration', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: _buildDateField('From Date', _fromDate, () => _pickDate(context, true)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _buildDateField('To Date', _toDate, () => _pickDate(context, false)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Number of Days: ${_numberOfDays.toStringAsFixed(_numberOfDays % 1 == 0 ? 0 : 1)}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Half Day Toggle
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Half Day', style: TextStyle(color: Colors.white, fontSize: 16)),
                            Switch(
                              value: _isHalfDay,
                              activeColor: const Color(0xFF6366F1),
                              onChanged: (v) {
                                setState(() {
                                  _isHalfDay = v;
                                  if (v) {
                                    _numberOfDays = 0.5;
                                    _halfDayType ??= 'First';
                                  } else {
                                    _halfDayType = null;
                                    _recalculateDays();
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                        if (_isHalfDay) ...[
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              _buildHalfDayChip('First', 'First Half'),
                              const SizedBox(width: 12),
                              _buildHalfDayChip('Second', 'Second Half'),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Reason
                  GlassCard(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Reason', style: TextStyle(fontSize: 12, color: Colors.white.withValues(alpha: 0.6))),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _reasonController,
                          maxLines: 3,
                          style: const TextStyle(color: Colors.white),
                          validator: (v) => (v == null || v.isEmpty) ? 'Reason is required' : null,
                          decoration: InputDecoration(
                            hintText: 'Enter reason for leave...',
                            hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: const BorderSide(color: Color(0xFF6366F1)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Submit Button
                  ElevatedButton(
                    onPressed: provider.isLoading ? null : _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6366F1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: provider.isLoading
                        ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text(
                            _isEditMode ? 'Update Leave Request' : 'Submit Leave Request',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, size: 16, color: Color(0xFF6366F1)),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontSize: 10, color: Colors.white.withValues(alpha: 0.5))),
                Text(
                  date != null ? _formatDate(date) : 'Select',
                  style: TextStyle(color: date != null ? Colors.white : Colors.white.withValues(alpha: 0.4)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHalfDayChip(String value, String label) {
    final isSelected = _halfDayType == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _halfDayType = value),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6366F1).withValues(alpha: 0.3) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected ? const Color(0xFF6366F1) : Colors.white.withValues(alpha: 0.2),
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? const Color(0xFF6366F1) : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
